#!/usr/bin/python

# HEADER
###################################################################################################
#
# Author        : Robert McKenzie <rmckenzi@rpmdp.com>
# Script Name   : dht22-templogger.py
# Description   : This python script will collect temp and humidity from dht22 and cpu temp from
#                 the PI motherboard and feed this data back to http://thingspeak.com
#
###################################################################################################

# Imports

import datetime
import time
import sys
import Adafruit_DHT
import RPi.GPIO as GPIO
import urllib2
import os

# Get the date

today = datetime.date.today()

# If you only use this script on ONE Raspberry Pi then define your ThingSpeak API Key below, otherwise, comment this out and
# see the next section

myAPI = "<API KEYHERE>"

# I use the same script on multiple raspberry pi's, these require different thingspeak.com channels, define your API's here
# If you use more than one Raspberry Pi you can uncomment the section below, change your Pi's hostnames and add the various
# API Keys for your different channels that relate to the seperate Pi's.

#myhost = os.uname()[1]
#if myhost == "pi1":
#	myAPI = "<API KEY HERE>"
#elif myhost == "pi2":
#	myAPI = "<API KEY HERE>"
#elif myhost == "pi3":
#	myAPI = "<API KEY HERE>"


sensor = Adafruit_DHT.DHT22
pin = 4
baseURL = 'https://api.thingspeak.com/update?api_key=%s' % myAPI

GPIO.setmode(GPIO.BCM)

while 1:

        #print "---------------------------------------"
        import subprocess
        boardtemp = subprocess.check_output("/usr/local/bin/get-pitemp.sh", shell=True)
	#dehumidpwr = subprocess.check_output("/usr/local/bin/hs100-check.sh 172.16.29.146", shell=True)
	dehumidpwr = subprocess.check_output("/usr/local/bin/hs100.sh 172.16.29.146 9999 check", shell=True)

        humidity, temperature = Adafruit_DHT.read_retry(sensor, pin)
	if temperature is not None:
		    temperature = '{:.2f}'.format(temperature)
	if humidity is not None:
		    humidity = '{:.2f}'.format(humidity)

        desturl = baseURL + "&field1={0}&field2={1}&field3={2}&field4={3}".format(temperature,humidity,boardtemp,dehumidpwr)
        f = urllib2.urlopen(desturl)
        f.close()

# Output debugging area here

	#print desturl
        #print temperature
        #print humidity
	#print boardtemp
	#print dehumidpwr

# The sys.exit is used if you want to call the script from CRON or just casually, if you want to run this continuously in the
# background maybe through SCREEN or just nohup, then comment out the sys.exit line and uncomment the time.sleep line, the 120
# is the number of seconds the script will sleep before looping back through the data collection and posting again.  I call
# mine through cron using
#
# */2 * * * /path/to/dht22-templogger.py

        sys.exit(0)
	#time.sleep(120)

