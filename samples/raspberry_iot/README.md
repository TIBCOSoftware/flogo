# flogo
Flogo Raspberry PI sample

The sample show how to use Flogo to control Raspberry PI GPIO

##Get start with samples

###Prerequisites

* Prepare raspberry pi device and install default raspbian operation system
* Install [WebIOPI](http://webiopi.trouch.com/INSTALL.html)
* Disable authentication for webiopi by rename /etc/webiopi/passwd to /etc/webiopi/passwd_bak
* Start WebIOPI server.
* Open WebIOPI web ui http://raspberrypi:8000/app/gpio-header
* Change GPIO 23 to OUT function that we use for this sample

### Import to Web UI
	
* Open Flogo web ui, eg:http://localhost:3010
* Click Import a flow at right top of the page
* Select raspberry_pi.json under web folder
* Add raspberrypi and raspberry pi ip to your host file.
```
  10.97.170.106 raspberrypi
```
* Now you can play Flogo on web ui.

### Run from Flogo command line

* Please following flogo command line [Getting Started](https://github.com/TIBCOSoftware/flogo-cli#getting-started) guide
* Using flow [raspberry_pi.json](https://github.com/TIBCOSoftware/flogo/blob/master/samples/raspberry_pi/cli/raspberry_pi.json) that under cli folder
* Add raspberrypi and raspberry pi ip to your host file.
```
  10.97.170.106 raspberrypi
```
* Run command

```bash
flogo create raspberry_pi
cd raspberry_pi
flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/awsiot
flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/log
flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/reply
flogo add trigger github.com/TIBCOSoftware/flogo-contrib/trigger/rest

flogo add flow raspberry_pi.json
flogo build

```
	
* Configure Rest Trigger or copy below content into raspberry_pi/bin/trigger.json

```json
{
  "triggers": [
    {
      "name": "tibco-rest",
      "settings": {
        "port": "9999"
      },
      "endpoints": [
        {
          "actionType": "flow",
          "actionURI": "embedded://flow",
          "settings": {
            "autoIdReply": "true",
            "method": "POST",
            "path": "/lights/status",
            "useReplyHandler": "true"
          }
        }
      ]
    }
  ]
}
```

* Modify Flogo engine configuration in bin/Config.json when necessary
* Start Flogo Engine 
```bash
  cd bin
	./raspberry_pi
```
* Send a POST request to trigger with light id(0 or 1)
    For example:
    ```
        URL: http://localhost:9999/lights/status
    ```
* The GPIO 23 pin's value will be changed. Switch value 1 and 0


For more details about Rest Trigger configuration go [here](https://github.com/TIBCOSoftware/flogo-contrib/tree/master/trigger/rest#example-configurations)