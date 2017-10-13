---
date: 2016-04-09T16:50:16+02:00
title: Flogo CLI
weight: 10
pre: "<i class=\"fa fa-terminal\" aria-hidden=\"true\"></i> "
---

The flogo CLI tool has a bunch of different actions and command. Below is a complete list of all of them, including samples on how to use them.

## Commands
### create
This command is used to create a flogo application project.

*Create the base sample project with a specific name.*
	
	flogo create my_app
	
*Create a flogo application project from an existing flogo application descriptor.*
	
	flogo create -f myapp.json
		
### install
This command is used to install a contribution to your project.

*activity*

	flogo install github.com/TIBCOSoftware/flogo-contrib/activity/log
	
*trigger*

	flogo install github.com/TIBCOSoftware/flogo-contrib/trigger/rest
	
	
### uninstall
This command is used to remove a contribution to your project.

*activity*

	flogo uninstall github.com/TIBCOSoftware/flogo-contrib/activity/log
	
*trigger*

	flogo uninstall github.com/TIBCOSoftware/flogo-contrib/trigger/rest
	
### list
This command is used to list the activities, triggers, flows and models installed in the application.  
	 
	flogo list
	
	actions:
	  github.com/TIBCOSoftware/flogo-contrib/action/flow
	activities:
	  github.com/TIBCOSoftware/flogo-contrib/activity/log
	flow-model:
	  github.com/TIBCOSoftware/flogo-contrib/model/simple
	triggers:
	  github.com/TIBCOSoftware/flogo-contrib/trigger/rest

The list can be generated in a JSON format using the 'json' flag

	flogo list -json
	[
	  {
	    "type": "action",
	    "ref": "github.com/TIBCOSoftware/flogo-contrib/action/flow"
	  },
	  {
	    "type": "activity",
	    "ref": "github.com/TIBCOSoftware/flogo-contrib/activity/log"
	  },
	  {
	    "type": "flow-model",
	    "ref": "github.com/TIBCOSoftware/flogo-contrib/model/simple"
	  },
	  {
	    "type": "trigger",
	    "ref": "github.com/TIBCOSoftware/flogo-contrib/trigger/rest"
	  }
	]

### prepare
This command is used to prepare the application. Preperation consist of code generation for contribution metadata and go imports.

 	flogo prepare
 	
**options**
	
- [ -o ] : optimize compilation, compiled application will only contain contribution directly referenced in the flogo.json
- [ -e ] : embeds the configuration into the compiled application	 	 

### build
This command is used to build the application.  The *prepare* command is also invoked by default when doing a build.

 	flogo build
 	
**options**
	
- [ -o ] : optimize compilation, compiled application will only contain contribution directly referenced in the flogo.json
- [ -e ] : embeds the configuration into the compiled application
- [ -sp ] : skip *prepare* step

### help
This command is used to display help on a particular command
	
	flogo help build 

## Application Project

### Structure

The create command creates a basic structure and files for an application.


	my_app/
		flogo.json
		src/
			my_app/
				imports.go
				main.go
		vendor/
		
**files**

- *flogo.json* : flogo project application configuration descriptor file
- *imports.go* : contains go imports for contributions (activities, triggers and models) used by the application
- *main.go* : main file for the engine.

**directories**	
	
- *vendor* : go libraries


## Application Configuration

### Application

The *flogo.json* file is the metadata describing the application project.  

```json
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

***Trigger Configuration***

- id: the ID of the trigger
- settings: global settings for the trigger
- *handlers* the handlers for endpoints configured for the trigger
	- actionId: the ID of the action the handler invokes
	- settings: the handler specific settings