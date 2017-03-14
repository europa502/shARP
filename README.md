

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
				       		                       
 









Description-

 
ARP spoofing allows an attacker to intercept data frames on a network, modify the traffic, or stop all traffic. Often the attack is used as an
opening for other attacks, such as denial of service, man in the middle, or session hijacking attacks.Our anti- ARP spoofing program,
(ShARP) detects the presence of a third party in a private network in real time. It has 2 mode: defensive and offensive.
Defensive mode protects the end user from the spoofer by dissconnecting the user's system from the network and alerts the
user by an audio message. 
The offensive mode dissconnects the user's system from the network and further kicks out the attacker by sending de-authentication packets to his
system, unabling him to reconnect to the network until the program is manually reset. 
The program creates a log file (/usr/shARP/)containing the details of the attack such as, the attackers mac address, mac vendor time and date of 
the attack. We can identify the NIC of the attackers system with the help of the obtained mac address. If required the 
attacker can be permanently banned from the network by feeding his mac address to the block list of the router.
The whole program is designed specially for linux and is writen in Linux shell command (bash command). In the offensive mode the program downloads
two open-source applications from the internet with the permission of the user namely aircrack-ng  (if not present
in the user's system already ). Both of these applications are written in python language.

If the user wants to secure his network by scanning for any attacker he can run the program. the program offers a simple command line interface
which makes it easy for the new users.the user can directly access the defensive or offensive mode by inputing the respective command line
arguments along with the execution code just as in  any other linux command to operate a software through CLI. In case the user inputs any wrong
command line argument, the program prompts the user to use the help option. the help option provides the details about the two modes. 
when the user runs the program in defensive mode, he recieves the original mac address of the gateway. If there is no man in the middle attack, the
screen stays idle. As soon as the program detects a spoofer in the network, it outputs the mac address of the spoofer and the time of the attack.
It then dissconnects the users's system from the network so as to protect the private data being transfered between the system and the server. It
also saves a log file about the attacker for further use. when the user runs the program in offensive mode,he recieves the original mac address of
the gateway. If there is no man in the middle attack, the screen stays idle. As soon as the program detects a spoofer in the network, it outputs
the mac address of the spoofer and the time of the attack as in the defensive mode. But further, the program puts the user's Network Interface Card
to monitor mode with the help of the application 'Airmon-ng'. Then the application 'Aircrack-ng' gets activated and starts sending deauthentication
packets to the attacker's system. This process kicks out the attacker from the network. The program also creates a log file about the attack.

How to use - 

bash ./shARP.sh -r [interface] to reset the network card and driver.

bash ./shARP.sh -d [interface] to activate the program in defense mode.

bash ./shARP.sh -o [interface] to activate the program in offense mode.

bash ./shARP.sh -h             for help.

