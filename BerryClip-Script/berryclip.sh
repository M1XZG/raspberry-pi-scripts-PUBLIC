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
# This script provides some of the
# functions provided by the python
# scripts written by Graham.
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

###################################################################################################
# Author        : Robert McKenzie <rmckenzi@rpmdp.com>
# Script Name   : berryclip.sh
# Revision      : $Revision: 1.4 $
# Version       : $Id: berryclip.sh,v 1.4 2013/04/20 19:53:37 rmckenzi Exp rmckenzi $
#
###################################################################################################

VERSIONRAW="$Id: berryclip.sh,v 1.4 2013/04/20 19:53:37 rmckenzi Exp rmckenzi $"
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

# This function will generate a beep loop based on the number of iterations provided by the user
function beep
{

	var0=1
	LIMIT=`expr $execnum + 1`

	echo "Cycle number: "
	while [ "$var0" -lt "$LIMIT" ]
	do
		gpio write $BUZ1 1
		sleep $DELAY
		gpio write $BUZ1 0
		echo -ne "$var0   \r"
		var0=`expr $var0 + 1`
	done
	echo
}

# This function turns on all the LED's
function allon
{
	# Turn the LEDs on and off in order

	for i in $LED1 $LED2 $LED3 $LED4 $LED5 $LED6
	do
		gpio write $i 1
		sleep $DELAY
	done
}

# This function turns off all the LED's
function alloff
{
	for i in $LED6 $LED5 $LED4 $LED3 $LED2 $LED1
	do
		gpio write $i 0
		sleep $DELAY
	done
}

# This function produced the loop to do the lightfollow, iteration count provided by the user
function lightfollow
{

	var0=1
	LIMIT=`expr $execnum + 1`

	echo "Cycle number: "
	while [ "$var0" -lt "$LIMIT" ]
	do
		allon
		alloff
		echo -ne "$var0   \r"
		var0=`expr $var0 + 1`
	done
	echo
}

# This function produced the loop to do the cylon/KITT, iteration count provided by the user
function cylon
{
	var0=1
	LIMIT=`expr $execnum + 1`

	echo "Cycle number: "
	while [ "$var0" -lt "$LIMIT" ]
	do
		for i in $LED1 $LED2 $LED3 $LED4 $LED5 $LED6 $LED5 $LED4 $LED3 $LED2 $LED1
		do
			gpio write $i 1
			sleep $DELAY
			gpio write $i 0
		done
		echo -ne "$var0   \r"
		var0=`expr $var0 + 1`
	done
	echo
}

function policelights
{
	var0=1
	LIMIT=`expr $execnum + 1`

	echo "Cycle number: "
	while [ "$var0" -lt "$LIMIT" ]
	do
		for i in $LED1 $LED5 $LED2 $LED6 $LED1 $LED5 $LED2 $LED6 $LED1 $LED5 $LED2 $LED6 $LED1 $LED5 $LED2 $LED6
		do
			gpio write $i 1
			sleep $DELAY
			gpio write $i 0
		done
		echo -en "$var0   \r"
		var0=`expr $var0 + 1`
	done
	echo
}

function switchtest
{
	echo
	echo "Switch test ... push the switch ..."
	echo

	SWT1STATUS=0

	echo
	echo "Press any key to exit the loop"

	if [ -t 0 ]; then stty -echo -icanon time 0 min 0; fi

	echo
	keypress=''
	while [ "x$keypress" = "x" ]; do

		SWT1STATUS=`gpio read $SWT1`
		if [ "$SWT1STATUS" = "1" ]; then
			echo -ne 'Button is Down\r'
		else
			echo -ne 'Button is Up  \r'
		fi
	  read keypress
	done

	echo
	echo

	if [ -t 0 ]; then stty sane; fi
	return

}

function switchbeep
{
	echo
	echo "Switch Beep ... push the switch to beep the buzzer..."
	echo

	SWT1STATUS=0

	echo
	echo "Press any key to exit the loop"

	if [ -t 0 ]; then stty -echo -icanon time 0 min 0; fi

	echo
	keypress=''
	while [ "x$keypress" = "x" ]; do

		SWT1STATUS=`gpio read $SWT1`
		if [ "$SWT1STATUS" = "1" ]; then
			echo -ne 'BEEP!!! \r'
			gpio write $BUZ1 1
		else
			echo -ne 'Silence \r'
			gpio write $BUZ1 0
		fi
	  read keypress
	done

	gpio write $BUZ1 0
	echo
	echo

	if [ -t 0 ]; then stty sane; fi
	return

}

function switchleds
{
	echo
	echo "Switch lights ... hold the switch down to turn on the LEDS..."
	echo

	SWT1STATUS=0

	echo
	echo "Press any key to exit the loop"

	if [ -t 0 ]; then stty -echo -icanon time 0 min 0; fi

	echo
	keypress=''
	while [ "x$keypress" = "x" ]; do

		SWT1STATUS=`gpio read $SWT1`
		if [ "$SWT1STATUS" = "1" ]; then
			allon
			echo -ne 'All LEDs on  \r'
		else
			alloff
			echo -ne 'All LEDs off \r'
		fi
	  read keypress
	done

	alloff
	echo
	echo

	if [ -t 0 ]; then stty sane; fi
	return

}

function counter
{
	echo
	echo -m "Enter how many seconds to count for: "
	read runtime

	echo "Running for: $runtime seconds"



	return
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

function setdelay
{
	echo    ""
	echo    "Current delay is: $DELAY seconds"
	echo    ""
	echo -e -n "What do you want to set it to? \n(I suggest well under 1 second)\nJust press ENTER to leave it as is: "

	read delayvalue

	if [ "$delayvalue" = "" ]; then
		echo
		modes
	else
		DELAY=$delayvalue
		modes
	fi
}

function exectimes
{
		echo
		echo "How many times do you want the cycle to run?"
		echo -n "Enter a number: "
		read execnum
		return
}

function modes
{

	clear
	cleanup

cat << EOF

$VERSION

Pick one of the following options

1 - lightfollow  - The lights will all turn on and off
                   after each other
2 - cylon        - The lights will follow each other 
                   like a Cylon / KITT
3 - policelights - Alternating Police style lights
4 - beep         - Beeps the buzzer
5 - switchtest   - Only tests if you push the button
6 - switchbeep   - Press the button to beep the buzzer
7 - switchleds   - Press the button to light LEDs
8 - counter      - Counts up to x seconds you set

D - Set the delay between lights off/on and beeps
Q - Quit
EOF

	echo -n "What do you want to do? "
	read execmode

	execmode=`echo ${execmode,,}`

	case "$execmode" in

		"1" )
			exectimes
			clear
			lightfollow $execnum
			echo "Press enter to return to menu..."
			read response
			modes
		;;
		"2" )
			exectimes
			clear
			cylon $execnum
			echo "Press enter to return to menu..."
			read response
			modes
		;;
		"3" )
			exectimes
			clear
			policelights $execnum
			echo "Press enter to return to menu..."
			read response
			modes
		;;
		"4" )
			exectimes
			clear
			beep $execnum
			echo "Press enter to return to menu..."
			read response
			modes
		;;
		"5" )
			clear
			switchtest
			echo "Press enter to return to menu..."
			read response
			modes
		;;
		"6" )
			clear
			switchbeep
			echo "Press enter to return to menu..."
			read response
			modes
		;;
		"7" )
			clear
			switchleds
			echo "Press enter to return to menu..."
			read response
			modes
		;;
		"8" )
			clear
			counter
			echo "Press enter to return to menu..."
			read response
			modes
		;;
		"d" )
			clear
			setdelay
			echo "Press enter to return to menu..."
			read response
			modes
		;;
		"q" )
			echo
			echo "Thanks for using the script ... "
			echo
			exit 0
		;;
		* )
			modes
		;;
	esac
}

enableoutput
modes
