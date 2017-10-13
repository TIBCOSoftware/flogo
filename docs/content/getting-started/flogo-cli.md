---
date: 2016-04-09T16:50:16+02:00
title: Flogo CLI
weight: 40
pre: "<i class=\"fa fa-terminal\" aria-hidden=\"true\"></i> "
---

Project Flogo provides two different command-line interfaces and which you need depends on the task you need to execute. The **flogo** CLI tool gives you the ability to build flows and microservices. With this tool you can, among other things, create your applications, build applications and install new extensions. It is also great to use with Continuous Integration and Continuous Deployment tools like Jenkins and Travis-CI.

{{% notice info %}}
Please make sure that you have installed the **flogo CLI** tools and **gb** as described in the [CLI tools](../getting-started-cli)
{{% /notice %}}

### Building your app

A flogo application, or microservice, is created using the flogo CLI tool. The tool can be used to create an application from an existing flogo.json or to create a simple base application to get you started. Let's walk through building a simple microservice. To get started open a terminal window and type in a few commands:

Step 1: Let the flogo tool create the required JSON files

```
flogo create myapp
```
This will create a folder called _myapp_, create a sample **flogo.json** file and download the dependencies to build your flogo app.

Step 2: Build your app

```
cd myapp
flogo build
```

Step 3: Run your app

```
cd bin
./myapp
```
This command will start your microservice. The sample app has a REST API, so you can point your browser to http://localhost:9233/test and see a message. You'll see some output on the terminal as well:

```
2017-10-13 11:34:27.411 INFO   [engine] - Engine: Starting...
2017-10-13 11:34:27.416 INFO   [engine] - Engine: Starting Services...
2017-10-13 11:34:27.416 INFO   [engine] - Engine: Started Services
2017-10-13 11:34:27.417 INFO   [engine] - Trigger [my_rest_trigger] started
2017-10-13 11:34:27.418 INFO   [engine] - Engine: Started
2017-10-13 11:34:50.824 INFO   [trigger-tibco-rest] - REST Trigger: Received request for id 'my_rest_trigger'
2017-10-13 11:34:50.825 INFO   [engine] - In Flow Run uri: 'my_simple_flow'
2017-10-13 11:34:50.828 INFO   [engine] - FlowInstance Flow: &{tibco-simple 0xa2f220 map[1:0xa2f220]}
2017-10-13 11:34:50.829 INFO   [activity-tibco-log] - Simple Log
2017-10-13 11:34:50.829 INFO   [engine] - Flow [06e80b48b35f72142dd40e1d5776557b] Completed
2017/10/13 11:34:50 http: multiple response.WriteHeader calls
```

### Updating the sample
The microservice we just built is based on a simple REST API and uses the below flogo.json for configuration. You can make changes to update the configuration or add additional triggers and actions. The flogo.json files can also be exported from the [Flogo Web UI](../getting-started-webui)

```
{
  "name": "myApp",
  "type": "flogo:app",
  "version": "0.0.1",
  "description": "My flogo application description",
  "triggers": [
    {
      "id": "my_rest_trigger",
      "ref": "github.com/TIBCOSoftware/flogo-contrib/trigger/rest",
      "settings": {
        "port": "9233"
      },
      "handlers": [
        {
          "actionId": "my_simple_flow",
          "settings": {
            "method": "GET",
            "path": "/test"
          }
        }
      ]
    }
  ],
  "actions": [
    {
      "id": "my_simple_flow",
      "ref": "github.com/TIBCOSoftware/flogo-contrib/action/flow",
      "data": {
        "flow": {
          "attributes": [],
          "rootTask": {
            "id": 1,
            "type": 1,
            "tasks": [
              {
                "id": 2,
                "type": 1,
                "activityRef": "github.com/TIBCOSoftware/flogo-contrib/activity/log",
                "name": "log",
                "attributes": [
                  {
                    "name": "message",
                    "value": "Simple Log",
                    "type": "string"
                  }
                ]
              }
            ],
            "links": [
            ]
          }
        }
      }
    }
  ]
}
```

### More help
For additional documentation on the flogo CLI, check out [this](../../flogo-cli/flogo-cli/) section.