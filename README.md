<p align="center">The IP Sweeper Script</p>
<h1 align="center"><i>A welled detailed explanation of the IP(Internet Address) sweeper script written in Bash for Linux.</i></h1>

- This [script](/ip_sweeper.sh 'ip_sweeper.sh file') designed to scan a range of IP addresses, typically within a specified subnet, to determine which IPs are active and responsive on a network. The primary purpose is to discover live hosts and filter out those that are reachable. The script uses the Internet Control Message Protocol (ICMP), often associated with the `ping` command, to send a simple network message (ping) to each IP address in the given range.

### To get started
- Clone the [Repository](https://github.com/CYBWithFlourish/IP-Sweeper-Script.git  'Projects Repo') i.e. `git clone https://github.com/CYBWithFlourish/IP-Sweeper-Script.git` or download the [`ip_sweeper.sh`](/ip_sweeper.sh 'ip_sweeper.sh file') script.
- Navigate to the project directory using the `cd` command i.e. `cd IP-Sweeper-Script` or to where you downloaded the script file.
- Run the script with the folowing command.
   `./ip_sweeper.sh [First three ranges of your IP]`
   >This will run the file and sweep all the active ip's in the given range in the script.
   >>i.e. `./ip_sweeper.sh 192.186.1`

<p align='center'>The script</p>

```sh
#!/bin/bash
for ip in `seq 1 254 `; do
ping -c 1 $1.$ip | grep "64 bytes" | cut -d "" -f 4 |tr -d ":" &
done
```