#!/bin/bash

# COPY A USER SSH PUBLIC KEY TO MULTIPLE HOSTS
# BY DEFAULT, HOSTS MUST BE IN hostlist.txt FILE
# REQUIRES sshpass PACKAGE
# LOCAL HOST PRIVILEGE REQUIRED
# PUBLIC KEY MUST BE SET FOR LOCAL USER

echo -e "\n"

	# 001 - VAR SETUP IF ARGUMENTS ARE PASSED
LOCUSER="$1"    # LOCAL USER FOR REMOTE ACCESS
USERHOME=$(getent passwd $LOCUSER | cut -d: -f6)

RMTUSER="$2"    # REMOTE USER
PASSWD="$3"     # SITE PASSWORD
SRVLIST="$4"	# HOST LIST FILE PATH
PUBKEY="$5"	# PUBLIC KEY FILE PATH


	# 002 - VAR SETUP IF NO ARGUMENTS ARE SET
[ -z ${LOCUSER} ] && read -p "LOCAL USER FOR REMOTE ACCESS: " LOCUSER

	# 002.001 - EXIT IF LOCAL USER IS NOT FOUND
[ $(id -nu $LOCUSER 2> /dev/null) ] || { printf "\t# 002.001 \"$LOCUSER\" LOCAL USER NOT FOUND\n\n" ; exit 1 ; }

[ -z ${RMTUSER} ] && read -p "REMOTE USER: " RMTUSER
[ -z ${PASSWD} ]  && read -p "REMOTE USER PASSWORD: " PASSWD

	# 002.002 - VAR SETUP FOR HOST LIST FILE IF NOT SET AS ARGUMENT
[ -z ${SRVLIST} ] && read -p "HOST LIST FILE PATH (default ./hostlist.txt): " SRVLIST
     [ -z ${SRVLIST} ] && { printf "\tDefault list set\n\n" ; SRVLIST="hostlist.txt" ; }

	# 002.003 - EXIT IF HOST LIST FILE DOES NOT EXIST
[ -f $SRVLIST ] && SRVARRAY=( $(cat $SRVLIST) ) \
	|| { printf "\n\t# 002.003 - $SRVLIST NOT FOUND! PLEASE CHECK YOUR FILE LIST\n\n"; exit 2 ; }

	# 002.004 - VAR SETUP FOR PUB KEY IF NOT SET AS ARGUMENT
[ -z ${PUBKEY} ] && read -p "LOCAL USER PUB KEY PATH (default ~/.ssh/id_rsa.pub): " PUBKEY
     [ -z ${PUBKEY} ] && { printf "\tDefault key set\n\n" ; PUBKEY="$USERHOME/.ssh/id_rsa.pub" ; }

	# 002.005 - EXIT IF PUBLIC KEY DOES NOT EXIST FOR LOCAL USER
[ -f $PUBKEY ] || { printf "\n\t# 002.005 - $PUBKEY NOT FOUND! PLEASE CHECK PUB KEY NAME\n\n"; exit 3 ; }


	# 003 - MAIN LOOP OPERATION - SEND PUB KEY
for IP in "${SRVARRAY[@]}"; do
	runuser -u "${LOCUSER}" -- sshpass -p${PASSWD} \
			ssh-copy-id \
			-i "$PUBKEY" \
			-o StrictHostKeyChecking=no \
			"${RMTUSER}@${IP}"

	[ "$?" -eq "0" ] && printf "OK - $IP\n\n" || printf "\nFAIL! - $IP\n\n"
done

echo -e "\n\n"
exit 0
