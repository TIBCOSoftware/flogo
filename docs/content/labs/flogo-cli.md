---
title: Building apps with Flogo CLI
hidden: true
---

Project Flogo provides a CLI that gives you the ability to build flogo applications (flows, streams, rules, microgateway). With this tool you can, among other things, create your applications, build applications and install new extensions. This tool is great to use with Continuous Integration and Continuous Deployment tools like Jenkins and Travis-CI.

In this tutorial you will learn how to use the flogo cli.

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
  "name": "SampleApp",
  "type": "flogo:app",
  "version": "0.0.1",
  "appModel": "1.1.0",
  "description": "",
  "imports": [
    "github.com/project-flogo/contrib/activity/log",
    "github.com/project-flogo/contrib/trigger/rest",
    "github.com/project-flogo/flow"
  ],
  "triggers": [
    {
      "id": "receive_http_message",
      "ref": "#rest",
      "name": "Receive HTTP Message",
      "description": "Simple REST Trigger",
      "settings": {
        "port": 8080
      },
      "handlers": [
        {
          "settings": {
            "method": "GET",
            "path": "/test"
          },
          "action": {
            "ref": "#flow",
            "settings": {
              "flowURI": "res://flow:get_name"
            },
            "input": {
            },
            "output": {
              "code": 200
            }
          }
        }
      ]
    }
  ],
  "resources": [
    {
      "id": "flow:get_name",
      "data": {
        "name": "GetName",
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
            "name": "Log",
            "description": "Logs a message",
            "activity": {
              "ref": "#log",
              "input": {
                "message": "Hello from Flogo",
                "addDetails": false
              }
            }
          }
        ]
      }
    }
  ]
}
```

## Step 2: Building an app

To create the source code simply execute `flogo create -f flogo.json myapp`. This tells the Flogo CLI to take the `flogo.json` file and create the source for the app in a folder called `myapp`. It will also download a few Go packages that the app will need. The output will look something like:

```bash
flogo create -f /Users/mellis/Downloads/sample_app_1.json myapp
Creating Flogo App: myapp
Installing: github.com/project-flogo/core@latest
Installed trigger: github.com/project-flogo/contrib/trigger/rest
Installed action: github.com/project-flogo/flow
Installed activity: github.com/project-flogo/contrib/activity/log
```

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

To test it we'll use the curl command line tool, which is installed on most Operating Systems. From a new terminal window execute the command `curl http://localhost:8080/test`. It will send an HTTP request to the app on port `8080` (which was configured in the flogo.json file). In the first terminal you will see the result of the flow (`Hello from Flogo`), you'll also see there are additional lines in your window that indicate a flow has been executed.

```bash
2019-05-13T17:40:14.851+0200	INFO	[flogo.engine] -	Starting app [ SampleApp ] with version [ 0.0.1 ]
2019-05-13T17:40:14.851+0200	INFO	[flogo.engine] -	Engine Starting...
2019-05-13T17:40:14.851+0200	INFO	[flogo.engine] -	Starting Services...
2019-05-13T17:40:14.851+0200	INFO	[flogo] -	ActionRunner Service: Started
2019-05-13T17:40:14.851+0200	INFO	[flogo.engine] -	Started Services
2019-05-13T17:40:14.851+0200	INFO	[flogo.engine] -	Starting Application...
2019-05-13T17:40:14.851+0200	INFO	[flogo] -	Starting Triggers...
2019-05-13T17:40:14.851+0200	INFO	[flogo] -	Trigger [ receive_http_message ]: Started
2019-05-13T17:40:14.851+0200	INFO	[flogo] -	Triggers Started
2019-05-13T17:40:14.851+0200	INFO	[flogo.engine] -	Application Started
2019-05-13T17:40:14.851+0200	INFO	[flogo.engine] -	Engine Started
2019-05-13T17:40:14.851+0200	INFO	[flogo] -	Listening on http://0.0.0.0:8080
2019-05-13T17:40:33.456+0200	INFO	[flogo.activity.log] -	Hello from Flogo
2019-05-13T17:40:33.456+0200	INFO	[flogo.flow] -	Instance [28ac8005732b92373635a219624031dd] Done
```