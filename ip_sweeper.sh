#!/bin/bash

echo ".__                                                                      .__     "
echo "|__|_____       ________  _  __ ____   ____ ______   ___________    _____|  |__  "
echo "|  \____ \     /  ___/\ \/ \/ // __ \_/ __ \\____ \_/ __ \_  __ \  /  ___/  |  \\ "
echo "|  |  |_> >    \___ \  \     /\  ___/\  ___/|  |_> >  ___/|  | \/  \___ \|   Y  \\"
echo "|__|   __/____/____  >  \/\_/  \___  >\___  >   __/ \___  >__| /\ /____  >___|  /"
echo "    |__| /_____/    \/              \/     \/|__|        \/     \/      \/     \/ "
echo "                                            by CYBWithFlourish."

spinner() {
  local pid=$1
  local delay=0.1
  local spinstr='|/-\'
  while ps -p $pid > /dev/null; do
    for i in $(seq 0 3); do
      echo -ne "\b${spinstr:$i:1}"
      sleep $delay
    done
  done
  echo -ne "\b"
}

echo -n "Processing ping sweep... "

#To store output on a text file, create an array to store responsive IP addresses
#responsive_ips=()

{
# Loop through IP addresses    
  for ip in $(seq 1 254); do
    ping -c 1 "$1.$ip" | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
    #if ping -c 1 $1.$ip | grep "64 bytes" > /dev/null; then
    #    echo "$1.$ip responded to ping"
    #    responsive_ips+=("$1.$ip")
    #fi 
  done
} &

# Save reesponsive IPs to a text file
# if [ ${#responded_ips[@]} -eq 0 ]; then
#   echo "No devices found." > output.txt
# else
#   echo "${responsive_ips[@]}" > output.txt
# fi

spinner $!

wait
echo "Ping sweep done!"
