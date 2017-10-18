---
date: 2016-04-09T16:50:16+02:00
title: Flogogen CLI
weight: 20
pre: "<i class=\"fa fa-terminal\" aria-hidden=\"true\"></i> "
---

The flogogen CLI tool has a bunch of different actions and command. Below is a complete list of all of them, including samples on how to use them. For a walk through of how to use these commands to create new extensions, check out the [extension developer](../../extensions-developer) chapter.

## Trigger
With the trigger command of **flogogen** you can create a custom flogo trigger. To do so, run:

```
flogogen trigger mytrigger
```

### Project Structure

The create command creates a basic structure and files for an trigger.

```
mytrigger\
		trigger.json
		trigger.go
		trigger_test.go
```

**files**

- *trigger.json* : trigger project metadata json file
- *trigger.go*   : rudimentary trigger implementation in go
- *trigger_test.go* : basic/initial test file for the trigger

## Action
With the action command of **flogogen** you can create a custom flogo action. To do so, run:

```
flogogen action myaction
```  	 

### Project Structure

The create command creates a basic structure and files for an action.

```
myaction\
		action.json
		action.go
		action_test.go
```

**files**

- *action.json* : action project metadata json file
- *action.go*   : rudimentary action implementation in go
- *action_test.go* : basic/initial test file for the action

## Activity
With the activity command of **flogogen** you can create a custom flogo activity. To do so, run:

```
flogogen activity myactivity
``` 

### Project Structure

The create command creates a basic structure and files for an activity.

```
myactivity\
		activity.json
		activity.go
		activity_test.go
```

**files**

- *activity.json* : activity project metadata json file
- *activity.go*   : rudimentary activity implementation in go
- *activity_test.go* : basic/initial test file for the activity

## Flowmodel
With the flowmodel command of **flogogen** you can create a custom flogo flowmodel. To do so, run:

```
flogogen flowmodel myflowmodel
``` 

### Project Structure

The create command creates a basic structure and files for an flowmodel.

```
myflowmodel\
		flowmodel.json
		flowmodel.go
		flowmodel_test.go
```

**files**

- *flowmodel.json* : flowmodel project metadata json file
- *flowmodel.go*   : rudimentary flowmodel implementation in go
- *flowmodel_test.go* : basic/initial test file for the flowmodel
