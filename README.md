<p align="center">The IP Sweeper Script</p>
<h1 align="center"><i>A welled detailed explanation of the IP(Internet Address) sweeper script written in Bash.</i></h1>

- This [script](/ip_sweeper.sh 'ip_sweeper.sh file') is designed to scan a range of IP addresses, typically within a specified subnet, to determine which IPs are active and responsive on a network. The primary purpose is to discover live hosts and filter out those that are reachable. The script uses the Internet Control Message Protocol (ICMP), often associated with the `ping` command, to send a simple network message (ping) to each IP address in the given range.

### To get started
- Clone the [Repository](https://github.com/CYBWithFlourish/IP-Sweeper-Script.git  'Projects Repo') i.e. `git clone https://github.com/CYBWithFlourish/IP-Sweeper-Script.git` or download the [`ip_sweeper.sh`](/ip_sweeper.sh 'ip_sweeper.sh file') script.
- Navigate to the project directory using the `cd` command i.e. `cd IP-Sweeper-Script` or to where you downloaded the script file.
  ><i>Some of the conditions to be met before running this script include:</i>
  >>- Ensure Bash is installed on your system. If your usind Linux or macOS, Bash is available by default. On Windows, you van use Git Bash or other tools (i.e. [Cygwin](https://www.cygwin.com/install.html), [Bash Shell for Windows](https://www.lifewire.com/install-bash-on-windows-10-4101773)).
  >>- The script heavily relies on the `ping` command which also comes pre-installed on most systems. You can verify its availability by running `ping` in your terminal.
  >>- For Unix-like Operating systems, Linux and macOS, make the script executable by running `chmod +x ip_sweeper.sh`.
  >>- Lastly, if your network uses a different IP range, adjust the range in the script accordingly. The script is currently set to iterate from 1 to 254, update the `seq` cammand in the script.
- Once your sure the above conditions are satisfied,  run the script with the folowing command.
   `./ip_sweeper.sh [First three ranges of your IP]`
   >This will run the file and sweep all the active ip's in the given range in the script.
   >>i.e. `./ip_sweeper.sh 192.186.1`

<p align='center'>Some fundamentals required to write and understand this script.</p>
 
- `grep` command.
   >It is used to search given file for patterns specified by the user. Basically `grep` lets you enter a pattern of text and it searches for this pattern within the text that you provide it.
   >>Note that the `grep` command is not used to extract sections from each file.
- `tr` command.
  >This command is used for translating or deleting characters.
- `cat` command.
  >The cat command allows us to create single or multiple files, the view containing the file, concatenate(add) files, and redirect output in terminal or files.
- `cut` command.
  >It is used to extract sections from each line of input -- usually from a file.
- `echo` command.
  >Used to print anything on the console.
- `if-else` command.
  >This commands is a very important part of programming/scripting which allows us to make some decisions based on some conditions.
- `for` Loops  - The `for` loop is a control flow statement in programming that allows code to be repeatedly executed. It is commonly used to iterate over lists or sequences of items, executing a specific set of instructions for each item in the list i.e. 
```sh
  for var in 0 1 2 3 4 5 6 7 8 9
do
  echo $var
done
```
<h3 align='center'>Output:</h3>
> It will print numbers from 0 to 9


<p align='center'>The script</p>

```sh
#!/bin/bash
for ip in $(seq 1 254); do
    ping -c 1 "$1.$ip" | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
  done
```
<p align='center'>The script explained and breaked down.</p>

> Now let's break down and try to understand the code.

- `#!/bin/bash` - It's basically a comment telling the computer, "Hey!, am a bash script".
- ```sh
  for ip in `seq 1 254 `; do 
  ```       
  > This is `for` loop. We want to execute the command for every ip in the given range.
  > You can modified the loop to use `$(seq 1 254)` to generate the sequence of IP addresses.
  > Thus, we write a `for` loop and execute it in a range for `1 ` tp `245` that is, the number of ip addresses in a particular network.
  >>Note that you might want to adjust the range based on your network setup(range on the actual IP addresses you want to ping in your network). If you're working with standard IPv4 addresses, the range is typically from `1` to `255`.
- ```sh
  ping -c 1 "$1.$ip" | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
  ```
  > `ping`: To ping the ip addreess

  > `-c 1`: Ping one ip at a time

  > `$1.$ip`: `$1` will be the user input. We will input the first three ranges of the ip and the last range will be taken from the `for` loop. i.e. if a user input was `192.68.1` then in the first run of the `for` loop`$ip` will be `1`. thus, `$1.$ip` will result in `192.68.1.1` and it will ping this ip.

  > `grep "64 bytes"`: Try running a `ping` command to an ip. If the ip responds, the resultwill be `"64 bytes from (given_ip)"`. Now, if the ip is active, it will respond and the response will contain the term `"64 bytes"`. Thus, `grep "64 bytes"` will simply filter out the ip's that responded from a total of `254` ip addresses. We know that if the ip is active it will respond. the demo of responding will be something like this, `'64 bytes from given_ip'` where given_ip will be the ip pinged too. Therefore from the whole response now, we will need only the ip address of the responded ip.

  > `cut -d " " -f 4`: This command basically does the same thing. It cuts the whole response with the delimeter(`-d`), whitespace(`" "`), and picks the 4th term(`-f 4`) from it, that will be the ip. This `cut` command will basically produce output like `192.68.1.1` 
  >>Here, we don't need the colon(`:`). We just need the ip, thus we run the `tr` command.

  > `tr -d ":"`: Here we pass colon(`:`) as a delimeter and `tr` command deletes it.

  > `&`: This basically allows the thread to work simultaneously.

  > `|` (pipe): It basically joins all the above commands as a single command.
  >> Dont't be confuse here, we used `{}` in the [script](/ip_sweeper.sh) to group the commands inside the subshell to ensure the spinner runs until all the ping commands finish.

