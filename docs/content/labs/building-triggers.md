---
title: Building your first trigger
hidden: true
---

Project Flogo provides two different command-line interfaces and which you need depends on the task you need to execute.

* `flogo`: This CLI gives you the ability to build flows and microservices. With this tool you can, among other things, create your applications, build applications and install new extensions. This tool is great to use with Continuous Integration and Continuous Deployment tools like Jenkins and Travis-CI.
* `flogogen`: If you’re looking to extend the functionality that Project Flogo offers out of the box, this is the tool you want to use. Flogogen generates the scafolding used by extensions (activity/trigger) developers to build new extensions.

In this tutorial you will learn how to use the `flogogen` tool.

## What you'll need

### Flogo CLI

This demo makes use of the Flogo CLI. If you don't have that one running yet, please check out [Getting Started with the Flogo CLI](../../getting-started/getting-started-cli/)

### Need help

If you have any questions, feel free to post an [issue on GitHub](https://github.com/TIBCOSoftware/flogo/issues) and tag it as a question or chat with the team and community:

* The [project-flogo/Lobby](https://gitter.im/project-flogo/Lobby) Start here for all things Flogo!
* The [project-flogo/developers](https://gitter.im/project-flogo/developers) Developer/contributor focused conversations.

## Generate the basic framework

The easiest way to start creating activities is to have the **flogogen** CLI create the basic framework for you. The flogogen CLI takes two important parameters to create the framework for triggers. Timers are great to schedule stuff, and a great way to learn new technology, so in this tutorial you'll build a new timer trigger that runs on a specified interval. To start you need to use flogogen to create the scaffolding:

```bash
flogogen trigger < name >
```

The parameters are:

* **trigger**: because you want to create a trigger
* **< name >**: the name for your new trigger (in this example you'll use `MyTimerTrigger` as the name for the trigger to make sure it doesn't clash with the existing timer)

So to generate our scaffolding, you need to execute the command:

```bash
flogogen trigger MyTimerTrigger
```

The flogogen command will create a folder called `MyTimerTrigger` and generate the files you need to implement your logic:

```bash
MyTimerTrigger
├── trigger.go       <-- The implementation of your trigger
├── trigger.json     <-- The metadata of your trigger
└── trigger_test.go  <-- A file used to test your trigger
```

## The metadata

The first step is to update the file `activity.json`, which has the metadata for your new Flogo activity, with proper information. The metadata describes to the Flogo engine what the activity is called, what the version of the activity is and a few other things. The elements in the file are:

* **name**: The name of the activity (this should match the name of the folder the activity is in, like `MyTimerTrigger`)
* **version**: The version of the activity (it is recommended to use [semantic versioning](https://semver.org/) for your trigger) 
* **type**: This describes to the Flogo engine what kind of contribution this is (this should be `trigger` in this case)
* **ref**: The Flogo engine is based on Go and this field is the "import" path for Go apps (generally speaking this should match your repository)
* **description**: A brief description of your activity (this is displayed in the Flogo Web UI)
* **author**: This is you!
* **settings**: An array of name/type pairs that describe global settings of the trigger (configuration that will be the same for every instance of this trigger used in your app)
* **output**: An array of name/type pairs that describe the output of the trigger (the data that gets sent to your flow)
* **handler**: An array of name/type pairs that describe flow specific settings of the trigger (configuration that will be unique for every instance of this trigger used in your app)

Since you'll want to provide some configuration, you'll need to update the outputs section

* The **settings** section will be left empty (you'll use flow specific settings)
* The **output** section needs a parameter called **output** (should be of type `string`)
* The **handler/settings** section needs a parameter called **seconds** (should be of type `string`)

{{% notice tip %}}
Don't forget to update the **author**, **ref**, and **description** fields, as well!
{{% /notice %}}

The updated trigger.json will look quite similar to the below one.

```json
{
  "name": "MyTimerTrigger",
  "version": "0.0.1",
  "type": "flogo:trigger",
  "description": "This is a new Timer",
  "ref": "github.com/yourusername/yourrepository",
  "author": "Flogo Dev",
  "settings":[
  ],
  "output": [
    {
      "name": "output",
      "type": "string"
    }
  ],
  "handler": {
    "settings": [
      {
        "name": "seconds",
        "type": "string"
      }
    ]
  }
}
```

## The logic

For the Flogo engine to actually do something we need to update the `*.go` files. There are two files in your current directory:

* **trigger.go**: which contains the actual trigger implementation in go
* **trigger_test.go**: which contains unit tests for the trigger

The first step is to look at the business logic, in the **trigger.go** file.

To begin there are a few packages you'll need to import to make sure the code will work:

```go
"context"
"strconv"
"github.com/TIBCOSoftware/flogo-lib/core/trigger"
"github.com/TIBCOSoftware/flogo-lib/logger"
"github.com/carlescere/scheduler"
```

As you want to log output to the console you'll need to add a new variable called `log` to the main part of the file

```go
// Create a new logger
var log = logger.GetLogger("trigger-mytrigger")
```

The struct called `MyTrigger` needs a few more fields to keep track of all the different elements it needs to know about. You'll need to add the _timers_ and _handlers_ so that the engine knows which timers exist and which flows to call when a timer runs.

```go
// MyTrigger is a stub for your Trigger implementation
type MyTrigger struct {
	metadata *trigger.Metadata
	config   *trigger.Config
	timers   []*scheduler.Job
	handlers []*trigger.Handler
}
```

In the `Initialize` method you'll need to add one statement to make sure that the trigger can get all the handlers it should know about from the context object.

```go
t.handlers = ctx.GetHandlers()
```

The `Start` method implements the logic required to start the various timers you might create in your app and for each it will schedule a job (using the `scheduleRepeating` method)

```go
// Start implements trigger.Trigger.Start
func (t *MyTrigger) Start() error {
	log.Debug("Start")
	handlers := t.handlers

	log.Debug("Processing handlers")
	for _, handler := range handlers {
		t.scheduleRepeating(handler)
	}

	return nil
}
```

The `scheduleRepeating` method is used to schedule a repeating job with a specified time interval. The variable called `fn2` is executed when a timer fires and calls the flow it should trigger with the data specified in the map `triggerData`. The map contains a field called _output_ which matches the name in the trigger.json file.

```go
func (t *MyTrigger) scheduleRepeating(endpoint *trigger.Handler) {
	log.Info("Scheduling a repeating job")

	fn2 := func() {
		// Create a map to hold the trigger data
		triggerData := map[string]interface{}{
			"output": "Hello World from the new Timer Trigger",
		}

		_, err := endpoint.Handle(context.Background(), triggerData)
		if err != nil {
			log.Error("Error running handler: ", err.Error())
		}
	}

	t.scheduleJobEverySecond(endpoint, fn2)

}
```

Finally, you'll need to add a method called `scheduleJobEverySecond` to make sure the engine checks the timers on a regular basis and executes the function to trigger a flow.

```go
func (t *MyTrigger) scheduleJobEverySecond(tgrHandler *trigger.Handler, fn func()) {

	var interval int
	seconds, _ := strconv.Atoi(tgrHandler.GetStringSetting("seconds"))
	interval = interval + seconds

	log.Debug("Repeating seconds: ", interval)
	// schedule repeating
	timerJob, err := scheduler.Every(interval).Seconds().Run(fn)
	if err != nil {
		log.Error("Error scheduleRepeating (repeat seconds) flo err: ", err.Error())
	}
	if timerJob == nil {
		log.Error("timerJob is nil")
	}

	t.timers = append(t.timers, timerJob)
}
```

The completed file will look something like:

```go
package MyTimerTrigger

import (
	"context"
	"strconv"

	"github.com/TIBCOSoftware/flogo-lib/core/trigger"
	"github.com/TIBCOSoftware/flogo-lib/logger"
	"github.com/carlescere/scheduler"
)

// Create a new logger
var log = logger.GetLogger("trigger-mytrigger")

// MyTriggerFactory My Trigger factory
type MyTriggerFactory struct {
	metadata *trigger.Metadata
}

// NewFactory create a new Trigger factory
func NewFactory(md *trigger.Metadata) trigger.Factory {
	return &MyTriggerFactory{metadata: md}
}

// New Creates a new trigger instance for a given id
func (t *MyTriggerFactory) New(config *trigger.Config) trigger.Trigger {
	return &MyTrigger{metadata: t.metadata, config: config}
}

// MyTrigger is a stub for your Trigger implementation
type MyTrigger struct {
	metadata *trigger.Metadata
	config   *trigger.Config
	timers   []*scheduler.Job
	handlers []*trigger.Handler
}

// Initialize implements trigger.Init.Initialize
func (t *MyTrigger) Initialize(ctx trigger.InitContext) error {
	t.handlers = ctx.GetHandlers()
	return nil
}

// Metadata implements trigger.Trigger.Metadata
func (t *MyTrigger) Metadata() *trigger.Metadata {
	return t.metadata
}

// Start implements trigger.Trigger.Start
func (t *MyTrigger) Start() error {
	log.Debug("Start")
	handlers := t.handlers

	log.Debug("Processing handlers")
	for _, handler := range handlers {
		t.scheduleRepeating(handler)
	}

	return nil
}

// Stop implements trigger.Trigger.Start
func (t *MyTrigger) Stop() error {
	// stop the trigger
	return nil
}

func (t *MyTrigger) scheduleRepeating(endpoint *trigger.Handler) {
	log.Info("Scheduling a repeating job")

	fn2 := func() {
		// Create a map to hold the trigger data
		triggerData := map[string]interface{}{
			"output": "Hello World from the new Timer Trigger",
		}

		_, err := endpoint.Handle(context.Background(), triggerData)
		if err != nil {
			log.Error("Error running handler: ", err.Error())
		}
	}

	t.scheduleJobEverySecond(endpoint, fn2)

}

func (t *MyTrigger) scheduleJobEverySecond(tgrHandler *trigger.Handler, fn func()) {

	var interval int
	seconds, _ := strconv.Atoi(tgrHandler.GetStringSetting("seconds"))
	interval = interval + seconds

	log.Debug("Repeating seconds: ", interval)
	// schedule repeating
	timerJob, err := scheduler.Every(interval).Seconds().Run(fn)
	if err != nil {
		log.Error("Error scheduleRepeating (repeat seconds) flo err: ", err.Error())
	}
	if timerJob == nil {
		log.Error("timerJob is nil")
	}

	t.timers = append(t.timers, timerJob)
}
```

To make sure that you can test and build the new trigger, you'll need to go get (_pun intended_) a few packages

```bash
go get github.com/TIBCOSoftware/flogo-lib/core/trigger
go get github.com/TIBCOSoftware/flogo-lib/logger
go get github.com/carlescere/scheduler
```

## Use your new trigger in a flow

Now the only thing left to do is use the trigger inside a Flogo app! You have two options, install the new trigger using the Flogo CLI or via the Web UI. In any case you'll first want to publish your trigger to a Git repo (the same one you've used in the `ref` field in the `trigger.json`). To add the new trigger to a Flogo engine and use it in a flow you can import it using the following flogo CLI command, from your flow app directory):

```bash
flogo install github.com/yourusername/yourrepository
```

or import it using the "Install new trigger" option in the Flogo Web UI, where you'll need to provide the URL `https://github.com/yourusername/yourrepository`.