# Run
# Usage: run.sh dff_tb
#!/bin/bash
# init
function pause(){
   read -p "$*"
}

# Building Executable
ghdl -e --ieee=standard $1


 
pause 'Press [Enter] key to continue...'

ghdl -r $1 --vcd=vcd/$1.vcd

pause 'Press [Enter] key to continue...'