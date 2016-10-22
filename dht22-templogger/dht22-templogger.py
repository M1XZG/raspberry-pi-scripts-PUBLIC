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

import datetime
today = datetime.date.today()

import time
import sys
import Adafruit_DHT
import RPi.GPIO as GPIO
import urllib2

import os
myhost = os.uname()[1]

if myhost == "pi1":
	myAPI = "O5S8WAQNHI32385I"
elif myhost == "pi2":
	myAPI = "BTCAFXK3I30GI3Y0"
elif myhost == "pi3":
	myAPI = ""


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

        sys.exit(0)


	#time.sleep(120)

