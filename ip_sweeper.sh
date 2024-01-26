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
{
  for ip in $(seq 1 254); do
    ping -c 1 "$1.$ip" | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
  done
} &

spinner $!

wait
echo "Ping sweep done!"
