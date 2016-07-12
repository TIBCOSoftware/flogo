# Building your first activity for Flogo
Adding a new activity to Flogo is quite easy and we've outlined the steps for you in this howto guide. This guide will walk you through the steps required to create a simple activity which can also be used in the Flogo web UI.

## Prerequisites
Before you can get started with this guide you need to make sure you have the right prerequisites installed:
* The Go programming language should be [installed](https://golang.org/doc/install).
* In order to simplify development and building in Go, we recommend using the **gb** build tool.  It can be downloaded from [here](https://getgb.io).
* You should have Flogo installed: `go get github.com/TIBCOSoftware/flogo-cli`
* And you should have golint installed: `go get -u github.com/golang/lint/golint`

## Creating the basic framework
The easiest way to start creating activities is to have the Flogo CLI create the basic framework for you. The Flogo CLI takes two important parameters to create the basic framework for activities:
```bash
$ flogo activity create [-with-ui] [-nogb] activityName
```
The parameter `-with-ui` signals the tool to create the design time folder and the `activityName` is obviously the name of the activity. For the guide we'll create a new activity called `HelloWorld` which also has a UI contribution. To do that you need to execute the command:
```bash
$ flogo activity create -with-ui HelloWorld
```
The Flogo CLI will create the required folders and download the needed dependencies for you and you now have a new folder called `HelloWorld` which has the structure of the Flogo activity
```bash
	HelloWorld\
		src\
			activity.json
            ui\
			runtime\
				activity.go
				activity_metadata.go
				activity_test.go
		vendor\
```

## Updating the metadata
The file `activity.json` has the metadata of the Flogo activity describing to the Flogo engine what the activity is called, what the version of the activity is and a few other things. For the HelloWorld activity we'll add a few more things and update the input and the output section. The latter two describe to the Flogo engine what the engine should expect to create in terms of in- and output
```json
{
  "name": "HelloWorld",
  "version": "0.0.1",
  "title": "Hello World Activity",
  "description": "activity description",
  "inputs":[
    {
      "name": "salutation",
      "type": "string",
      "value": ""
    },
    {
      "name": "name",
      "type": "string",
      "value": ""
    }
  ],
  "outputs": [
    {
      "name": "result",
      "type": "string"
    }
  ]
}
``` 
We've updated the following for the JSON file:
* Added a title element which is the title the activity has in the UI
* Updated the `inputs` section with a `saluation` and `name`
* Updated the `outputs` section to `result`

## Creating the UI contributions
Flogo retrieves the UI contributions from the `runtime` folder which only has two files:
* `activity.json` which you can copy over from the from the root folder 
* `package.json` which only has the name, version and description of the activity

```json
{
  "name": "HelloWorld",
  "version": "0.0.1",
  "description": "activity description"
}
```

## Creating the Go logic
For the Flogo engine to actually do something we need to update the files in the `runtime` folder:
* *activity.go*: this file contains the actual activity implementation in go
* *activity_metadata.go*: this file contains the activity metadata as a go file
* *activity_test.go*: this file contains tests for the activity

For the activity itself the only mandatory function that needs to be implemented is the `Eval()` method. We'll add some logic to retrieve the name and salutation from the process context, log it to the console and return the concatenation of the two as the response of the activity. In the code below we've a new import, created a `log` object and implemented the `Eval()` method.

```go
package HelloWorld

// THIS HAS CHANGED
// Added an extra import for the logger to work
import (
	"github.com/TIBCOSoftware/flogo-lib/core/ext/activity"
	"github.com/op/go-logging"
)

// THIS IS ADDED
// log is the default package logger which we'll use to log
var log = logging.MustGetLogger("activity-HelloWorld")

// MyActivity is a stub for your Activity implementation
type MyActivity struct {
	metadata *activity.Metadata
}

// init create & register activity
func init() {
	md := activity.NewMetadata(jsonMetadata)
	activity.Register(&MyActivity{metadata: md})
}

// Metadata implements activity.Activity.Metadata
func (a *MyActivity) Metadata() *activity.Metadata {
	return a.metadata
}

// THIS HAS CHANGED
// Eval implements activity.Activity.Eval
func (a *MyActivity) Eval(context activity.Context) (done bool, evalError *activity.Error)  {
    // Get the activity data from the context
    name := context.GetInput("name").(string)
    salutation := context.GetInput("salutation").(string)

    // Use the log object to log the greeting
    log.Debugf("The Flogo engine says [%s] to [%s]", salutation, name)

    // Set the result as part of the context
    context.SetOutput("result", "The Flogo engine says " + salutation + " to " + name)

    // Signal to the Flogo engine that the activity is completed
	return true, nil
}
```

For the metadata of the activity, or more precisely the metadata the activity could request about itself, we need to update the `activity_metadata.go` file to have the exact same data as the `activity.json` file from the very first step. In this case the end result should look something like

```go
package HelloWorld

var jsonMetadata = `{
  "name": "HelloWorld",
  "version": "0.0.1",
  "title": "Hello World Activity",
  "description": "activity description",
  "inputs":[
    {
      "name": "salutation",
      "type": "string",
      "value": ""
    },
    {
      "name": "name",
      "type": "string",
      "value": ""
    }
  ],
  "outputs": [
    {
      "name": "result",
      "type": "string"
    }
  ]
}`
```

As a good developer you should write some test cases to make sure that the activity works and that other developers can run the same tests to validate the output as well. For this case we'll just use the default tests that are generated by the Flogo CLI

```go
package HelloWorld

import (
	"testing"
	"github.com/TIBCOSoftware/flogo-lib/core/ext/activity"
	"github.com/TIBCOSoftware/flogo-lib/test"
)

func TestRegistered(t *testing.T) {
	act := activity.Get("HelloWorld")

	if act == nil {
		t.Error("Activity Not Registered")
		t.Fail()
		return
	}
}

func TestEval(t *testing.T) {

	defer func() {
		if r := recover(); r != nil {
			t.Failed()
			t.Errorf("panic during execution: %v", r)
		}
	}()

	md := activity.NewMetadata(jsonMetadata)
	act := &MyActivity{metadata: md}

	tc := test.NewTestActivityContext(md)
	//setup attrs

	act.Eval(tc)

	//check result attr
}

```

## Development best practices
To follow the best practices for Go development and to make sure that everyone follows the same rules when creating activities for the Flogo engine we need to run a few commands to make sure the code we created is correct and formatted correctly. To do that, we'll use the `gofmt` and `golint` tools :
```bash
# Validate the three go source code files are formatted correctly, automatically update any inconsistencies (-w) and show the diff on the commandline (-d)
$ cd runtime
$ gofmt -d -w activity.go
$ gofmt -d -w activity_test.go
$ gofmt -d -w activity_metadata.go

# golint is a strict formatter which checks even more guidelines than gofmt
$ golint activity.go
```

If you've copied the exact code from above for the `activity.go` you'll see a warning that one comment isn't the way it should be `activity.go:30:1: comment on exported method MyActivity.Eval should be of the form "Eval ..."` which for now you can safely ignore.

## Using your new activity in  flow
Now the only thing left to do is use the activity inside a Flogo app! To add the new activity to a Flogo engine and use it in a flow you can import it using

```bash
flogo add activity flogo add activity file://LOCATION/TO/YOUR/ACTIVITY/HelloWorld
```