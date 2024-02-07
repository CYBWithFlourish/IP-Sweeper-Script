#!/bin/bash

# Error handling and input validation
if [ $# -ne 1 ]; then
  echo "Usage: $0 <IP_PREFIX>"
  exit 1
fi

IP_PREFIX="$1"
if ! echo "$IP_PREFIX" | grep -qE '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$'; then
  echo "Error: Invalid IP prefix. Please provide a valid IP address prefix (e.g., 192.168.1)."
  exit 1
fi

echo ".__                                                                      .__     "
echo "|__|_____       ________  _  __ ____   ____ ______   ___________    _____|  |__  "
echo "|  \____ \     /  ___/\ \/ \/ // __ \_/ __ \\____ \_/ __ \_  __ \  /  ___/  |  \\ "
echo "|  |  |_> >    \___ \  \     /\  ___/\  ___/|  |_> >  ___/|  | \/  \___ \|   Y  \\"
echo "|__|   __/____/____  >  \/\_/  \___  >\___  >   __/ \___  >__| /\ /____  >___|  /"
echo "    |__| /_____/    \/              \/     \/|__|        \/     \/      \/     \/ "
echo "                                            by CYBWithFlourish."

echo "Responsive IP addresses:" > output.txt

# Ping sweep function with improved spinner functionality
ping_sweep() {
  local ip_prefix="$1"
  local ping_pids=()

  echo -n "Processing ping sweep... "

  # Loop through IP addresses
  for ip in $(seq 1 254); do
    if ping -c 1 "$ip_prefix.$ip" | grep -q "64 bytes"; then
      echo "$ip_prefix.$ip is up"
      echo "$ip_prefix.$ip" >> output.txt
    fi
  done

  # Save responsive IPs to a text file
  # if [ ${#responded_ips[@]} -eq 0 ]; then
  #   echo "No devices found." > output.txt
  # else
  #   echo "${responsive_ips[@]}" > output.txt
  # fi

  # Improve spinner functionality
  local spinner_pid
  spinner_pid=$!
  spinner $spinner_pid &

  # Wait for all background ping processes to complete
  wait

  # Kill the spinner process
  kill $spinner_pid

  echo "Ping sweep done!"
}

# Spinner function
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

# Call the ping_sweep function
ping_sweep "$IP_PREFIX"
exit 0