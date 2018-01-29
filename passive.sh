
arpd=$1
interface=$2
mode=$3
#echo $arpd; echo  $interface ; echo $mode
if [ " $mode " = ' -d ' ] || [ " $mode " = " --defence " ]; then
	output=`arp gateway -i $interface`
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
				fi	

elif [ " $mode " = ' -o ' ] || [ " $mode " =  " --offence " ] ; then 
	
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
					#espeak  'network is being spoofed by '$carpd', connection, going down. Starting DOS attack ..........' 
					          
				 
			  
			
				hash aircrack-ng >> /usr/shARP/hash1.txt 
				hash airmon-ng >> /usr/shARP/hash2.txt 
				r1hash=$(cat /usr/shARP/hash1.txt)
				r2hash=$(cat /usr/shARP/hash2.txt)
			
				if [ " $r2hash " = "bash: hash: airmon-ng: not found" ] || [ " $r1hash " = "bash: hash: aircrack-ng: not found" ] ;then
        	  			sudo apt-get install aircrack-ng
        				echo "airmon-ng and aircrack-ng are starting"
			 
				fi
				sudo airmon-ng start $interface  
				sudo airmon-ng check kill 
				sudo airmon-ng start $interface'mon' $channel
				while true 
				  do sudo aireplay-ng -0 1000 -a $arpd -c $carpd  $interface'mon' 
				done
				exit
				fi ;
else echo "not available"				
fi							
