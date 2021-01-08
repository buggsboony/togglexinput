#!/bin/bash


#    ↳ USB2.0 HD UVC WebCam: USB2.0 HD           id=16   [slave  keyboard (3)]
#    ↳ Asus WMI hotkeys                          id=19   [slave  keyboard (3)]
#∼ AT Translated Set 2 keyboard                  id=20   [floating slave]


# Use xinput to float the specified keyboard
keyboardKill="AT Translated Set 2 keyboard"




line=$(xinput | grep "$keyboardKill")
echo "Device line found :"
echo $line


#Save previous IFS
prevIFS=$IFS

#Set IFS separator
IFS='id='

#Split
read -a parts <<< "$line"

#Rétablir le séparateur :
IFS=$prevIFS

echo  $parts[0]
echo $[#parts[*]}
#Count words
##echo "There are $[#parts[*]}"



