
                     ||                               _______       _______          
                     ||                  /\          |        ?    |        ?     
                     ||                 /  \         |         ?   |         ?    
                     ||                /    \        |         ?   |         ?    
               //    ||-------        /      \       |________?    |________?     
              //     ||      ||      /--------\      |     \       |              
             //_____ ||      ||     /          \     |      \      |              
                  // ||      ||    /            \    |       \     |             
                 //  ||      ||   /              \   |        \    |             
                //   ||      ||  /                \  |         \   |             
 ____________________________________________________________________________________	  		   
				       		                       
 



# Description-

ARP spoofing allows an attacker to intercept data frames on a network, modify the traffic, or stop all traffic. Often the attack is used as an opening for other attacks, such as denial of service, man in the middle, or session hijacking attacks. This anti- ARP spoofing program, (shARP) detects the presence of a third party in a private network actively. It has 2 mode: defensive and offensive. 

**Previous Releases** - [shARP_1.0](https://github.com/europa502/shARP/releases/tag/v1.0)

# Prerequisites -

	-Linux distro
	-Python 2.7.x
	-Aircrack-ng
	-espeak (optional)
	-Network card that supports monitor mode and packet injection

You can check if your linux wireless driver supports these functionalities from this [page](https://wireless.wiki.kernel.org/en/users/drivers) 

**What's new ?**

shARP_2.0 can perform active scan as well as passive scans in both defensive and offensive modes.

**Defensive mode** - Defensive mode protects the end user from the spoofer by disconnecting the user's system from the network. This mode also alerts the user by an audio message as soon as spoofing is detected. 

**Offensive mode** - Offensive mode disconnects the user's system from the network and further kicks out the attacker by sending De-authentication packets to his system, this doesn't let him reconnect to the network until the program is manually reset. 

**Active Scan** - Use when your system is left idle most of the time. Active scan is most efficient method to protect you system and the network from ARP-spoofing incidents.

**Passive Scan** - Use when your system is busy transferring data through the network. Passive scan is efficient in for constant data transfering devices as your device and the network would be secured from ARP-spoofing incidents without compromising the speed or the network bandwidth.

**Help**
```bash
bash ./shARP.sh -h
```
![screenshot from 2017-05-14 21-24-35](https://cloud.githubusercontent.com/assets/26405791/26035852/2deac44c-38f1-11e7-9782-1b99456ae6a5.png)

**Defensive mode with active scanning**
```bash 
bash ./shARP.sh -d -a wlan0
```
![screenshot from 2017-05-14 21-25-30](https://cloud.githubusercontent.com/assets/26405791/26035891/c04506d6-38f1-11e7-8cbb-3a2a3a7cf500.png)
 

**Defensive mode with Passive scanning**

```bash
bash ./shARP.sh -d -p wlan0

```

![screenshot from 2017-05-14 21-26-24](https://cloud.githubusercontent.com/assets/26405791/26035897/d38c33ea-38f1-11e7-8bcf-68e5900f02d4.png)

**Offensive mode with Active scan**
```bash
bash ./shARP.sh -o -a wlan0
```
![screenshot from 2017-05-14 21-27-53](https://cloud.githubusercontent.com/assets/26405791/26035913/32030688-38f2-11e7-99c2-6cfc8cf41f9f.png)

![screenshot from 2017-05-14 21-28-47](https://cloud.githubusercontent.com/assets/26405791/26035922/41b40fbe-38f2-11e7-937d-c94e96bf6ccf.png)

**Offensive mode with Passive scan**
```bash
bash ./shARP.sh -o -p wlan0
```

![screenshot from 2017-05-14 21-29-45](https://cloud.githubusercontent.com/assets/26405791/26035927/48b349ec-38f2-11e7-843d-e564fdd4a129.png)

![screenshot from 2017-05-14 21-29-54](https://cloud.githubusercontent.com/assets/26405791/26035931/5943b40e-38f2-11e7-9513-b4b5926f7d9b.png)


**Reset Network Card** 
```bash 
bash ./shARP.sh -r wlan0
```

Reset your network card only when used with active mode or when the network adaptor doesn't work properly. Else you can switch back on your network connection manually.

![screenshot from 2017-05-14 21-25-53](https://cloud.githubusercontent.com/assets/26405791/26035935/6aa653be-38f2-11e7-93a4-eae4e22afbf9.png)


# Records-

The program creates a log file in the folder /usr/shARP/ containing the details of the attack such as the attackers mac address, mac vendor, time and date of the attack. 

One can identify the NIC of the attacker's system with the help of the obtained mac address. The whole program is designed specially for linux and is written in bash and python. In the offensive mode the program downloads an open-source application from with the permission of the user namely aircrack-ng (if not present in the user's system already). Visit https://www.aircrack-ng.org for more info.

# Edits-
If you wish to get an audio alert please download **espeak** or **comment out those lines** in the source code.


# Note-

1. I won't suggest using this software over wired connections, especially in offensive mode as it might cause network instability.
2. Use the offensive mode only with the NICs that supports monitor mode.
3. Offensive mode does DOS attack on the ARP-spoofer. Use Offensive mode only after making sure that you have appropriate right(s) over the network and the device(s) connected to it and make sure that doing so is legal in your Country/State.
4. Offensive mode will not work if your wifi card/driver doesn't support packet injection.

