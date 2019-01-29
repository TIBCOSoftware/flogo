---
title: Building apps with Flogo CLI
hidden: true
---

Project Flogo provides two different command-line interfaces and which you need depends on the task you need to execute.

* `flogo`: This CLI gives you the ability to build flows and microservices. With this tool you can, among other things, create your applications, build applications and install new extensions. This tool is great to use with Continuous Integration and Continuous Deployment tools like Jenkins and Travis-CI.
* `flogogen`: If you’re looking to extend the functionality that Project Flogo offers out of the box, this is the tool you want to use. Flogogen generates the scafolding used by extensions (activity/trigger) developers to build new extensions.

In this tutorial you will learn how to use the first of the two CLI tools

## What you'll need

### Flogo CLI

This demo makes use of the Flogo CLI. If you don't have that one running yet, please check out [Getting Started with the Flogo CLI](../../getting-started/getting-started-cli/)

### Need help

If you have any questions, feel free to post an [issue on GitHub](https://github.com/TIBCOSoftware/flogo/issues) and tag it as a question or chat with the team and community:

* The [project-flogo/Lobby](https://gitter.im/project-flogo/Lobby) Start here for all things Flogo!
* The [project-flogo/developers](https://gitter.im/project-flogo/developers) Developer/contributor focused conversations.

## Step 1: flogo.json

Flogo apps are constructed using a JSON file called `flogo.json`. You can create those files using the Flogo Web UI, or you can create them manually. Now let's create the flogo.json file. To do that, execute `touch flogo.json` in a terminal (or open up a new file in your text editor), which will create a new empty file for you.

Now you can copy the contents below to the newly created flogo.json file. The Flogo app has a REST trigger which listens on port 9233 and the HTTP path `/test/:name` (where `:name` is a parameter you can fill in).

```json
{
  "name": "Tutorial",
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
        "port": "9233"
      },
      "handlers": [
        {
          "action": {
            "ref": "github.com/TIBCOSoftware/flogo-contrib/action/flow",
            "data": {
              "flowURI": "res://flow:http_flow"
            },
            "mappings": {
              "input": [
                {
                  "mapTo": "name",
                  "type": "assign",
                  "value": "$.pathParams.name"
                }
              ],
              "output": [
                {
                  "mapTo": "data",
                  "type": "assign",
                  "value": "$.greeting"
                },
                {
                  "mapTo": "code",
                  "type": "literal",
                  "value": 200
                }
              ]
            }
          },
          "settings": {
            "method": "GET",
            "path": "/test/:name"
          }
        }
      ]
    }
  ],
  "resources": [
    {
      "id": "flow:http_flow",
      "data": {
        "name": "HTTPFlow",
        "metadata": {
          "input": [
            {
              "name": "name",
              "type": "string"
            }
          ],
          "output": [
            {
              "name": "greeting",
              "type": "string"
            }
          ]
        },
        "tasks": [
          {
            "id": "log_2",
            "name": "Log Message",
            "description": "Simple Log Activity",
            "activity": {
              "ref": "github.com/TIBCOSoftware/flogo-contrib/activity/log",
              "input": {
                "message": "",
                "flowInfo": "false",
                "addToFlow": "false"
              },
              "mappings": {
                "input": [
                  {
                    "type": "expression",
                    "value": "string.concat(\"Hello \", $flow.name)",
                    "mapTo": "message"
                  }
                ]
              }
            }
          },
          {
            "id": "actreturn_3",
            "name": "Return",
            "description": "Simple Return Activity",
            "activity": {
              "ref": "github.com/TIBCOSoftware/flogo-contrib/activity/actreturn",
              "input": {
                "mappings": [
                  {
                    "type": "expression",
                    "value": "string.concat(\"Hello \", $flow.name)",
                    "mapTo": "greeting"
                  }
                ]
              }
            }
          }
        ],
        "links": [
          {
            "from": "log_2",
            "to": "actreturn_3"
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

To test it we'll use the curl command line tool, which is installed on most Operating Systems. From a new terminal window execute the command `curl http://localhost:9233/test/flogo`. It will send an HTTP request to the app on port `9233` (which was configured in the flogo.json file). In the second terminal you will see the result of the flow (`Hello flogo`) and when you go back to the first terminal you had, you'll see there are additional lines in your window that indicate a flow has been executed. Now try it out with your own name and see what happens :)

```bash
2018-05-12 04:35:00.632 INFO   [trigger-flogo-rest] - Received request for id 'receive_http_message'
2018-05-12 04:35:00.632 INFO   [engine] - Running FlowAction for URI: 'res://flow:http_flow'
2018-05-12 04:35:00.633 INFO   [activity-flogo-log] - Hello flogo
2018-05-12 04:35:00.633 INFO   [engine] - Flow instance [29db1cc55a96c27c280227b2d7b8be82] Completed Successfully
2018-05-12 04:35:15.364 INFO   [trigger-flogo-rest] - Received request for id 'receive_http_message'
2018-05-12 04:35:15.364 INFO   [engine] - Running FlowAction for URI: 'res://flow:http_flow'
2018-05-12 04:35:15.364 INFO   [activity-flogo-log] - Hello leon
2018-05-12 04:35:15.365 INFO   [engine] - Flow instance [2adb1cc55a96c27c280227b2d7b8be82] Completed Successfully
```