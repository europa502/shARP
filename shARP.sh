#! /bin/bash 



echo "				           ||                               _______       _______       "     
echo "				           ||                  /\          |        ?    |        ?     "
echo "				           ||                 /  \         |         ?   |         ?    "
echo "				           ||                /    \        |         ?   |         ?    "
echo "				     //    ||-------        /      \       |________?    |________?     "
echo "				    //     ||      ||      /--------\      |     \       |              "
echo "				   //_____ ||      ||     /          \     |      \      |              "
echo "				        // ||      ||    /            \    |       \     |             "
echo "				       //  ||      ||   /              \   |        \    |             "
echo "				      //   ||      ||  /                \  |         \   |             "
echo "	__________________________________________________________________________________________________________________	  		    				       		                       "
 



arg=$1
interface=$2
if [ " $arg " = ' -r ' ] || [ " $arg " = ' --reset ' ]; then
interfacemon=$interface'mon'
airmon-ng stop $interfacemon ; 
ifconfig $interface down ; 
ifconfig $interface up ;
service network-manager restart ; 
sleep 10
#==================================================================================================================================================
else if
 [ " $arg " = ' -d ' ] || [ " $arg " = ' --defence ' ]; then
 gtping=`ping gateway -c 1`
 gtping=${gtping%gateway*} #retain the part before gateway
 gtping=${gtping%gateway*} #retain the part before gateway
 gtping=${gtping%gateway*} #retain the part before gateway
  
 if [ " $gtping " = " PING  " ] ; then 
  MYVAR=`sudo arp gateway -i $interface `
  add=${MYVAR%C*}  # retain the part after the C
  add=${add##*r}  # retain the part before the ether
  if [  /usr/shARP/ = false ] && [/usr/shARP/ != true ]; then
    sudo mkdir /usr/shARP 
  fi 
  echo  $(date +"%D") ": DEFENSIVE MODE : The original address of the gateway is " $add >> /usr/shARP/gateway.txt
  arp gateway -i $interface
  arpout=`arp gateway -i $interface`
  echo ............................................................................................................................................
  arpd=$add
  carpd=$arpd
  carpd=${carpd//[ ]/}
  vendor=${carpd//[:]/}
  vendor=${vendor:0:6}
  while read line
                                       do macid=${line:0:6}
					   vendor="${vendor^^}"
                                       if [ " $macid " = " $vendor " ]
				        then 
                                         echo "Your current gateway is " $add " and your MAC Vendor is " ${line:(+6)}
                                          
                                       fi
				       
                                       done < mac-vendors.txt

  echo ........................................................................................................................................... 
	while true
		do	

			output=`sudo arp gateway -i $interface`
			carpd=${output%C*}  # delete the part after the C
			carpd=${carpd##*r}  # delete the part before the ether
			arpd=${arpd//[ ]/}
			carpd=${carpd//[ ]/}
			
			if [ " $arpd " != " $carpd " ]; then
				echo "gateway changed from " $arpd " to " $carpd " at time " $(date +"%T") 
				echo $carpd "is spoofing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! "
  				echo "network connection going down "
				ifconfig $interface down
				
                                vendor=${carpd//[:]/}
                                vendor=${vendor:0:6}
                                while read line
                                       do macid=${line:0:6}
					   vendor="${vendor^^}"
                                       if [ " $macid " = " $vendor " ]
				        then 
                                         echo "MAC Vendor of the attacker is " ${line:(+6)}
                                          macvendor=${line:(+6)}
                                       fi
				
                                       done < mac-vendors.txt
				echo "gateway changed from" $arpd " to" $carpd " at time " $(date +"%T") " on " $(date +"%D") "The attacker's MAC vendor is " $macvendor >> /usr/shARP/log.txt  
				espeak  'network is being spoofed by '$carpd', connection, going down. Contact your network administrator.' 
				exit         
			fi ; done;  else echo "gateway not found"
   fi
#==================================================================================================================================================

else if [ " $arg " = ' -o ' ] || [ " $arg " = ' --offence ' ]; then 
   gtping=`ping gateway -c 1`
   gtping=${gtping%gateway*} #retain the part before gateway
   gtping=${gtping%gateway*} #retain the part before gateway
   gtping=${gtping%gateway*} #retain the part before gateway
  
   if [ " $gtping " = " PING  " ] ; then 
    output=`sudo arp gateway -i $interface `
    add=${output%C*}  # retain the part after the C
    add=${add##*r}  # retain the part before the ether

    if [  /usr/shARP/ = false ] && [/usr/shARP/ != true ]; then
      mkdir /usr/shARP/
    fi

    echo $(date +"%D") " : OFFENSIVE MODE : The original address of the gateway is " $add >> /usr/shARP/gateway.txt
    arp gateway -i $interface
    echo .................................................................................................................................................
    arpd=$add
    carpd=$arpd
    carpd=${carpd//[ ]/} 
    vendor=${carpd//[:]/}
    vendor=${vendor:0:6}
    while read line
                                       do macid=${line:0:6}
					   vendor="${vendor^^}"
                                       if [ " $macid " = " $vendor " ]
				        then 
                                         echo "Your current gateway is " $add " and your MAC Vendor is " ${line:(+6)}
                                          
                                       fi
				       
                                       done < mac-vendors.txt
   echo ................................................................................................................................................. 
   while true
		do
			
			MYVAR=`sudo arp gateway -i $interface`

			carpd=${MYVAR%C*}  # retain the part after the C
			carpd=${carpd##*r}  # retain the part before the ether
			arpd=${arpd//[ ]/}
			carpd=${carpd//[ ]/}
			
			if [ " $arpd " != " $carpd " ]; then 
				echo "gateway changed from " $arpd " to " $carpd " at time " $(date +"%T") 
				echo $carpd "is spoofing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! "
  				echo "network connection going down "
				
				
                                vendor=${carpd//[:]/}
                                vendor=${vendor:0:6}
                                while read line
                                       do macid=${line:0:6}
                                       if [ " $macid " = " $vendor " ]
				        then 
                                         echo "MAC Vendor of the attacker is " ${line:(+6)} 
					macvendor=${line:(+6)}                                       
					fi
				       done < mac-vendors.txt
                           
                         echo "gateway changed from " $arpd " to " $carpd " at time " $(date +"%T") " on " $(date +"%D") "The attacker's MAC vendor is " $macvendor >> /usr/shARP/log.txt 
			
			hash aircrack-ng >> /usr/shARP/hash1.txt 
			hash airmon-ng >> /usr/shARP/hash2.txt 
			r1hash=$(cat /usr/shARP/hash1.txt)
			r2hash=$(cat /usr/shARP/hash2.txt)
			if [ " $r2hash " = "bash: hash: airmon-ng: not found" ] || [ " $r1hash " = "bash: hash: aircrack-ng: not found" ] ;then
        	  
			sudo apt-get install aircrack-ng
        			
			echo "airmon-ng and aircrack-ng are starting"
		else 
			echo "airmon-ng and aircrack-ng are starting"
		fi
			sudo airmon-ng start $interface
			sudo airmon-ng check kill 
			while true 
			  do sudo aireplay-ng -0 1000 -a $arpd -c $carpd $interface'mon' 
			done
			exit
		fi;done ; else echo "gateway not found" ; fi 
   
 	else if [ " $arg " = ' -h ' ] || [ " $arg " = ' --help ' ]; then
		echo "bash ./shARP.sh --[option] [interface] "
		echo "[option]"
		echo ""
		echo "-d OR --defence = defend your system from arp spoofing or man in the middle attacks"
		echo ""
		echo "-o OR --offence = remove the arp spoofer from the network :WARNING: network inteface would go down while removing the spoofer " 
        	echo "	          from the network. aircrack-ng would get installed in your system if not present beforehand." 
        	echo "                  An active internet connection would be required for this purpose "  
		echo ""
		echo "-r OR --reset   = reset network interface card and network manager (suggested to use after operating the offensive mode.)"
		echo ""
		echo "[interface]  = the network device you are currently using "
	
	   else 
		echo "use bash ./shARP.sh -[option] ........... use bash ./shARP.sh -h for help"
   
fi ;fi; fi;fi



