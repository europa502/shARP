

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
		_______________________________________________________________________________________	  		   
				       		                       
 


# Description-

ARP spoofing allows an attacker to intercept data frames on a network, modify the traffic, or stop all traffic. Often the attack is used as an opening for other attacks, such as denial of service, man in the middle, or session hijacking attacks. This anti- ARP spoofing program, (shARP) detects the presence of a third party in a private network actively. It has 2 mode: defensive and offensive. 

**Defensive** mode protects the end user from the spoofer by disconnecting the user's system from the network and alerts the user by an audio message as soon as spoofing is detected.
![defensive 1](https://github.com/europa502/shARP/tree/master/screenshots/def.png)
![defensive 2](https://github.com/europa502/shARP/tree/master/screenshots/defcom.png)


**Offensive** mode disconnects the user's system from the network and further kicks out the attacker by sending De-authentication packets to his system, doesn't him to reconnect to the network until the program is manually reset. 
![offensive 1](https://github.com/europa502/shARP/tree/master/screenshots/of.png)
![offensive 2](https://github.com/europa502/shARP/tree/master/screenshots/ofen.png)
![offensive 3](https://github.com/europa502/shARP/tree/master/screenshots/ofcom.png)


# Records

The program creates a log file (/usr/shARP/)containing the details of the attack such as, the attackers mac address, mac vendor time and date of the attack. 

We can identify the NIC of the attackers system with the help of the obtained mac address. The whole program is designed specially for linux and is written in Linux shell command (bash command). In the offensive mode the program downloads an open-source application from with the permission of the user namely aircrack-ng (if not present in the user's system already). Since this is written in python language, you must have python installed on your system for it to work. Visit https://www.aircrack-ng.org for more info.

# Edits-
If you wish to get an audio alert please download espeak or modify those lines in the source code.

# How to use 

![help option](https://github.com/europa502/shARP/tree/master/screenshots/help.png)

bash ./shARP.sh -r [interface] to reset the network card and driver.

bash ./shARP.sh -d [interface] to activate the program in defense mode.

bash ./shARP.sh -o [interface] to activate the program in offense mode.

bash ./shARP.sh -h for help.

