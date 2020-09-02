import netifaces
import time
import threading
import os
from scapy.all import *
from pyfiglet import Figlet
import random
import argparse
import logging
class startup():
    def __init__(self,OS='linux',mode='defensive',reset_da_iface=0,unlink_all_ifaces=0,iface=None, da_iface=None,command=None):
        self.iface=None
        self.da_iface=da_iface
        self.gateway_IP=None
        self.iface_MAC=None
        self.reset_da_iface=reset_da_iface
        self.OS=OS.upper()
        self.mode=mode.upper()
        self.unlink_all_ifaces=unlink_all_ifaces
        self.command=command
        if iface in netifaces.interfaces():
            self.iface=iface
            self.iface_MAC=scapy.all.get_if_hwaddr(self.iface)
        else:
            raise Exception('Invalid network iterface %s'%iface)
        for network in netifaces.gateways()[2]:
            if self.iface in network:
                self.gateway_IP=network[0]
                logging.debug('self.gateway_IP - %s', self.gateway_IP)
                self.gateway_MAC = self.get_mac_address(ip=self.gateway_IP)
                logging.debug('self.gateway_MAC - %s', self.gateway_MAC)

    def get_mac_address(self,ip):
        arp_request = scapy.all.ARP(pdst=ip, )
        broadcast = scapy.all.Ether(dst="ff:ff:ff:ff:ff:ff")
        arp_request_broadcast = broadcast / arp_request
        response = scapy.all.srp(arp_request_broadcast, timeout=1,verbose=False, iface=self.iface)[0]
        return response[0][1].hwsrc
    def do_active_scan(self,interval=1):
        while True:
            if self.get_mac_address(ip=self.gateway_IP) == self.gateway_MAC:
                logging.debug('recvd MAC id of gateway is same as self.gateway_MAC')
            else:
                if self.mode == 'DEFENSIVE':
                    logging.debug('entering defensive mode')
                    defense_mode_thread = threading.Thread(target=self.defensive_mode,
                                                           args=(self.unlink_all_ifaces, self.command))
                    defense_mode_thread.start()
                    logging.debug('defensive_mode_thread started')
                elif self.mode == 'OFFENSIVE':
                    logging.debug('entering offensive mode')
                    offense_mode_thread = threading.Thread(target=self.offensive_mode, args=self.da_iface)
                    offense_mode_thread.start()
                    logging.debug('offensive_mode_thread started')
            logging.debug('sleeping for %s seconds'%str(interval))
            time.sleep(interval)

    def do_passive_scan(self):
        logging.debug('starting passive scan')
        sniff(iface=self.iface, prn=self.pkt_callback, filter='host  %s'%self.gateway_IP)

    def pkt_callback(self,pkt):
        if pkt['Ethernet'].src!=self.gateway_MAC and pkt['Ethernet'].src!=self.iface_MAC:
            print('MAC address changed',pkt['Ethernet'].src, pkt['Ethernet'].dst)

            if self.mode == 'DEFENSIVE':
                logging.debug('entering defensive mode')
                defense_mode_thread= threading.Thread(target=self.defensive_mode, args=(self.unlink_all_ifaces, self.command))
                defense_mode_thread.start()
                logging.debug('defensive_mode_thread started')
            elif self.mode == 'OFFENSIVE':
                logging.debug('entering offensive mode')
                offense_mode_thread= threading.Thread(target=self.offensive_mode , args=self.da_iface)
                logging.debug('offensive_mode_thread started')
                offense_mode_thread.start()

            self.attacker_MAC=str(pkt['Ethernet'].src)
            logging.debug('Attackers MAC ID is %s'%self.attacker_MAC)
            attacker_mac_vendor_id=str(pkt['Ethernet'].src).replace(':','')[0:6].upper()
            print('Attackers MAC ID is :',self.attacker_MAC)
            mac_vendor_file=open('mac_vendors.txt','r')
            for line in mac_vendor_file:
                if attacker_mac_vendor_id in line[0:7]:
                    print('Spoofer\'s MAC ID and vendor is ',line)
        else:
            print('No Problem',pkt['Ethernet'].src, pkt['Ethernet'].dst)

    def defensive_mode(self,unlink_all_ifaces=1,command=None):
        if self.OS == 'LINUX':
            if unlink_all_ifaces:
                for network in netifaces.gateways()[2]:
                    os.system('sudo ip link set dev %s down'% network[1])
                    logging.debug('running command - "ip link set dev %s down"'%network[1])
            else:
                os.system('sudo ip link set dev %s down'%self.iface)
                logging.debug('running command - "ip link set dev %s down"' % self.iface)
        elif self.OS == 'WINDOWS':
            pass
        if command is not None:
            os.system(command)
            logging.debug('running provided command - "%s"'%command)

    def offensive_mode(self,da_iface=None):
        self.create_deauth_packets()
        if self.OS=='linux':
            print('Setting %s to monitor mode!'%da_iface)
            if not os.system('sudo ip link set dev %s down'%da_iface):
                if not os.system('sudo iwconfig %s mode monitor'%da_iface):
                    if not os.system('sudo ip link set dev %s up' % da_iface):
                        print('%s is now running on monitor mode.'%da_iface)
                        print('Sending deauthentication packets to %s'%self.attacker_MAC)
                        while True:
                            logging.debug('sending deauth packets')
                            self.send_deauth_packets()

    def create_deauth_packets(self):
        self.deauth_pkt = RadioTap() / Dot11(addr1=self.gateway_MAC, addr2=self.attacker_MAC, addr3=self.attacker_MAC) / Dot11Deauth(reason=7)

    def send_deauth_packets(self,iface):
        try:
            sendp(self.deauth_pkt, iface=iface,verbose=1,inter=0.1,count=100)
        except KeyboardInterrupt:
            if self.reset_da_face:
                self.reset_interface(iface=self.da_iface)
            else:
                print('Stopped sending Deauthentication packets to %s',self.attacker_MAC)
                if self.reset_da_iface:
                    self.reset_interface(iface=self.iface)
    def reset_interface(self,iface=None):
        if not iface:
            iface = self.da_iface
        if self.os == 'LINUX':
            print('Setting %s to managed mode!' % iface)
            if not os.system('ip link set dev %s down' % iface):
                if not os.system('sudo iwconfig %s mode monitor' % iface):
                    if not os.system('ip link set dev %s up' % iface):
                        print('Interface set to managed mode')

if __name__== "__main__":
    logging.basicConfig(level=logging.DEBUG)
    #font=['colossal','doom','doh','isometric3','poison']

    f = Figlet(font='slant')
    print(f.renderText('shARPy'))

    parser = argparse.ArgumentParser()
    parser.add_argument('-m', '--mode', type=str,default='defensive', help='Set response mode')
    parser.add_argument('-s', '--scan', type=str,default='passive', help='Set scanning method')
    parser.add_argument('-t', '--time_interval', type=int,default=1, help='Set scanning interval')
    parser.add_argument('-o', '--OS', type=str, default='linux', help='Operating System')
    parser.add_argument('-i', '--net_iface', type=str, default=None, help='Network interface')
    parser.add_argument('-d', '--da_iface', type=str, default=None, help='Deauth interface')
    parser.add_argument('-u', '--unlink_all_ifaces', type=str, default='', help='Disconnect all interfaces connected to this network')
    parser.add_argument('-r', '--reset_da_iface', type=str, default=False, help='Reset deauth interface ')
    parser.add_argument('-c', '--command', type=str, default=None, help='Explicitly give commands to respond in case spoofing is detected.')

    mode = parser.parse_args().mode
    unlink_all_ifaces = parser.parse_args().unlink_all_ifaces
    scan=parser.parse_args().scan
    OS=parser.parse_args().OS
    interval= parser.parse_args().time_interval
    net_iface = parser.parse_args().net_iface
    da_iface= parser.parse_args().da_iface
    reset_da_iface= parser.parse_args().reset_da_iface
    command=parser.parse_args().command


    start = startup(iface=net_iface,da_iface=da_iface, OS=OS,reset_da_iface=reset_da_iface,mode=mode,unlink_all_ifaces=unlink_all_ifaces,
                    command=command)

    if scan.upper() == 'ACTIVE':
        logging.debug('Active mode selected')
        active_scanner_thread = threading.Thread(target=start.do_active_scan,args=(interval,))
        active_scanner_thread.start()
    elif scan.upper() == 'PASSIVE':
        logging.debug('Passive mode selected')
        passive_scanner_thread = threading.Thread(target=start.do_passive_scan)
        passive_scanner_thread.start()
    else:
        print("Error: Wrong scanning mode.")
        exit()
