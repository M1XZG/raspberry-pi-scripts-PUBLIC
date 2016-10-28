# dht22-templogger.py
=====

## Description

This script was created from a number of sources, many I'm afraid I can no longer recall.  My python skills are pretty lame, but I was able to cobble together several scripts that did various things that I wanted into this one.  Previous versions did things like log to a CSV file locally, but that's cumbersome.  I then had it dumping to a Google Docs Sheet, that worked well however the limitations of Google Sheets was very quickly reached and things broke.  Finally, I found scripts to let me log to https://thingsspeak.com.  Since then there's no looking back.

## Items required for this

### Raspberry Pi (I'd recommend the 3, but any one will do)
Get one here - http://amzn.to/2eSQvU8

### DHT22 Digital Humidity AM2302 and Temperature Sensor Module
Get one here - http://amzn.to/2eSQiAh

## Instructions

There is very little editing required for this script, however there are some bits you MUST edit.

First, I use this same script on multiple Pi's, the script will use the correct ThingSpeak API Key based on the hostname.  If you only use this on Pi then edit the following line in the script

```python
myAPI = "<API KEY HERE>"
```

If you use multiple Pi's, comment that line out and uncomment section below that and change the hostnames and API Key's for each host.  You can easily delete and add more elif lines as you see fit.   Change the hostname to what you get from 'uname -n', and put in the key.

```python
myhost = os.uname()[1]
if myhost == "<HOST 1>":
	myAPI = "<API KEY HERE>"
elif myhost == "<HOST 2>":
	myAPI = "<API KEY HERE>"
elif myhost == "<HOST 3>":
	myAPI = "<API KEY HERE>"
```

One other modification you may require will be in this line

```python
desturl = baseURL + "&field1={0}&field2={1}&field3={2}".format(temperature,humidity,boardtemp)
```
On my ThingSpeak channel (https://thingspeak.com/channels/155954), the first 3 charts are in the order of DHT22 Temperature, DHT22 Humidity then finally the Pi board temperature.  You may want to alter the order these are sent to ThingSpeak, or if you want to not include some data then just remove it.


That's pretty much it.  Just call the script and it should work.
