#!/bin/bash
#========================================================================
#			U S E F U L 	S O F T S
#========================================================================

#=====================
#	Ditrib
#=====================


if [[ $(cat /etc/issue |grep Ubuntu) ]]
then
	msp="apt-get"
elif [[ $(cat /etc/issue |grep Redhat) ]]
then
   	msp="yum"
fi

#todo : increase grep and add repo and add emerge (for gentoo)


sudo $msp install \

#~~~~~~~~~~~~~~~ EDITOR ~~~~~~~~~~~~~~~~~

libreoffice \
gedit \


#~~~~~~~~~~~~~~~ VIDEO/AUDIO/RECORDER ~~~~~~~~~~~~~~~~~


gtk-recordmydesktop \
vlc \
audacity \
gimp \

#~~~~~~~~~~~~~~~ TOOLS/PRINT ~~~~~~~~~~~~~~~~~

cups-pdf \		#(comme pdf creator)

#~~~~~~~~~~~~~~~ NETWORK ~~~~~~~~~~~~~~~~~

wireshark \
traceroute \
