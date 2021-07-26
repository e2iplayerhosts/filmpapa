#!/bin/sh
echo "filmpapa.sh: start"
cp $1/iptvupdate/custom/filmpapa.sh $2/iptvupdate/custom/filmpapa.sh
status=$?
if [ $status -ne 0 ]; then
	echo "filmpapa.sh: Critical error. The $0 file can not be copied, error[$status]."
	exit 1
fi
cp $1/hosts/hostfilmpapa.py $2/hosts/
hosterr=$?
cp $1/icons/logos/filmpapalogo.png $2/icons/logos/
logoerr=$?
cp $1/icons/PlayerSelector/filmpapa*.png $2/icons/PlayerSelector/
iconerr=$?
if [ $hosterr -ne 0 ] || [ $logoerr -ne 0 ] || [ $iconerr -ne 0 ]; then
	echo "filmpapa.sh: copy error from source hosterr[$hosterr], logoerr[$logoerr, iconerr[$iconerr]"
fi
wget --no-check-certificate https://github.com/e2iplayerhosts/filmpapa/archive/master.zip -q -O /tmp/filmpapa.zip
if [ -s /tmp/filmpapa.zip ] ; then
	unzip -q -o /tmp/filmpapa.zip -d /tmp
	cp -r -f /tmp/filmpapa-master/IPTVPlayer/hosts/hostfilmpapa.py $2/hosts/
	hosterr=$?
	cp -r -f /tmp/filmpapa-master/IPTVPlayer/icons/* $2/icons/
	iconerr=$?
	if [ $hosterr -ne 0 ] || [ $iconerr -ne 0 ]; then
		echo "filmpapa.sh: copy error from filmpapa-master hosterr[$hosterr], iconerr[$iconerr]"
	fi
else
	echo "filmpapa.sh: filmpapa.zip could not be downloaded."
fi
rm -r -f /tmp/filmpapa*
echo "filmpapa.sh: exit 0"
exit 0