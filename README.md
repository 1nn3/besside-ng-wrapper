# besside-ng-wrapper 🛜 – WiFi hacken mit Aircrack-NG
Topics: wlan-tool wifi-hacking wlan-scanner

	git clone https://github.com/1nn3/besside-ng-wrapper ~/besside-ng-wrapper
	sudo sh ~/besside-ng-wrapper/setup.sh

WPA-Handshakes aufzeichnen:

	sudo ./besside-ng-wrapper [ -i wlan0 ] start
	tail -f besside-ng-wrapper.log besside.log

Beenden:

	sudo ./besside-ng-wrapper [ -m wlan0mon ] stop

Versuchen das WiFi-Passwort zu erraten:

	./lsvendor <besside.log
	aircrack-ng -w /usr/share/wordlists/rockyou.txt ./wpa.cap

OUI Datenbank aktualisieren:

	./update-oui

Zeigt neue WiFis seit dem letzten Aufruf an:

	@hourly ~/besside-ng-wrapper/cronjob

