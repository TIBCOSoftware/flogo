# flogo
Flogo AWS Iot sample

![Flogo icon](flynn.png)

**Flogo** is process-flow engine written in Go. It was designed from the ground up to be robust enough for cloud applications and at the same time sufficiently lean for IOT devices.

##Get start with samples

###Prerequisites

* Create a things folder and AWS iot things name sub folder at any places
* The folder structure
```
├── things/
│   ├── root-CA.pem.crt
│   ├── flogo # Things name, take flogo as example
│   │   ├── device.pem.crt
│   │   ├── device.pem.key
```

* Download AWS IoT Certificate and Private file
* Replace AWS Iot Certificate to root-CA.pem.crt and device.pem.crt
* Replace AWS Iot Private key to device.pem.key
* Copy things folder to where you start flogo, copy to where you run docker-compose-start.sh for user flow.

Please keep name same with root-CA.pem.crt, device.pem.crt and device.pem.key)


### Import to Web UI
	
* Open Flogo web ui, eg:http://localhost:3010
* Click Import a flow at right top of the page
* Select aws_iot.json under web folder
* Now we can play on web ui.


### Run from Flogo command line

* Please following flogo command line [Getting Started](https://github.com/TIBCOSoftware/flogo-cli#getting-started) guide.
* Using flow [aws_iot.json](https://github.com/TIBCOSoftware/flogo/blob/master/samples/aws_iot/cli/aws_iot.json) that under cli folder.
* Run command

```bash
flogo create aws_iot
cd aws_iot
flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/awsiot
flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/log
flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/reply
flogo add trigger github.com/TIBCOSoftware/flogo-contrib/trigger/rest

flogo add flow aws_iot.json
flogo build

```
	
* Configure Rest Trigger or copy below content into aws_iot/bin/trigger.json

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
          "actionURI": "embedded://myflow",
          "settings": {
            "autoIdReply": "true",
            "method": "GET",
            "path": "/flow",
            "useReplyHandler": "true"
          }
        }
      ]
    }
  ]
}
```

* Modify Flogo engine configuration in bin/Config.json when necessary
* Copy [Prerequisites](#Prerequisites) things folder under bin/ folder
* Start Flogo Engine 
```bash
  cd bin
	./aws_iot
```


For more details about Rest Trigger configuration go [here](https://github.com/TIBCOSoftware/flogo-contrib/tree/master/trigger/rest#example-configurations)