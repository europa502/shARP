
import socket, sys,os,re
 
from struct import *
mymac=sys.argv[1]
rmac=sys.argv[2]
interface=sys.argv[3]
mode=sys.argv[4]
def address (a) :
  b = "%.2x:%.2x:%.2x:%.2x:%.2x:%.2x" % (ord(a[0]) , ord(a[1]) , ord(a[2]), ord(a[3]), ord(a[4]) , ord(a[5]))
  return b
 
try:
    s = socket.socket( socket.AF_PACKET , socket.SOCK_RAW , socket.ntohs(0x0003))
except socket.error , msg:
    print 'Socket could not be created. Error Code : ' + str(msg[0]) + ' Message ' + msg[1]
    sys.exit()
 
while True:
   
    packet = s.recvfrom(65565)
     
    packet = packet[0]
     

    pack_length = 14
     
    pack_header = packet[:pack_length]
    pack = unpack('!6s6sH' , pack_header)
    pack_protocol = socket.ntohs(pack[2])
    #print 'Destination MAC : ' + address(packet[0:6]) + ' Source MAC : ' + address(packet[6:12]) 
    #print rmac, interface , mode
    
    router_mac=re.sub(r':',"",rmac)
    pc_mac=re.sub(r':',"",mymac)
    router_mac= router_mac[:-6]
    
    if mymac == address(packet[0:6]) : 
    	if rmac != address(packet[6:12]) and rmac != "01005e" and rmac != "ffffff" and rmac != "333300":
    		os.system("bash ./passive.sh '"+rmac+"' '"+interface+"' '"+mode+"' ")
    		 	
    		 
    		
    elif mymac == address(packet[6:12]) :
    	if rmac != address(packet[0:6]) and rmac != "01005e" and rmac != "ffffff" and rmac != "333300":
    		os.system("bash ./passive.sh '"+rmac+"' '"+interface+"' '"+mode+"' ")
    		 	
     
    		
    		
