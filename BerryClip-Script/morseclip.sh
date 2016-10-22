#!/bin/bash

#--------------------------------------
#    ___                   ________
#   / _ )___ __________ __/ ___/ (_)__
#  / _  / -_) __/ __/ // / /__/ / / _ \
# /____/\__/_/ /_/  \_, /\___/_/_/ .__/
#                  /___/        /_/
#
#       BerryClip - 6 LED Board
#
# This script lets you pick a preset
# speed in WPM then enter a test message
# that is converted to Morse Code and
# sent out through the buzzer on the
# BerryClip board.
#
# This script requires you have
# wiringPI installed which will
# provide the 'gpio' command.
# https://projects.drogon.net/raspberry-pi/wiringpi/download-and-install/
#
# Author : Robert McKenzie
# Date   : 18/04/2013
#
# http://www.raspberrypi-spy.co.uk/
#
#--------------------------------------

# HEADER
###################################################################################################
# Author        : Robert McKenzie <rmckenzi@rpmdp.com>
# Script Name   : morseclip.sh
# Revision      : $Revision: 1.2 $
# Version       : $Id: morseclip.sh,v 1.2 2013/04/20 20:07:31 rmckenzi Exp $
#
###################################################################################################

VERSIONRAW="$Id: morseclip.sh,v 1.2 2013/04/20 20:07:31 rmckenzi Exp $"
VERSION=`echo $VERSIONRAW | awk '{print "Version: " $3 "\nDate   : " $4" "$5}'`

GPIO=`which gpio`
if [ "$GPIO" = "" ];then
        echo
        echo "Sorry, but I can't find your 'gpio' command.  This is required"
        echo "This is either because it's not in the path or it's not installed"
        echo
        echo "If it's not installed please go to this site and follow the"
        echo "instructions for installing it."
        echo
        echo "https://projects.drogon.net/raspberry-pi/wiringpi/download-and-install/"
        echo
        exit 255
fi


# Default Morse speed
WPM=20
DITT=0.04

# Set this for the delay between lights on/off
DELAY=0.02

LED1=7
LED2=0
LED3=3
LED4=12
LED5=13
LED6=14
# Here only for reference
BUZ1=10
SWT1=11

# =====================================================================================
# Functions beyond here
# =====================================================================================


# This function will enable all the LED's and the Buzzer for output
function enableoutput
{
	for i in $LED1 $LED2 $LED3 $LED4 $LED5 $LED6 $BUZ1
	do
		gpio mode $i out
	done

	gpio mode $SWT1 in

}

function mcdit
{
	gpio write $BUZ1 1
	sleep $DITT
	gpio write $BUZ1 0
	return 0
}

function mcdah
{
	gpio write $BUZ1 1
	sleep $DITT
	sleep $DITT
	sleep $DITT
	gpio write $BUZ1 0
	return 0
}

# ================================================================================================================================
# Letters and numbers
# ================================================================================================================================

function space
{
	sleep $DITT
	sleep $DITT
	sleep $DITT
	sleep $DITT
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function a
{
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function b
{
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function c
{
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function d
{
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function e
{
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function f
{
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function g
{
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function h
{
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function i
{
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function j
{
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function k
{
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function l
{	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function m
{
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function n
{
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function o
{
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function p
{
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function q
{
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function r
{
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function s
{

	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function t
{
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function u
{
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function v
{
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function w
{
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function x
{
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function y
{
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function z
{
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function m1
{
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function m2
{
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function m3
{
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function m4
{
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function m5
{
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function m6
{
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function m7
{
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function m8
{
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function m9
{
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function m0
{
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function mperiod
{
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT

	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function mcomma
{
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT

	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function mplus
{
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT

	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}

function mequals
{
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT

	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}


function mquestion
{
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT
	mcdah
	sleep $DITT
	mcdah
	sleep $DITT
	mcdit
	sleep $DITT
	mcdit
	sleep $DITT

	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}


function mTEMPLATE
{
	mcdah
	sleep $DITT

	mcdit
	sleep $DITT

	sleep $DITT
	sleep $DITT
	sleep $DITT
	return 0
}




# ================================================================================================================================
# The below this line is really the main functions to control interaction.
# ================================================================================================================================

# This really just ensures that all LED's and the Buzzer are turned off.
function cleanup
{

	for i in $LED1 $LED2 $LED3 $LED4 $LED5 $LED6 $BUZ1
	do
		gpio write $i 0
	done
}

function setspeed
{
	echo
	echo    "Current speedis is: $WPM wpm"
	echo
	echo 	"Valid speeds currently:  5, 12, 20 and 30 WPM"
	echo
	echo -e -n "What do you want to set it to? \nJust press ENTER to leave it as is: "

	read wpmvalue


	if [ "$wpmvalue" = 5 ];then
		DITT=0.22
		WPM=5
		echo
		echo "Setting to - 5 WPM..."
		echo
	elif [ "$wpmvalue" = 12 ]; then
		DITT=0.08
		WPM=12
		echo
		echo "Setting to - 12 WPM..."
		echo
	elif [ "$wpmvalue" = 20 ]; then
		DITT=0.04
		WPM=20
		echo
		echo "Setting to - 20 WPM..."
		echo
	elif [ "$wpmvalue" = 30 ]; then
		DITT=0.02
		WPM=30
		echo
		echo "Setting to - 30 WPM..."
		echo
	else
		echo
		echo "Invalid option or you've asked to leave it set to $WPM"
		echo
	fi

}

function message
{

	echo 
	echo "Enter your message below, keep it short .. "
	echo "  Acceptable characters are:"
	echo "     Letters: A - Z"
	echo "     Numbers: 0 - 9"
	echo "     .(period) ,(comma) ?(question) +(plus) =(equals)"
	echo
	read msgvalue

	# Replace spaces with a comma for handling later
	MSG=`echo $msgvalue | sed 's?\ ?@?g'`

	# Convert all uppercase to lowercase
        MSG=`echo $MSG | tr '[:upper:]' '[:lower:]'`

	# Convert all numbers to m<num> to handle those easier
	MSG=`echo $MSG | fold -w1 | sed 's#\([0-9]\)#m\1#g'`

	# Convert all periods to mperiod to handle those easier
	MSG=`echo $MSG | sed 's#\(\.\)#mperiod#g'`

	# Convert all plus to mplus to handle those easier
	MSG=`echo $MSG | sed 's#\(\+\)#mplus#g'`

	# Convert all equals to mequals to handle those easier
	MSG=`echo $MSG | sed 's#\(\=\)#mequals#g'`

	# Convert all comma to mcomma to handle those easier
	MSG=`echo $MSG | sed 's#\(\,\)#mcomma#g'`

	# Convert all question marks to mquestion to handle those easier
	MSG=`echo $MSG | sed 's#\(\?\)#mquestion#g'`

	echo
	echo "Sending your text at $WPM WPM:" 

	for i in `echo $MSG`
	do
		if [ "$i" = "@" ];then
			space
		else
			$i
		fi

		if [ "$i" = "@" ];then
			echo -n " "
		elif echo -n "$i" | grep "mperiod" &> /dev/null
		then
			echo -n "`echo -n $i | sed  's#mperiod#.#g'` "

		elif echo -n "$i" | grep "mquestion" &> /dev/null
		then
			echo -n "`echo -n $i | sed  's#mquestion#?#g'` "

		elif echo -n "$i" | grep "mplus" &> /dev/null
		then
			echo -n "`echo -n $i | sed  's#mplus#+#g'` "

		elif echo -n "$i" | grep "mequals" &> /dev/null
		then
			echo -n "`echo -n $i | sed  's#mequals#=#g'` "

		elif echo -n "$i" | grep "mcomma" &> /dev/null
		then
			echo -n "`echo -n $i | sed  's#mcomma#,#g'` "

		elif echo -n "$i" | grep "m." &> /dev/null
		then
			echo -n "`echo -n $i | tr -dc '[0-9]'` "

		else
			echo -n "$i "
		fi
	done
	echo
	echo
	echo "Press enter to start again..."
	read carron
	return 0
}


function start
{

clear

cat << EOF

$VERSION

This is a simple morse code encoder using the BerryClip

First you need to set the speed in WPM, then enter your
message to send.

1. Set your WPM speed

2. Enter message to send as Morse Code


Q. Exit
EOF

echo -n "Enter a number: "
read option

option=`echo ${option,,}`

case "$option" in

	"1" )
		clear
		setspeed
		start
	;;

	"2" )
		clear
		message
		start
	;;

	"q" )
		echo
		echo "Thanks for playing .. good-bye!"
		echo
		exit 1
	;;

	* )
		start
	;;
esac


}

enableoutput
start


