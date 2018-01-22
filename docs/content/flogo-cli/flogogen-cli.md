---
title: flogogen
weight: 5030
pre: "<i class=\"fa fa-terminal\" aria-hidden=\"true\"></i> "
---

The **flogogen** CLI tool is the tool you want to use if you're looking to extend the functionality that Project Flogo offers out of the box, this is the tool you want to use. Flogogen generates the scafolding used by extensions (activity/trigger) developers to build new extensions.. Below is a complete list of all all commands supported, including samples on how to use them.

{{% notice info %}}
Please make sure that you have installed the **flogo** tools as described in [Getting Started > Flogo CLI](../../getting-started/getting-started-cli/)
{{% /notice %}}

## action
Create a custom flogo action.
```
Usage: 

flogogen action ActionName
```	 

Running this command creates a basic structure and files for an action.

```
ActionName\
	action.json
	action.go
	action_test.go
```
The three generated files contain data for your action

* *action.json* : action project metadata json file
* *action.go*   : rudimentary action implementation in go
* *action_test.go* : basic/initial test file for the action

## activity
Ccreate a custom flogo activity.
```
Usage:

flogogen activity ActivityName
``` 

Running this command creates a basic structure and files for an activity.

```
ActivityName\
	activity.json
	activity.go
	activity_test.go
```

The three generated files contain data for your activity

* *activity.json* : activity project metadata json file
* *activity.go*   : rudimentary activity implementation in go
* *activity_test.go* : basic/initial test file for the activity

## flowmodel
Create a custom flogo flowmodel.
```
Usage:

flogogen flowmodel MyFlowmodel
``` 

Running this command creates a basic structure and files for a flowmodel.

```
MyFlowmodel\
	flowmodel.json
	flowmodel.go
	flowmodel_test.go
```

The three generated files contain data for your flowmodel

- *flowmodel.json* : flowmodel project metadata json file
- *flowmodel.go*   : rudimentary flowmodel implementation in go
- *flowmodel_test.go* : basic/initial test file for the flowmodel

## trigger
Create a custom flogo trigger.
```
Usage:

flogogen trigger MyTrigger
```

Running this command creates a basic structure and files for a trigger.

```
MyTrigger\
	trigger.json
	trigger.go
	trigger_test.go
```

The three generated files contain data for your trigger

- *trigger.json* : trigger project metadata json file
- *trigger.go*   : rudimentary trigger implementation in go
- *trigger_test.go* : basic/initial test file for the trigger
