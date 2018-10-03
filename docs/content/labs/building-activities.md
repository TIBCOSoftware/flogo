---
title: Building your first activity
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

The easiest way to start creating activities is to have the **flogogen** CLI create the basic framework for you. The flogogen CLI takes two important parameters to create the framework for activities. In this tutorial you'll build an activity that takes 2 input parameters (name and salutation) and logs that to the console. It will also return the concatenation of the two fields to you. To start you need to use flogogen to create the scaffolding:

```bash
flogogen activity < name >
```

The parameters are:

* **activity**: because you want to create an activity
* **< name >**: the name for your new activity (in this example you'll use `HelloWorld` as the name for the activity)

So to generate our scaffolding, you need to execute the command:

```bash
flogogen activity HelloWorld
```

The flogogen command will create a folder called `HelloWorld` and generate the files you need to implement your logic:

```bash
HelloWorld
├── activity.go       <-- The implementation of your activity
├── activity.json     <-- The metadata of your activity
└── activity_test.go  <-- A file used to test your activity
```

## The metadata

The first step is to update the file `activity.json`, which has the metadata for your new Flogo activity, with proper information. The metadata describes to the Flogo engine what the activity is called, what the version of the activity is and a few other things. The elements in the file are:

* **name**: The name of the activity (this should match the name of the folder the activity is in, like `HelloWorld`)
* **version**: The version of the activity (it is recommended to use [semantic versioning](https://semver.org/) for your activities) 
* **type**: This describes to the Flogo engine what kind of contribution this is (this should be `activity` in this case)
* **ref**: The Flogo engine is based on Go and this field is the "import" path for Go apps (generally speaking this should match your repository)
* **description**: A brief description of your activity (this is displayed in the Flogo Web UI)
* **author**: This is you!
* **inputs**: An array of name/type pairs that describe the input to the activity
* **outputs**: An array of name/type pairs that describe the output to the activity

Since you'll want to provide some inputs, you'll need to update the inputs and outputs section

* The **inputs** section needs a **salutation** and **name** (both should be of type `string`)
* The **outputs** section needs a parameter called **result** (should be of type `string`)

{{% notice tip %}}
Don't forget to update the **author**, **ref**, and **description** fields, as well!
{{% /notice %}}

The updated activity.json will look quite similar to the below one.

```json
{
  "name": "HelloWorld",
  "version": "0.0.1",
  "type": "flogo:activity",
  "ref": "github.com/yourusername/yourrepository",
  "description": "Say Hello World!",
  "author": "Flogo Developer",
  "inputs":[
    {
      "name": "salutation",
      "type": "string"
    },
    {
      "name": "name",
      "type": "string"
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

## The logic

For the Flogo engine to actually do something we need to update the `*.go` files. There are two files in your current directory:

* **activity.go**: which contains the actual activity implementation in go
* **activity_test.go**: which contains unit tests for the activity

The first step is to look at the business logic, in the **activity.go** file.

As you want to log the output to the console you'll need to import a new Go package `github.com/TIBCOSoftware/flogo-lib/logger` and add a new variable called `log` to the main part of the file

```go
var log = logger.GetLogger("activity-helloworld")
```

For the activity itself the only mandatory function that needs to be implemented is the `Eval()` method. In that method you'll need to add two lines of code to get the name and salutation from the process context.

```go
name := context.GetInput("name").(string)
salutation := context.GetInput("salutation").(string)
```

The next step is to log it to the console

```go
log.Infof("The Flogo engine says [%s] to [%s]", salutation, name)
```

And finally set the output

```go
context.SetOutput("result", "The Flogo engine says "+salutation+" to "+name)
```

All together your `activity.go` file should look something like the one below:

```go
package HelloWorld

import (
    "github.com/TIBCOSoftware/flogo-lib/core/activity"
    "github.com/TIBCOSoftware/flogo-lib/logger"
)

// THIS IS ADDED
// log is the default package logger which we'll use to log
var log = logger.GetLogger("activity-helloworld")

// MyActivity is a stub for your Activity implementation
type MyActivity struct {
    metadata *activity.Metadata
}

// NewActivity creates a new activity
func NewActivity(metadata *activity.Metadata) activity.Activity {
    return &MyActivity{metadata: metadata}
}

// Metadata implements activity.Activity.Metadata
func (a *MyActivity) Metadata() *activity.Metadata {
    return a.metadata
}

// THIS HAS CHANGED
// Eval implements activity.Activity.Eval
func (a *MyActivity) Eval(context activity.Context) (done bool, err error)  {
    // Get the activity data from the context
    name := context.GetInput("name").(string)
    salutation := context.GetInput("salutation").(string)

    // Use the log object to log the greeting
    log.Infof("The Flogo engine says [%s] to [%s]", salutation, name)

    // Set the result as part of the context
    context.SetOutput("result", "The Flogo engine says "+salutation+" to "+name)

    // Signal to the Flogo engine that the activity is completed
    return true, nil
}
```

To make sure that you can test and build the new activity, you'll need to go get (_pun intended_) a few packages

```bash
go get github.com/TIBCOSoftware/flogo-lib/core/activity
go get github.com/TIBCOSoftware/flogo-lib/logger
```

## Unit testing

You've just completed the logic of the activity and, following best practice, you should have an automated way to test the activity to make sure that the it works and so that other developers can run the same tests to validate the output as well. The functions `getActivityMetadata` and `TestCreate` are default methods and the `TestEval` is the one you'll need to update. You'll want to compare the output with the expected output so you'll need to add a new import

```go
"github.com/stretchr/testify/assert"
```

Since the engine will still expect inputs, you'll need to hard code them into the method and execute the eval method of the activity

```go
//setup attrs
tc.SetInput("name", "Flogo Dev")
tc.SetInput("salutation", "Hello")
act.Eval(tc)
```

To make sure that the fields are properly concatenated, you need to validate the output too:

```go
//check result attr
result := tc.GetOutput("result")
assert.Equal(t, result, "The Flogo engine says Hello to Flogo Dev")
```

The updated file will look something like the one below:

```go
package HelloWorld

import (
	"io/ioutil"
	"testing"

	"github.com/TIBCOSoftware/flogo-contrib/action/flow/test"
	"github.com/TIBCOSoftware/flogo-lib/core/activity"
	"github.com/stretchr/testify/assert"
)

var activityMetadata *activity.Metadata

func getActivityMetadata() *activity.Metadata {

	if activityMetadata == nil {
		jsonMetadataBytes, err := ioutil.ReadFile("activity.json")
		if err != nil {
			panic("No Json Metadata found for activity.json path")
		}

		activityMetadata = activity.NewMetadata(string(jsonMetadataBytes))
	}

	return activityMetadata
}

func TestCreate(t *testing.T) {

	act := NewActivity(getActivityMetadata())

	if act == nil {
		t.Error("Activity Not Created")
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

	act := NewActivity(getActivityMetadata())
	tc := test.NewTestActivityContext(getActivityMetadata())

	//setup attrs
	tc.SetInput("name", "Leon")
	tc.SetInput("salutation", "Hello")
	act.Eval(tc)

	//check result attr
	result := tc.GetOutput("result")
	assert.Equal(t, result, "The Flogo engine says Hello to Flogo Dev")
}
```

In order to run the test cases you'll need to intall two more packages. One to be able to tun the tests and one to be able to create assertions.

```bash
go get github.com/TIBCOSoftware/flogo-contrib/action/flow/test
go get github.com/stretchr/testify/assert
```

To run all the test cases for your activity, in this case just one, simply enter

```bash
go test
```

and if all goes well the result should look like

```bash
PASS
ok      _/C_/tools/gosrc/HelloWorld     0.051s
```

## Use your new activity in a flow

Now the only thing left to do is use the activity inside a Flogo app! You have two options, install the new activity using the Flogo CLI or via the Web UI. In any case you'll first want to publish your activity to a Git repo (the same one you've used in the `ref` field in the `activity.json`). To add the new activity to a Flogo engine and use it in a flow you can import it using the following flogo CLI command, from your flow app directory):

```bash
flogo install github.com/yourusername/yourrepository
```

or import it using the "Install new activity" option in the Flogo Web UI, where you'll need to provide the URL `https://github.com/yourusername/yourrepository`.