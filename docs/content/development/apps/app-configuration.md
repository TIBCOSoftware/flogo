---
title: App Model
weight: 4220
---

# Flogo Application Model

The *flogo.json* file is the metadata describing an application. The application dictates the dependencies to be used during compile time and can also be embeded into the compiled binary.

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
              "name": "=$.content.name"
            },
            "output": {
              "code": 200,
              "data": "=$.greeting"
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
                "message": "",
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

## Root Properties

- name: The application name
- type: The type of application. Currently the only valid value is `flogo:app`
- version: **Your** application version
- appModel: The version of the current app model. This should be: **"1.1.0"**
- description: **Your** application description
- imports: The contributions that your application will use. The `imports` array is used by the CLI include specific imports and versions in your application at build time. Use this to specify any additional contributions, such as, functions, that you'd like to leverage. The CLI will automatically pull any mentioned contribs at app create or during `flogo imports sync` command.

## Triggers

- id: the ID of the trigger
- settings: global settings for the trigger
- *handlers* the handlers for endpoints configured for the trigger
	- actionId: the ID of the action the handler invokes
	- settings: the handler specific settings