#!/usr/bin/python

# HEADER
###################################################################################################
# Author        : Robert McKenzie <rmckenzi@rpmdp.com>
# Script Name   : dht22-templogger.py
# Description   : This python script will collect temp and humidity from dht22 and cpu temp from
#                 the PI motherboard and feed this data back to http://thingspeak.com
#
#                 This script was adapted from <find the source>
#
###################################################################################################

# Imports we'll need in this script.
import datetime
import time
import sys
import Adafruit_DHT
import RPi.GPIO as GPIO
import urllib2
import os
import subprocess

# Humidity thresholds in percentage
humidityHI = 70
humidityLO = 55

# Assign date and time
now = time.strftime("%c")
today = datetime.date.today()

# This configures your DHT22 Sensor, check your PIN settings
sensor = Adafruit_DHT.DHT22
pin = 4
GPIO.setmode(GPIO.BCM)

# This section should be used if like you me you run the same script on multiple Raspberry Pi's with the same DHT22 sensor.
# If you don't run multiple Pi's, the simplest thing is to comment out the next 9 lines and uncomment single myAPI line.

#myhost = os.uname()[1]
#if myhost == "pi1":
#	myAPI = "<YOUR API WRITE KEY>"
#elif myhost == "pi2":
#	myAPI = "<YOUR API WRITE KEY>"
#elif myhost == "pi3":
#	myAPI = ""
#	print("Undefined host, exiting")
#	sys.exit(1)

myAPI = "<INSERT YOUR WRITE API KEY HERE>"	

# BaseURL for ThingSpeak - Shouldn't require any changes
baseURL = 'https://api.thingspeak.com/update?api_key=%s' % myAPI

# The next line will get the RPi's built in temp sensor results
boardtemp = subprocess.check_output("/usr/local/bin/get-pitemp.sh", shell=True)
# The script that I call above is a bit of a hack but it's just 3 lines, until I can figure out how to do it in python

	# #!/bin/bash
	# pitemp=`/opt/vc/bin/vcgencmd measure_temp | awk -F= '{print $2}' | awk -F\' '{print $1}'`
	# echo -n $pitemp


# The next line will get the current state of the relay on the HS100/HS110 Wifi switch, then setting the results to 0 or 1 for charting
# The brilliant hs100.sh script can be found here:
# https://github.com/ggeorgovassilis/linuxscripts/tree/master/tp-link-hs100-smartplug

dehumidpwr = subprocess.check_output("/usr/local/bin/hs100.sh YOUR_IP_HERE 9999 check", shell=True)
if dehumidpwr in ['OFF']:
	dehumidpwrstat = 0
elif dehumidpwr in ['ON']:
	dehumidpwrstat = 1


# This next section will get the current Temperature and Humidity readings from the DHT22 then handle the numbers by rounding them
humidity, temperature = Adafruit_DHT.read_retry(sensor, pin)
if temperature is not None:
	    temperatureREAD = int(temperature)
if humidity is not None:
	    humidityREAD = round(humidity)

# The next couple of lines will send the data collected to ThingSpeak for charting
desturl = baseURL + "&field1={0}&field2={1}&field3={2}&field4={3}".format(temperature,humidity,boardtemp,dehumidpwrstat)
f = urllib2.urlopen(desturl)
f.close()

# This section then uses the Humidity readings to determine if the Dehumidifier should be turned on or off based on the thresholds
# that were set further up in the script.

if humidityREAD >= humidityHI :
	print("Current time %s"  % now )
	print("Humidity is {} - above threshold. Turning on the dehumidifier".format(humidityREAD))
	print("Switching on the dehumidifier")
	subprocess.check_output("/usr/local/bin/hs100.sh YOUR_IP_HERE 9999 on", shell=True)
	time.sleep(3)
	dehumidpwrcheck = subprocess.check_output("/usr/local/bin/hs100.sh YOUR_IP_HERE 9999 check", shell=True)
	print("Dehumidifier is - {}".format(dehumidpwrcheck))
	print("=======================================================================")
elif humidityREAD <= humidityLO:
	print("Current time %s"  % now )
	print("Humidity is {} - below threshold. Turning off the dehumidifier".format(humidityREAD))
	print("Switching off the dehumidifier")
	subprocess.check_output("/usr/local/bin/hs100.sh YOUR_IP_HERE 9999 off", shell=True)
	time.sleep(3)
	dehumidpwrcheck = subprocess.check_output("/usr/local/bin/hs100.sh YOUR_IP_HERE 9999 check", shell=True)
	print("(Dehumidifier is - {}".format(dehumidpwrcheck))
	print("=======================================================================")
else:
	print("Do nothing")
	print("Current time %s"  % now )
	print("Humidity is {}".format(humidityREAD))
	print("=======================================================================")
	
sys.exit(0)
