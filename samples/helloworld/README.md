# flogo
Simple flow to count the number and print hello word

##Get start with samples

### Import to Web UI
	
* Open Flogo web ui, eg:http://localhost:3010
* Click Import a flow at right top of the page
* Select helloworld.json under web folder
* Now we can play on web ui.


### Run from Flogo command line

* Please following flogo command line [Getting Started](https://github.com/TIBCOSoftware/flogo-cli#getting-started) guide.
* Using flow [helloWorld.json](https://github.com/TIBCOSoftware/flogo/blob/master/samples/helloworld/cli/helloworld.json) that under cli folder.
* Run command


```bash
	flogo create helloworld
	cd helloworld

	flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/log
	flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/app
	flogo add trigger github.com/TIBCOSoftware/flogo-contrib/trigger/timer
	flogo add flow helloWorld.json
	flogo build
```
	
* Configure timer Trigger or copy below content into helloworld/bin/trigger.json
```json
{
  "triggers": [
    {
      "name": "tibco-timer",
      "settings": {},
      "endpoints": [
        {
          "actionType": "flow",
          "actionURI": "embedded://helloWorld",
          "settings": {
            "hours": "",
            "repeating": "true",
            "seconds": "15",
            "startDate": ""
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
	bin/helloworld
```


For more details about Timer Trigger configuration go [here](https://github.com/TIBCOSoftware/flogo-contrib/tree/master/trigger/timer#example-configurations)