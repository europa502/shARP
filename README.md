

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

**Defensive** mode protects the end user from the spoofer by disconnecting the user's system from the network. This mode also alerts the user by an audio message as soon as spoofing is detected.
![def](https://cloud.githubusercontent.com/assets/26405791/25932513/4d365eca-362f-11e7-8d2c-6dc19aed0c4e.png)

![defcom](https://cloud.githubusercontent.com/assets/26405791/25932547/83154a4c-362f-11e7-85ac-04e56f890136.png)


**Offensive** mode disconnects the user's system from the network and further kicks out the attacker by sending De-authentication packets to his system, this doesn't let him reconnect to the network until the program is manually reset. 
![of](https://cloud.githubusercontent.com/assets/26405791/25932564/9f54b62a-362f-11e7-9e01-ca1c7e94ef5e.png)

![offen](https://cloud.githubusercontent.com/assets/26405791/25932577/b232564e-362f-11e7-9c45-4ab2752b39fe.png)

![ofcom](https://cloud.githubusercontent.com/assets/26405791/25932584/c4b77b00-362f-11e7-981f-17160a2f4a2d.png)

# Records

The program creates a log file (/usr/shARP/)containing the details of the attack such as the attackers mac address, mac vendor, time and date of the attack. 

We can identify the NIC of the attackers system with the help of the obtained mac address. The whole program is designed specially for linux and is written in Linux shell command (bash command). In the offensive mode the program downloads an open-source application from with the permission of the user namely aircrack-ng (if not present in the user's system already). Since this is written in python language, you must have python installed on your system for it to work. Visit https://www.aircrack-ng.org for more info.

# Edits-
If you wish to get an audio alert please download **espeak** or **comment out those lines** in the source code.

# How to use 

![help](https://cloud.githubusercontent.com/assets/26405791/25932600/dfc234d0-362f-11e7-9155-1bb9c68ce4cb.png)

 
bash ./shARP.sh -r [interface] to reset the network card and driver.

bash ./shARP.sh -d [interface] to activate the program in defense mode.

bash ./shARP.sh -o [interface] to activate the program in offense mode.

bash ./shARP.sh -h for help.

