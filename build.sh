# Build.sh
# Usage: Build.sh
#!/bin/bash
# init
function pause(){
   read -p "$*"
}

# Clearing workspace
for file in ./*.o
do
    if [ -f "${file}" ]; then
        rm *.o;
        break
    fi
done

for file in ./*.cf
do
    if [ -f "${file}" ]; then
        rm *.cf;
        break
    fi
done

# Building
ghdl -a --ieee=standard *.vhdl

pause 'Press [Enter] key to continue...'