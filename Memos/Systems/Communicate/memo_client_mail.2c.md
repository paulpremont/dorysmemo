==========================================================
                       M A I L
==========================================================
~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~
	http://www.ietf.org/rfc/rfc0821.txt
	http://guide.ovh.com/EmailProblemesEtSolutions
	http://linux.about.com/od/commands/l/blcmdl1_Mail.htm
        http://tecadmin.net/ways-to-send-email-from-linux-command-line/

~~~~~~~~~~~~~~~~~~~~~~~~~~
Envoyer un mail (Submission MTA)
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Via telnet (Not secure)
        --------------------------

                __________________________
		Interactif:

			telnet smtp.mondomaine.com PORT

			EHLO mon_identifiant (peu importe)
			MAIL FROM: sender@domain (idem)
			RCPT TO: receiver@domain
			DATA
			From: sender@domain (optionnel selon le serveur)
			To: receiver@domain (optionnel selon le serveur)
			Subject: un sujet
			Corps du mail blablabla
			.
			QUIT

			Note: bien entendu tout dépend de la conf coté serveur. D'autre commandes pourrait être à envoyer.

                __________________________
                Script:

			On envoi nos commandes dans une session telnet simplement:

			(Mes Commandes) |telnet $smtp

			exemple:

			(
			sleep 1
			echo "EHLO bidul"
			sleep 1 ...
			) |telnet smtp.domain.com 587
		

        --------------------------
        Via mail
        --------------------------
		http://mailutils.org/manual/mailutils.html

		TODO

                __________________________
		Install:

			apt-get install mailutils
                __________________________
		Configuration:

			mail --config-help

			vim /etc/mail.rc
			ou ~/.mailrc

			voir /usr/share/doc/mailutils/examples/mail.rc
                __________________________
		Quelques options:

			-t DESTINATAIRES #Envoyer aux destinaires mentionés
			-u USER #Prendre une identité spécific
			-s SUJET
			-r ADDRESSE_RETOUR
			-A PIECE_JOINTE
                __________________________
		Mode interactif:

			mail destinataire@domaine

                __________________________
		Mode script:

			echo "mon message" |mail -s "Sujet" destinaire@domaine


        --------------------------
        Via sendmail
        --------------------------
                http://www.bsi2.com/Sendmail-ArchT.JPG

        __________________________
		Conf: 
			Dans /etc/mail

                        smtp
                        ``````````````````````````

				On ajoute un serveursmtp dans sendmail.mc
			
					('SMART_HOST', 'mon.smtp.fqdn')
					> m4 sendmail.mc sendmail.cf

					# "Smart" relay host (may be null)
					DSsmtp-server.hot.rr.com

					> /etc/init.d/sendmail restart

			

                __________________________
		Envoyer un mail manuellement:

                        sendmail dest@domain
                                From: source@domain
                                To: dest@domain
                                Subject: mon subject
                                Corps du mail
                                [CTRL + D]

	
        --------------------------
        Via postfix (concurent de sendmail)
        --------------------------

            BIG TODO

~~~~~~~~~~~~~~~~~~~~~~~~~~
Récupérer un mail sur un MDA
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Via un client lourd
        --------------------------

		En mode graphique: thunderbird, outilook ...
		En mode console: mutt ...

        --------------------------
        Telnet (non secure)
        --------------------------

		On se telnet sur le port adéquate et on interroge le serveur:
                __________________________
		exemple POP

			#On se connecte:
				telnet monServer.fr 110

			#On s'identifie:
				user MON_USER
				pass MON_PASS

			#On affiche les mails reçus:
				list

			#On affiche le contenu d'un mail:
				retr NUMERO_MESSAGE

			#Supprimer un message:
				dele NUMERO_MESSAGE
			
			#Déconnection
				exit

                __________________________
		exemple IMAP

			#On se connecte:
				telnet monServer.fr 143

			#On s'identifie:
				login USER PASSWORD

			#On affiche les mails reçus:
				select MON_FOLDER

			#On affiche le contenu d'un mail:
				fetch NUMERO_MESSAGE full
				fetch NUMERO_MESSAGE body

			#Déconnection
				logout

        --------------------------
        fetchmail
        --------------------------
                __________________________
		Install:

			apt-get install fetchmail fetchmailconf
                __________________________
		Conf:
			vim ~/.fetchmailrc

                __________________________
		Récupérer un mail:
	
			fetchmail -kv

	
~~~~~~~~~~~~~~~~~~~~~~~~~~
MDA (voir partie postfix)
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        procmail (MDA)
        --------------------------

		Il permet de filtrer les mails

		TODO

~~~~~~~~~~~~~~~~~~~~~~~~~~
Contrôler ses mails
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Gérer la file d'attente:
        --------------------------

                > mailq
