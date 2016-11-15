# flogo
Flogo Raspberry PI sample

The sample show how to use Flogo to control Raspberry PI GPIO

##Get start with samples

###Prerequisites

* Prepare raspberry pi device and install default raspbian operation system

### Import to Web UI
	
* Open Flogo web ui, eg:http://localhost:3303
* Click Import a flow
* Select raspberry_iot.json under web folder
* Now you can play Flogo on web ui.
* You cannot run it from web UI since it required raspberry pi environment so you should build engine by "build->ARM/Linux" and copy this executable file into raspberry environment and run it.

### Run from Flogo command line

* Please following flogo command line [Getting Started](https://github.com/TIBCOSoftware/flogo-cli#getting-started) guide
* Using flow [raspberry_iot.json](https://github.com/TIBCOSoftware/flogo/blob/master/samples/raspberry_iot/cli/raspberry_iot.json) that under cli folder
* Run command

```bash
flogo create raspberry_iot
cd raspberry_iot
flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/gpio
flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/log
flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/reply
flogo add trigger github.com/TIBCOSoftware/flogo-contrib/trigger/rest
#Make sure raspberry_iot.json file under current location
flogo add flow raspberry_iot.json
#Add build arguments since the default system is raspbian operation system
GOOS=linux GOARCH=arm GOARM=7 flogo build

```
	
* Configure Rest Trigger or copy below content into raspberry_iot/bin/trigger.json

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
          "actionURI": "embedded://raspberry_iot",
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
* Rename executabe file
```bash
  #Rename raspberry_iot-linux-arm to raspberry_iot
  mv raspberry_iot-linux-arm raspberry_iot
```
* Copy Flogo Engine and configuration file under bin folder to raspberry system
* Start Flogo Engine 
```bash
	./raspberry_iot
```
* Send a POST request to trigger
    For example:
    ```
        URL: http://${raspberryhostname}:9999/lights/status
    ```
* The GPIO 23 pin's value will be switched between 1 and 0


For more details about Rest Trigger configuration go [here](https://github.com/TIBCOSoftware/flogo-contrib/tree/master/trigger/rest#example-configurations)