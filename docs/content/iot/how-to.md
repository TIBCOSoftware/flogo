---
date: 2016-04-09T16:50:16+02:00
title: How-to for IOT
weight: 20
---

Creating a flogo application is easy andand we've outlined the steps for you in this howto guide. This guide will walk you through the steps required to create a simple flogo application which can also be used on an IOT device.

## Prerequisites
Before you can get started building IOT applications with flogo, you need to have the following prerequisites installed:

* The Go programming language should be [installed](https://golang.org/doc/install).
* In order to simplify development and building in Go, we recommend using the **gb** build tool.  It can be downloaded from [here](https://getgb.io).
* You should have Flogo installed: `go get github.com/TIBCOSoftware/flogo-cli/...`

## Creating your App

### Getting Started

Once you have the prerequisites installed, you can create your application using the flogo CLI tool.  You can get more information on using the tool from the flogo-cli [readme](https://github.com/TIBCOSoftware/flogo-cli/blob/master/README.md). You can also find additional documentation on creating an application using the CLI tool in the app command [readme](https://github.com/TIBCOSoftware/flogo-cli/blob/master/docs/app.md).

Lets get started by creating a simple IOT application that just counts the number of requests it recieves.

### Application

First we'll start by creating the application using the CLI.  This creates the basic structure for your application.

```bash
flogo create myIotApp
cd myIotApp
``` 
### Flow

Next we'll create our flow, it will consist of two activities, a [counter](https://github.com/TIBCOSoftware/flogo-contrib/blob/master/activity/counter/README.md) activity that increments our request counter and a [log](https://github.com/TIBCOSoftware/flogo-contrib/blob/master/activity/log/README.md) activity that logs the current count.  Lets define our flow in the file named **reqcounter.json**.

```json
{
  "name": "Request Counter",
  "model": "tibco-simple",
  "type": 1,
  "attributes": [],
  "rootTask": {
    "id": 1,
    "type": 1,
    "activityType": "",
    "name": "root",
    "tasks": [
      {
        "id": 2,
        "type": 1,
        "activityType": "tibco-counter",
        "name": "Increment Request Count",
        "attributes": [
          { "name": "counterName", "type": "string" , "value": "requests" },
          { "name": "increment", "type": "boolean", "value": true }
        ]
      },
      {
        "id": 3,
        "type": 1,
        "activityType": "tibco-log",
        "name": "Log reqeuest count",
        "attributes": [],
        "inputMappings": [
          { "type": 1, "value": "{A2.value}", "mapTo": "message" }
        ]
      }
    ],
    "links": [
        { "id": 1, "type": 1,  "name": "", "from": 2, "to": 3 }
      ]
  }
}
```
Once we have our flow defined, we'll add it to our application along with the required activities. Note: you must add the activites you are using first, because the flogo CLI will validate to make sure that all activities used in a flow have been added to the application.

```bash

flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/log
flogo add activity github.com/TIBCOSoftware/flogo-contrib/activity/counter

flogo add flow reqcounter.json
``` 

###Trigger

Now lets configure our trigger.  For this example we'll use a simple REST trigger in order to simplify testing of you application.

```bash
flogo add trigger github.com/TIBCOSoftware/flogo-contrib/trigger/rest
```

Now that we have added our trigger, we can proceed with configuring it to kick off our flow.  We well trigger our flow using a simple **POST** to **/counter** on port 8189.  This configuration goes in triggers.json in the applications bin directory. Note that the flow we added earlier is now referenced as embedded://reqcounter

```json
{
  "triggers": [
    {
      "name": "tibco-rest",
      "settings": {
        "port": "8189"
      },
      "endpoints": [
        {
          "flowURI": "embedded://reqcounter",
          "settings": {
            "method": "POST",
            "path": "/counter"
          }
        }
      ]
    }
  ]
}
```

## Building your App
Now our application is ready to build. It can be built to run locally for preliminary testing and also for you IOT device.
### Local

To build a flogo application, you simply use the build command.

```bash
flogo build
```
This will compile your application and place the binary in the bin directory.  You can tweak the config.json and triggers.json and execute you application.  For more information on configuring and bulding your application reference the [app command readme] (https://github.com/TIBCOSoftware/flogo-cli/blob/master/docs/app.md) file.

### Device
Once you are ready to test your application on your device, the following links have information on specific devices including on how to build flogo for that device.

* [Raspberry Pi](device-pi.md) 
* [C.H.I.P.](device-chip.md)
* [Intel Edison](device-edison.md)
* [BeagleBone](device-beaglebone.md)

## Testing your App

Once you have your application built, you can execute the generated binary to test it out.  You should set the **loglevel** to **DEBUG** in the *bin\config.json* file when initially testing.

Once your app is started, you can test it out using a simple **curl** command.

```bash
curl -X POST http://localhost:8189/counter
```

Now you should see your counter value increment in the engine console with each invocation.


## References
* [GoArm](https://github.com/golang/go/wiki/GoArm) - General information on building for Go code for ARM 
* [Cross compilation with Go 1.5](http://dave.cheney.net/2015/08/22/cross-compilation-with-go-1-5)
* Supported Go [operating systems and architectures](https://golang.org/doc/install/source#environment)