---
title: Building your first activity
hidden: true
---

Project Flogo exposes a number of different extension points, in this tutorial we'll explore the activity contribution point and learn how to build a custom activity in Go.

## What you'll need

### Flogo CLI

This demo makes use of the Flogo CLI. If you don't have that one running yet, please check out [Getting Started with the Flogo CLI](../../getting-started/getting-started-cli/)

### Need help

If you have any questions, feel free to post an [issue on GitHub](https://github.com/TIBCOSoftware/flogo/issues) and tag it as a question or chat with the team and community:

* The [project-flogo/Lobby](https://gitter.im/project-flogo/Lobby) Start here for all things Flogo!
* The [project-flogo/developers](https://gitter.im/project-flogo/developers) Developer/contributor focused conversations.

## Generate the basic framework



The easiest way to start creating activities is to clone the content of the `project-flogo/core/examples/activity`. In this tutorial you'll build an activity that takes 2 input parameters (name and salutation) and logs that to the console. It will also return the concatenation of the two fields to you. To start you should pull the example activity from flogo core:

```bash
git clone https://github.com/project-flogo/core
cp -R core/examples/activity/* /myNewActivity
```

## The metadata

The first step is to update the file `descriptor.json`, which has the metadata for your new Flogo activity, with proper information. The metadata describes to the Flogo Web UI what the activity is called, what the version of the activity is and a few other things, such as the input and output. The elements in the file are:

* **name**: The name of the activity (this should match the name of the folder the activity is in, like `HelloWorld`)
* **version**: The version of the activity (it is recommended to use [semantic versioning](https://semver.org/) for your activities) 
* **type**: This describes the type of contribution this is (this should be `flogo:activity` in this case)
* **title**: The application title to display in the web ui
* **ref**: The Go package reference that will be used by the web ui to fetch the contribution upon installation
* **description**: A brief description of your activity (this is displayed in the Flogo Web UI)
* **author**: This is you!
* **settings**: An array of name/type pairs that describe the activity settings. Note that activity settings are pre-compiled settings and can be used to increased performance. Settings are not fetched for every invocation
* **input**: An array of name/type pairs that describe the input to the activity
* **output**: An array of name/type pairs that describe the output to the activity

Since you'll want to provide some inputs, you'll need to update the inputs and outputs section

* The **input** needs a **anInput** param (should be of type `string`)
* The **output** section needs a parameter called **anOutput** (should be of type `string`)

{{% notice tip %}}
Don't forget to update the **author**, **ref**, and **description** fields, as well!
For Flogo Web UI, add a **title** field to label and help find your activity.
{{% /notice %}}

The updated descriptor.json will look quite similar to the below one.

```json
{
  "name": "sample-activity",
  "type": "flogo:activity",
  "version": "0.0.1",
  "title": "Sample Activity",
  "description": "Sample Activity",
  "homepage": "https://github.com/project-flogo/tree/master/examples/activity",
  "settings": [
    {
      "name": "aSetting",
      "type": "string",
      "required": true
    }
  ],
  "input": [
    {
      "name": "anInput",
      "type": "string",
      "required": true
    }
  ],
  "output": [
    {
      "name": "anOutput",
      "type": "string"
    }
  ]
```

## The logic

For the Flogo engine to actually do something we need to update the `*.go` files. There are two files in your current directory:

* **activity.go**: which contains the actual activity implementation in go
* **activity_test.go**: which contains unit tests for the activity
* **metadata.go**: which contains the basic input/output/settings metadata. This is used by the engine

The first step is to define our input/output/setting `metadata.go`. This is used by the engine and also used when leveraging contributions using the Flogo Go Lib. This enables Go developers to leverage strongly typed objects for IDE autocompletion, etc.

```go
package sample

import "github.com/project-flogo/core/data/coerce"

type Settings struct {
	ASetting string `md:"aSetting,required"`
}

type Input struct {
	AnInput string `md:"anInput,required"`
}

func (r *Input) FromMap(values map[string]interface{}) error {
	strVal, _ := coerce.ToString(values["anInput"])
	r.AnInput = strVal
	return nil
}

func (r *Input) ToMap() map[string]interface{} {
	return map[string]interface{}{
		"anInput": r.AnInput,
	}
}

type Output struct {
	AnOutput string `md:"anOutput"`
}

func (o *Output) FromMap(values map[string]interface{}) error {
	strVal, _ := coerce.ToString(values["anOutput"])
	o.AnOutput = strVal
	return nil
}

func (o *Output) ToMap() map[string]interface{} {
	return map[string]interface{}{
		"anOutput": o.AnOutput,
	}
}
```

The next step is to look at the business logic, in the **activity.go** file.

```go
package sample

import (
	"github.com/project-flogo/core/activity"
	"github.com/project-flogo/core/data/metadata"
)

func init() {
	_ = activity.Register(&Activity{}) //activity.Register(&Activity{}, New) to create instances using factory method 'New'
}

var activityMd = activity.ToMetadata(&Settings{}, &Input{}, &Output{})

//New optional factory method, should be used if one activity instance per configuration is desired
func New(ctx activity.InitContext) (activity.Activity, error) {

	s := &Settings{}
	err := metadata.MapToStruct(ctx.Settings(), s, true)
	if err != nil {
		return nil, err
	}

	ctx.Logger().Debugf("Setting: %s", s.ASetting)

	act := &Activity{} //add aSetting to instance

	return act, nil
}

// Activity is an sample Activity that can be used as a base to create a custom activity
type Activity struct {
}

// Metadata returns the activity's metadata
func (a *Activity) Metadata() *activity.Metadata {
	return activityMd
}

// Eval implements api.Activity.Eval - Logs the Message
func (a *Activity) Eval(ctx activity.Context) (done bool, err error) {

	input := &Input{}
	err = ctx.GetInputObject(input)
	if err != nil {
		return true, err
	}

	ctx.Logger().Debugf("Input: %s", input.AnInput)

	output := &Output{AnOutput: input.AnInput}
	err = ctx.SetOutputObject(output)
	if err != nil {
		return true, err
	}

	return true, nil
}
```

To make sure that you can test and build the new activity, you'll need to go get (_pun intended_) a few packages

```bash
go get github.com/project-flogo/core/activity
go get github.com/project-flogo/core/data/coerce
go get github.com/project-flogo/core/data/metadata
```

## Unit testing

You've just completed the logic of the activity and, following best practice, you should have an automated way to test the activity to make sure that the it works and so that other developers can run the same tests to validate the output as well. The activity_test.go file looks like:

```go
package sample

import (
	"testing"

	"github.com/project-flogo/core/activity"
	"github.com/project-flogo/core/support/test"
	"github.com/stretchr/testify/assert"
)

func TestRegister(t *testing.T) {

	ref := activity.GetRef(&Activity{})
	act := activity.Get(ref)

	assert.NotNil(t, act)
}

func TestEval(t *testing.T) {

	act := &Activity{}
	tc := test.NewActivityContext(act.Metadata())
	input := &Input{AnInput: "test"}
	err := tc.SetInputObject(input)
	assert.Nil(t, err)

	done, err := act.Eval(tc)
	assert.True(t, done)
	assert.Nil(t, err)

	output := &Output{}
	err = tc.GetOutputObject(output)
	assert.Nil(t, err)
	assert.Equal(t, "test", output.AnOutput)
}
```

In order to run the test cases you'll need to intall two more packages. One to be able to run the tests and one to be able to create assertions.

```bash
go get github.com/project-flogo/core/activity
go get github.com/project-flogo/core/support/test
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

Now the only thing left to do is use the activity inside a Flogo app! You have two options, install the new activity using the Flogo CLI or via the Web UI. In any case you'll first want to publish your activity to a Git repo (the same one you've used in the `ref` field in the `descriptor.json`). To add the new activity to a Flogo engine and use it in a flow you can import it using the following flogo CLI command, from your flow app directory):

```bash
flogo install github.com/yourusername/yourrepository
```

or import it using the "Install new activity" option in the Flogo Web UI, where you'll need to provide the URL `https://github.com/yourusername/yourrepository`.