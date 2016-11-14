# flogo
Flogo AWS Iot sample

Use AWS-IOT sample to update AWS-IoT Shadow

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
* Mount things folde into flogo-web container when you start flogo: 
```bash
 docker run -it -p 3303:3303 -v ${thingsFolderPath}:/tmp/flogo-web/build/server/test-engine/bin/things flogo/flogo-web
```

Please keep name same with root-CA.pem.crt, device.pem.crt and device.pem.key)


### Import to Web UI
	
* Open Flogo web ui, eg:http://localhost:3303
* Click Import a flow at right top of the page
* Select aws_iot.json under web folder
* Change the AWS-IOT(Update) acitivity's thingName and awsEndpoint field 
* Now we can play on web ui.


### Run from Flogo command line

* Please following flogo command line [Getting Started](https://github.com/TIBCOSoftware/flogo-cli#getting-started) guide
* Using flow [aws_iot.json](https://github.com/TIBCOSoftware/flogo/blob/master/samples/aws_iot/cli/aws_iot.json) that under cli folder
* Change the things name and awsEndpoint in flow to your AWS IOT related
* Run command

```bash
flogo create aws_iot
cd aws_iot
flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/awsiot
flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/log
flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/reply
flogo add trigger github.com/TIBCOSoftware/flogo-contrib/trigger/rest
#Make sure aws_iot.json file under current location
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
          "actionURI": "embedded://aws_iot",
          "settings": {
            "autoIdReply": "true",
            "method": "PUT",
            "path": "/awsiot/status",
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
* Send a PUT request to trigger with update aws-iot device shadow reported content.
    For example:
    ```
        URL: http://localhost:9999/awsiot/status
        
        Body: {"switch":"on"} 
    ```


For more details about Rest Trigger configuration go [here](https://github.com/TIBCOSoftware/flogo-contrib/tree/master/trigger/rest#example-configurations)