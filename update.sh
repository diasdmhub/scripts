#!/bin/bash

# UPDATE.SH
# COMPLETE SYSTEM UPDATE SCRIPT
# CREATES BASIC ALIAS IN CASE THERE ARE NONE
# by diasdm
# v2 - 20200501
# v1 - 20200428

clear

#001 VARIABLES

SCRIPT_DIR=$HOME/scripts/prod
SCRIPT_NAME="update.sh"
CONTINUE="x"


#002 HEADER NOTE

Header () {

while [ $CONTINUE != "y" ]; do
        echo "    COMPLETE SYSTEM UPDATE"
        echo -e "     USER ALIAS CREATION\n\n"

        echo "********* ATENTION ***********"
        echo "*THIS SCRIPT WILL UPDATE YOUR*"
        echo "*     SYSTEM COMPLETELY.     *"
        echo "*  IT MIGHT TAKE SOME TIME   *"
        echo "******************************"
        read -p "DO YOU WISH TO CONTINUE? <y/n> >> " CONTINUE
                CONTINUE=${CONTINUE,,}


#003 CHECK IF USER WANTS TO CONTINUE

        if [ $CONTINUE = "n" ]; then
                echo -e "\n"
                exit 1; # USER EXIT
        elif [ $CONTINUE = "y" ];then
                :
        else
                echo -e "\nYes (y) or No (n)"
                sleep 3
                clear
        fi
        done

}
Header


#004 CHECK SCRIPT DIR

if [ ! -d $SCRIPT_DIR ]; then
        echo -e "\nScript main directory not found. Creating...\n"
        mkdir -p -v $SCRIPT_DIR
        cp -v $SCRIPT_NAME $SCRIPT_DIR
fi


#005 CHECK BASH ALIASES

if [ ! -f ~/.bash_aliases ]; then
        echo -e "\nUser aliases not found. Creating...\n"
        echo "alias update='$SCRIPT_DIR/$SCRIPT_NAME'" > ~/.bash_aliases
        echo "alias ls='ls --color=auto'" >> ~/.bash_aliases
        echo "alias ll='ls -lah --color=auto'" >> ~/.bash_aliases
        source ~/.bashrc
fi


#006 SYSTEM COMPLETE UPDATE

echo -e "\nUPDATING SYSTEM\n"
        sudo apt-get -y update
        sudo apt-get -y autoclean
        sudo apt-get -y upgrade
        sudo apt-get -y dist-upgrade
        sudo apt-get -y autoremove
        sudo apt-get -y -f install


#007 DELETE SCRIPT AFTER FIRST TIME USE

if [ ! $PWD/$SCRIPT_NAME = $SCRIPT_DIR/$SCRIPT_NAME ]; then
        [ -e $PWD/$SCRIPT_NAME ] && rm $SCRIPT_NAME
fi


echo -e "\nRUN \". ~/.bashrc\" TO UPDATE YOUR ALIASES\n"
echo -e "IF YOU TYPE \"update\" THIS SCRIPT WILL START"
echo -e "AT $SCRIPT_DIR/$SCRIPT_NAME\n"


exit 0; # SCRIPT END
