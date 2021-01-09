#!/bin/bash


#    ↳ USB2.0 HD UVC WebCam: USB2.0 HD           id=16   [slave  keyboard (3)]
#    ↳ Asus WMI hotkeys                          id=19   [slave  keyboard (3)]
#∼ AT Translated Set 2 keyboard                  id=20   [floating slave]


#python code sample :
# txt = "∼ AT Translated Set 2 keyboard                  id=20   [floating slave]";x=txt.split("id=");xid=x[1].split()[0];print(xid);



# Use xinput to float the specified keyboard
keyboardKill="AT Translated Set 2 keyboard"




line=$(xinput | grep "$keyboardKill")
echo "Device :"
echo $line
kid=$(python -c "txt = \"$line\".strip();x=txt.split(\"id=\");xid=x[1].split()[0];print(xid);")

xinput float $kid

#Save previous IFS
#prevIFS=$IFS

#Set IFS separator
#IFS='id='

#Split
#read -a parts <<< "$line"

#Rétablir le séparateur :
#IFS=$prevIFS



