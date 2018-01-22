---
title: Building your first activity
weight: 4410
---

Creating a new activity for Project Flogo is not that hard! Let's walk through the steps required to create a simple activity.

{{% notice info %}}
Please make sure that you have installed the **flogo** tools as described in [Getting Started > Flogo CLI](../../../getting-started/getting-started-cli/).
{{% /notice %}}

## The basic framework
The easiest way to start creating activities is to have the **flogogen** CLI create the basic framework for you. The flogogen CLI takes two important parameters to create the framework for activities:

```
flogogen activity activityName
```

The parameters are:

* **activity**: becaue you want to create an activity
* **activityName**: the name for your new activity (for now we'll use `HelloWorld` as the name for our activity)

So to generate our scaffolding, we need to execute the command:

```
flogogen activity HelloWorld
```

The flogogen CLI will create the required folders and download the needed dependencies for you and you now have a new folder called `HelloWorld` which has the structure of the Flogo activity
```
HelloWorld\
		activity.json
		activity.go
		activity_test.go
```

## The metadata
The file `activity.json` has the metadata of the Flogo activity describing to the Flogo engine what the activity is called, what the version of the activity is and a few other things. For the **HelloWorld** activity we'll add a few more things and update the input and the output section. The latter two describe to the Flogo engine what the engine should expect to create in terms of in- and output

```json
{
  "name": "HelloWorld",
  "version": "0.0.1",
  "type": "flogo:activity",
  "description": "activity description",
  "author": "Your Name <you.name@example.org>",
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

In the file we've updated:

* Updated the **inputs** section and added a **salutation** and **name**
* Updated the **outputs** section and changed the name parameter to **result**

{{% notice tip %}}
Don't forget to update the **author** and **description** fields, as well! This will manifest in the Web UI.
{{% /notice %}}


## Writing Go
For the Flogo engine to actually do something we need to update the *.go files

* **activity.go**: this file contains the actual activity implementation in go
* **activity_test.go**: this file contains unit tests for the activity

For the activity itself the only mandatory function that needs to be implemented is the `Eval()` method. We'll add some logic to retrieve the name and salutation from the process context, log it to the console and return the concatenation of the two as the response of the activity. In the code below we've added a new import for the core logger.

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
	log.Debugf("The Flogo engine says [%s] to [%s]", salutation, name)

	// Set the result as part of the context
	context.SetOutput("result", "The Flogo engine says "+salutation+" to "+name)

	// Signal to the Flogo engine that the activity is completed
	return true, nil
}
```

So we've made a few changes, and we need to make sure that the packages we're using are available to Go when we want to run unit tests. To get the packages execute

```
go get github.com/TIBCOSoftware/flogo-lib/core/activity
go get github.com/TIBCOSoftware/flogo-lib/logger
```

Following best practice, we should write some test cases to make sure that the activity works and that other developers can run the same tests to validate the output as well. In order to run the test cases we need to intall two more package. One to be able to tun the tests and one to be able to create assertions.

```
go get github.com/TIBCOSoftware/flogo-contrib/action/flow/test
go get github.com/stretchr/testify/assert
```

For this case we've updated the TestEval function to make check whether the output is indeed the output we expect based on the two parameters we're giving it.

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
	assert.Equal(t, result, "The Flogo engine says Hello to Leon")
}
```

To run all the test cases simply enter

```
go test
```

and if all goes well the result should look like

```
PASS
ok      _/C_/tools/gosrc/HelloWorld     0.051s
```

## Development best practices
To follow the best practices for Go development and to make sure that everyone follows the same rules when creating activities for the Flogo engine we need to run a few commands to make sure the code we created is correct and formatted correctly. To do that, we'll use the `gofmt` and `golint` tools :
```bash
# Validate the three go source code files are formatted correctly, automatically update any inconsistencies (-w) and show the diff on the commandline (-d)
$ cd HelloWorld
$ gofmt -d -w activity.go
$ gofmt -d -w activity_test.go

# golint is a strict formatter which checks even more guidelines than gofmt
$ golint activity.go
```

If you've copied the exact code from above for the `activity.go` you'll see a warning that one comment isn't the way it should be `activity.go:27:1: comment on exported method MyActivity.Eval should be of the form "Eval ..."` which for now you can safely ignore.

## Using your new activity in a flow
Now the only thing left to do is use the activity inside a Flogo app! You have two options, install the new activity using the Flogo CLI or via the Web UI. You'll first want to publish your activity to a Git repo. 

To add the new activity to a Flogo engine and use it in a flow you can import it using the following flogo CLI command (tip, do this from your flow app directory):

```bash
flogo install https://github.com/user/activity
```