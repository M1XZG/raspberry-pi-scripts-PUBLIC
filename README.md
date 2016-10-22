# Rob's Raspberry Pi Scripts

The scripts found in this repo are a collection of scripts I've created from scratch as well as heavily modified ones from other sources.  Where possible I've included all the links to originals and given full credit when possible.

##BerryClip-Script

The BerryClip is a simple, cheap and easy to use add-on board for the Raspberry Pi. It plugs directly onto the Pi's GPIO header and provides 6 
coloured LEDs, 1 Buzzer and 1 Switch. It can be controlled using any programming language that can manipulate the GPIO pins.

##dht22-templogger

This script does a number of things for me, using a DHT22 sensor connected to the RPi it will collect the temperature and humidity from the sensor as well as the temperature of the RPi board from it's onboard temperature sensor.  This data is then sent to https://thingspeak.com to the data is charted.

See the README.md in the dht22-templogger folder
