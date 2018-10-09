---
title: IoT Apps
hidden: true
---

Flogo can run almost anywhere. From the largest clouds, to the smallest of devices and everything in between. Take this lab to get yourself familiar with how to develop apps for IoT devices using the Flogo CLI.

## What you'll need

### Flogo CLI

This demo makes use of the Flogo CLI. If you don't have that one running yet, please check out [Getting Started with the Flogo CLI](../../getting-started/getting-started-cli/)

### Need help

If you have any questions, feel free to post an [issue on GitHub](https://github.com/TIBCOSoftware/flogo/issues) and tag it as a question or chat with the team and community:

* The [project-flogo/Lobby](https://gitter.im/project-flogo/Lobby) Start here for all things Flogo!
* The [project-flogo/developers](https://gitter.im/project-flogo/developers) Developer/contributor focused conversations.

## Step 1: flogo.json

Flogo apps are constructed using a JSON file called `flogo.json`. You can create those files using the Flogo Web UI, or you can create them manually. Now let's create the flogo.json file. To do that, execute `touch flogo.json` in a terminal (or open up a new file in your text editor), which will create a new empty file for you. The app you'll build has a REST trigger that counts the number of times it is invoked and logs that to the console.

```json
{
  "name": "IoTApp",
  "type": "flogo:app",
  "version": "0.0.1",
  "appModel": "1.0.0",
  "triggers": [
    {
      "id": "receive_http_message",
      "ref": "github.com/TIBCOSoftware/flogo-contrib/trigger/rest",
      "name": "Receive HTTP Message",
      "description": "Simple REST Trigger",
      "settings": {
        "port": 9233
      },
      "handlers": [
        {
          "action": {
            "ref": "github.com/TIBCOSoftware/flogo-contrib/action/flow",
            "data": {
              "flowURI": "res://flow:counter_flow"
            }
          },
          "settings": {
            "method": "GET",
            "path": "/counter"
          }
        }
      ]
    }
  ],
  "resources": [
    {
      "id": "flow:counter_flow",
      "data": {
        "name": "CounterFlow",
        "tasks": [
          {
            "id": "counter_2",
            "name": "Increment Counter",
            "description": "Simple Global Counter Activity",
            "activity": {
              "ref": "github.com/TIBCOSoftware/flogo-contrib/activity/counter",
              "input": {
                "counterName": "number",
                "increment": true,
                "reset": false
              }
            }
          },
          {
            "id": "log_3",
            "name": "Log Message",
            "description": "Simple Log Activity",
            "activity": {
              "ref": "github.com/TIBCOSoftware/flogo-contrib/activity/log",
              "input": {
                "flowInfo": "false",
                "addToFlow": "false"
              },
              "mappings": {
                "input": [
                  {
                    "type": "assign",
                    "value": "$activity[counter_2].value",
                    "mapTo": "message"
                  }
                ]
              }
            }
          }
        ],
        "links": [
          {
            "from": "counter_2",
            "to": "log_3"
          }
        ]
      }
    }
  ]
}
```

## Step 2: Building an app

To create the source code simply execute `flogo create -f flogo.json myapp`. This tells the Flogo CLI to take the `flogo.json` file and create the source for the app in a folder called `myapp`. It will also download a few Go packages that the app will need.

The next step is to build the executable and for that we need to be in the directory `myapp` (`cd myapp`). To build a flogo app from the source you can execute the command `flogo build -e`, which tells the flogo cli to build the app (and place it in a bin directory) and embed all configuration into a single executable

## Step 3: Running the app

You have just built the Flogo app, so now you can test it. From the bin directory (`cd bin`) you can run `./myapp` which will start the app. In the terminal you'll see something like

```bash
2018-05-12 04:34:56.434 INFO   [engine] - Engine Starting...
2018-05-12 04:34:56.435 INFO   [engine] - Starting Services...
2018-05-12 04:34:56.435 INFO   [engine] - Started Services
2018-05-12 04:34:56.435 INFO   [engine] - Starting Triggers...
2018-05-12 04:34:56.435 INFO   [engine] - Trigger [ receive_http_message ]: Started
2018-05-12 04:34:56.435 INFO   [engine] - Triggers Started
2018-05-12 04:34:56.435 INFO   [engine] - Engine Started
```

To test it we'll use the curl command line tool, which is installed on most Operating Systems. From a new terminal window execute the command `curl http://localhost:9233/counter`. It will send an HTTP request to the app on port `9233` (which was configured in the flogo.json file) and it will log the number of invocations.

## Step 4: Getting it to your device

Once you are ready to test your application on your device, check out these specialized labs that talk about building Flogo apps specifically for that device.

* [Raspberry Pi](../raspberry-iot-cli) 
* [Intel Edison](../edison)
* [BeagleBone](../beaglebone)
