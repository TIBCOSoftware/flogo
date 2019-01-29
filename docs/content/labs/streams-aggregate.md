---
title: "Streams: Aggregate"
hidden: true
---

Project Flogo is an ultra-light, Go-based open source ecosystem for building event-driven apps. It provides a bunch of capabilities to build those apps, like:

* **Integration Flows**: Application Integration process engine with conditional branching and a visual development environment
* **Stream Processing**: a simple pipeline-based stream processing action with event joining capabilities across multiple triggers & aggregation over time windows
* **Contextual Decisioning**: Declarative Rules for Real-time Contextual Decisions

In this tutorial you will learn how to use the _Stream Processing_ capability in Flogo

## What you'll need

### Flogo CLI

This demo makes use of the Flogo CLI. If you don't have that one running yet, please check out [Getting Started with the Flogo CLI](../../getting-started/getting-started-cli/)

### Need help

If you have any questions, feel free to post an [issue on GitHub](https://github.com/TIBCOSoftware/flogo/issues) and tag it as a question or chat with the team and community:

* The [project-flogo/Lobby](https://gitter.im/project-flogo/Lobby) Start here for all things Flogo!
* The [project-flogo/developers](https://gitter.im/project-flogo/developers) Developer/contributor focused conversations.

## Step 1: Prepare the app

The first step to create a Flogo streams app is to create a quick, barebones Flogo app using the Flogo CLI. Using the Flogo CLI, you'll need to specify that it should get the master branch of both `flogo-lib` to make sure you can build a streaming app correctly. The command to execute is

```bash
flogo create -flv <branch you need> <appname>
```

So in your case, using the name `aggregator`, the command will be

```bash
flogo create -flv github.com/TIBCOSoftware/flogo-contrib/activity/log@master,github.com/TIBCOSoftware/flogo-lib/app/resource@master aggregator
```

## Step 2: Create the JSON file

Open up the `flogo.json` file that was created in the _aggregator_ directory and delete all the contents. For this tutorial, you'll be guided through the different sections of the flogo.json and what they mean:

* Trigger
* Action
* Resources
* Stages

### General stuff

Before you can get to define the app, you'll need to define some metadata that the app model needs as well. The fields _name_, _type_, _version_, and _appModel_ describe the metadata of the app and the JSON model you're building through this tutorial. For this tutorial, that part of the file will look like:

```json
{
    "name": "aggregator",
    "type": "flogo:app",
    "version": "0.0.1",
    "appModel": "1.0.0",
}
```

### Trigger

Flogo is an event-driven framework. A trigger is the entrypoint for events. A trigger can be a subscriber on an MQTT topic, Kafka topic, HTTP REST interface or a specific IoT sensor. The trigger is responsible for accepting the incoming event and invoking one or more defined actions. In this case, the trigger will be the REST trigger that comes out-of-the-box with Flogo. The trigger has a bunch of configurations that are important:

* It will listen on port `9234`
* It will have a `GET` method registered for the endpoint `/aggregate/:val`
* As messages come in, it will call an action with id `simple_agg`
* The input to that action is a parameter called `input` and is _assigned_ the value of the PATH parameter `val`

Since there could be multiple triggers, the triggers element is an array. In this tutorial, though, you'll only use one REST trigger

```json
{
    "triggers": [
    {
      "id": "receive_http_message",
      "ref": "github.com/TIBCOSoftware/flogo-contrib/trigger/rest",
      "name": "Receive HTTP Message",
      "settings": {
        "port": "9234"
      },
      "handlers": [
        {
          "settings": {
            "method": "GET",
            "path": "/aggregate/:val"
          },
          "action": {
            "id": "simple_agg",
            "mappings": {
              "input": [
                {
                  "mapTo": "input",
                  "type": "assign",
                  "value": "$.pathParams.val"
                }
              ]
            }
          }
        }
      ]
    }
  ]
}
```

### Action

An action is a generic implementation for processing the incoming event. Different types of actions can be implemented, thus defining different methods by which an incoming event can be processed. In your case, a _pipeline_ is needed (which is implemented by the `github.com/project-flogo/stream` action) and it will dispatch the event to the resource with the URI `res://pipeline:simple_agg`

```json
{
  "actions": [
    {
      "id": "simple_agg",
      "ref": "github.com/project-flogo/stream",
      "settings": {
        "pipelineURI": "res://pipeline:simple_agg"
      }
    }
  ]
}
```

### Resources

The resources are the actual workhorses of the Flogo app. They define, among a ton of other things, the sequences in which activities have to be executed, rules that need to be followed and parameters that need to be mapped. First, let's look at the metadata of the resource that defines the input and the output. In this case the input is an integer called `input` and the output is an integer called `result`.

```json
{
    "resources": [
    {
      "id": "pipeline:simple_agg",
      "data": {
        "metadata": {
          "input": [
            {
              "name": "input",
              "type": "integer"
            }
          ],
          "output": [
            {
              "name": "result",
              "type": "integer"
            }
          ]
        },
}
```

### Stages

The stages, as the name implies, define the sequential steps that a pipeline needs to perform. The first step is the _aggregator_ activity, which:

* Sums all the inputs
* Using a time tumbling window of 5000 milliseconds (5 seconds)
* The input to the activity is simply a straight-through mapping of the input parameter

The second activity is a _log_ activity, where the _message_ field is mapped straight from the result field of the _aggregator_ activity. Note that in stream actions, unlike flow actions, only the output of the preceding activity is available and not all other outputs.

```json
{
    "stages": [
        {
            "ref": "github.com/TIBCOSoftware/flogo-contrib/activity/aggregate",
            "settings": {
                "function": "sum",
                "windowType": "timeTumbling",
                "windowSize": "5000"
            },
            "input": {
                "value": "=$.input"
            }
        },
        {
            "ref": "github.com/TIBCOSoftware/flogo-contrib/activity/log",
            "input": {
                "message": "=$.result"
            }
        }
    ]
}
```

### The completed flow

The complete flogo.json will look like

```json
{
  "name": "aggregator",
  "type": "flogo:app",
  "version": "0.0.1",
  "appModel": "1.0.0",
  "triggers": [
    {
      "id": "receive_http_message",
      "ref": "github.com/TIBCOSoftware/flogo-contrib/trigger/rest",
      "name": "Receive HTTP Message",
      "settings": {
        "port": "9234"
      },
      "handlers": [
        {
          "settings": {
            "method": "GET",
            "path": "/aggregate/:val"
          },
          "action": {
            "id": "simple_agg",
            "mappings": {
              "input": [
                {
                  "mapTo": "input",
                  "type": "assign",
                  "value": "$.pathParams.val"
                }
              ]
            }
          }
        }
      ]
    }
  ],
  "actions": [
    {
      "id": "simple_agg",
      "ref": "github.com/project-flogo/stream",
      "settings": {
        "pipelineURI": "res://pipeline:simple_agg"
      }
    }
  ],
  "resources": [
    {
      "id": "pipeline:simple_agg",
      "data": {
        "metadata": {
          "input": [
            {
              "name": "input",
              "type": "integer"
            }
          ],
          "output": [
            {
              "name": "result",
              "type": "integer"
            }
          ]
        },
        "stages": [
          {
            "ref": "github.com/TIBCOSoftware/flogo-contrib/activity/aggregate",
            "settings": {
              "function": "sum",
              "windowType": "timeTumbling",
              "windowSize": "5000"
            },
            "input": {
              "value": "=$.input"
            }
          },
          {
            "ref": "github.com/TIBCOSoftware/flogo-contrib/activity/log",
            "input": {
              "message": "=$.result"
            }
          }
        ]
      }
    }
  ]
}
```

## Step 3: Install dependencies

In your app, you're making use of a few external dependencies that you need to install into your app for the Go compiler to be able to successfully build the app. To install external dependencies, you need to run

```bash
flogo install <dependency location>
```

So in the case of this tutorial, you'll need to run

```bash
flogo install github.com/project-flogo/stream
flogo install github.com/TIBCOSoftware/flogo-lib/app/resource
flogo install github.com/TIBCOSoftware/flogo-contrib/activity/aggregate
```

## Step 4: Build the app

The next step is to build the executable. To build a flogo app from the source you can execute the command `flogo build -e`, which tells the flogo cli to build the app (and place it in a bin directory) and embed all configuration into a single executable

```bash
flogo build -e
```

## Step 5: Run

To run the app you just built, open a terminal and run

```bash
cd bin
./aggregator
```

You can send commands to it using cURL

```bash
curl --request GET --url http://localhost:9234/aggregate/1
```

If you send a number of requests within the 5000 millisecond window, the Flogo app will aggregate them and provide the sum of the numbers:

```bash
2018-10-04 07:47:31.444 INFO   [engine] - Engine Starting...
2018-10-04 07:47:31.444 INFO   [engine] - Starting Services...
2018-10-04 07:47:31.444 INFO   [engine] - Started Services
2018-10-04 07:47:31.444 INFO   [engine] - Starting Triggers...
2018-10-04 07:47:31.445 INFO   [engine] - Trigger [ receive_http_message ]: Started
2018-10-04 07:47:31.445 INFO   [engine] - Triggers Started
2018-10-04 07:47:31.445 INFO   [engine] - Engine Started
2018-10-04 07:48:41.514 INFO   [trigger-flogo-rest] - Received request for id 'receive_http_message'
2018-10-04 07:48:42.224 INFO   [trigger-flogo-rest] - Received request for id 'receive_http_message'
2018-10-04 07:48:42.784 INFO   [trigger-flogo-rest] - Received request for id 'receive_http_message'
2018-10-04 07:48:43.351 INFO   [trigger-flogo-rest] - Received request for id 'receive_http_message'
2018-10-04 07:48:46.515 INFO   [activity-flogo-log] - 4
```