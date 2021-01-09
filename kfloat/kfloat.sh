#!/bin/bash
# console colors 2020-08-22 12:47:37
GREEN='\033[0;32m'
LGREEN='\033[1;32m'
WHITE='\033[1;37m'
YELL='\033[1;33m'
RED='\033[0;31m'
LRED='\033[1;31m'
MAG='\033[0;35m'
LMAG='\033[1;35m'
CYAN='\033[0;36m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color

#    ↳ USB2.0 HD UVC WebCam: USB2.0 HD           id=16   [slave  keyboard (3)]
#    ↳ Asus WMI hotkeys                          id=19   [slave  keyboard (3)]
#∼ AT Translated Set 2 keyboard                  id=20   [floating slave]


#python code sample :
# txt = "∼ AT Translated Set 2 keyboard                  id=20   [floating slave]";x=txt.split("id=");xid=x[1].split()[0];print(xid);



# Use xinput to float the specified keyboard
keyboardKill="AT Translated Set 2 keyboard"




line=$(xinput | grep "$keyboardKill")
echo "Device :"
printf "${LMAG}$line\n${NC}"
kid=$(python -c "txt = \"$line\".strip();x=txt.split(\"id=\");xid=x[1].split()[0];print(xid);")
echo "xinput float $kid"
xinput float $kid
printf "${YELL}done.${NC}\n"

#Save previous IFS
#prevIFS=$IFS

#Set IFS separator
#IFS='id='

#Split
#read -a parts <<< "$line"

#Rétablir le séparateur :
#IFS=$prevIFS



