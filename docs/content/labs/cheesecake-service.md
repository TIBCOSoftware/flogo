---
title: Cheesecake Service
hidden: true
---

Project Flogo offers multiple ways to build apps:

* **Web UI**: You can develop flows using a zero code Web UI, which allows you to graphically build your microservices;
* **JSON DSL**: You can also build an app using a sophisticated, but elegant, JSON DSL (the Web UI uses this internally as well!);
* **Go API**: You can use the Go API to use Flogo as a Librry in your Go app!

In this tutorial you will learn how to use Flogo as a Library and to build a Go app while leveraging the Flogo engine. The tutorial makes use of the REST trigger as well as the Log activity.

## What you'll need

### Go

This demo makes use of Go. If you haven't installed Go yet, check out how to install it [here](https://golang.org/doc/install). You'll need Go 1.9.x or higher for this tutorial.

### Need help

If you have any questions, feel free to post an [issue on GitHub](https://github.com/TIBCOSoftware/flogo/issues) and tag it as a question or chat with the team and community:

* The [project-flogo/Lobby](https://gitter.im/project-flogo/Lobby) Start here for all things Flogo!
* The [project-flogo/developers](https://gitter.im/project-flogo/developers) Developer/contributor focused conversations.

## Step 1: Outline

The service you'll build needs a file in which to code. The steps will walk you through the creation of the file and walk through the entire source code, to make sure you add all the right things you need for the cheesecake servuce. To get started, create a file called `main.go`, which will be the main file of the cheesecake service.

```bash
touch main.go
```

A Go app that uses Flogo as a Library isn't any different from a regular Go app, with one subtle addition right at the beginning of the file. Since the Flogo engine requires metadata of each activity you'll need to make sure that the Go compiler creates, and packages, that metadata as well. To do so, add the below line as the first line in your file

```go
//go:generate go run $GOPATH/src/github.com/TIBCOSoftware/flogo-lib/flogo/gen/gen.go $GOPATH
```

This line will tell `go` what to do when running the `generate` command. The generate command runs commands described by directives within existing files. Those commands can run any process but the intent is to create or update Go source files and in this case it generates the metadata files for your service.

## Step 2: Imports

To make the app work, you'll need a few imports

```go
package main

import (
    // Default Go packages
	"context"
	"os"
	"strconv"

    // The Flogo Log activity
    "github.com/TIBCOSoftware/flogo-contrib/activity/log"
    // The Flogo REST trigger
    "github.com/TIBCOSoftware/flogo-contrib/trigger/rest"
    // Core packages for the Flogo engine
	"github.com/TIBCOSoftware/flogo-lib/core/data"
	"github.com/TIBCOSoftware/flogo-lib/engine"
	"github.com/TIBCOSoftware/flogo-lib/flogo"
    "github.com/TIBCOSoftware/flogo-lib/logger"
)
```

Just like with any Go package, the Go compiler needs to have access to them to be able to compile the program into an executable. To make sure the packages are available, you'll need to run

```bash
go get -u github.com/TIBCOSoftware/flogo-contrib/activity/log
go get -u github.com/TIBCOSoftware/flogo-contrib/trigger/rest
go get -u github.com/TIBCOSoftware/flogo-lib/core/data
go get -u github.com/TIBCOSoftware/flogo-lib/engine
go get -u github.com/TIBCOSoftware/flogo-lib/flogo
go get -u github.com/TIBCOSoftware/flogo-lib/logger
```

## Step 3: Variables

Hard coding variables is never a good idea. As you're building an app that uses the HTTP trigger, you'll want to make sure that the HTTP port is configurable. To do so add the below directive to your `main.go` file

```go
var (
	httpport = os.Getenv("HTTPPORT")
)
```

The app will now be able to use an environment variable called `HTTPPORT` as the port for the HTTP trigger

## Step 4: Main

Every app needs a main function as the entry point into the program, and a Flogo app isn't any different. The main function in the case of a Go app that uses Flogo as a Library, might look a little different:

```go
func main() {
	// Create a new Flogo app
	app := appBuilder()

	e, err := flogo.NewEngine(app)

	if err != nil {
		logger.Error(err)
		return
	}

	engine.RunEngine(e)
}
```

The first line creates the `app` (using a method you'll define in the next step). The lines after that create the Flogo engine and instruct the engine to run the app.

## Step 5: The app

The Flogo engine needs an app to run, and to construct that app you'll need another method

```go
func appBuilder() *flogo.App {
	app := flogo.NewApp()

	// Convert the HTTPPort to an integer
	port, err := strconv.Atoi(httpport)
	if err != nil {
		logger.Error(err)
	}

	// Register the HTTP trigger
	trg := app.NewTrigger(&rest.RestTrigger{}, map[string]interface{}{"port": port})
	trg.NewFuncHandler(map[string]interface{}{"method": "GET", "path": "/cheesecake/:name"}, Handler)

	return app
}
```

The first line constructs the app, that will be returned as the result of this method. The next step is to convert the HTTPPORT variable from a string into an integer. The last part, before the return, is creating the HTTP trigger. In this section you create a new trigger using a method call with two parameters:

* The trigger type: `&rest.RestTrigger{}`
* The settings: `map[string]interface{}{"port": port}` (if you check the [trigger.json](https://github.com/TIBCOSoftware/flogo-contrib/blob/master/trigger/rest/trigger.json), you'll see the port field is a global setting)

After that, you'll need to register a _function handler_ for each of the HTTP methods and PATHs you want to handle. In this case the app will handle a `GET` operation for the path `/cheesecake/:name` (where `:name` is a PATH parameter) and as events come in for this path, it will dispatch them to a method called `Handler`.

## Step 6: The Handler

The next step is that your app needs to handle the events and to do so, you'll need to create a method called `Handler`:

```go
// Handler is the function that gets executed when the engine receives a message
func Handler(ctx context.Context, inputs map[string]*data.Attribute) (map[string]*data.Attribute, error) {
	// Get the name from the path
	name := inputs["pathParams"].Value().(map[string]string)["name"]

	// Log, using the Flogo log activity
	// There are definitely better ways to do this with Go, but we want to show how to use activities
	in := map[string]interface{}{"message": name, "flowInfo": "true", "addToFlow": "true"}
	_, err := flogo.EvalActivity(&log.LogActivity{}, in)
	if err != nil {
		return nil, err
	}

    // Set the result message
    var cheesecake string
    switch name {
    case "retgits":
        cheesecake = "Likes all cheesecakes"
    case "flynn":
        cheesecake = "Prefers some nectar!"
    default:
        cheesecake = "Plain cheesecake is the best"
    }

	// The return message is a map[string]*data.Attribute which we'll have to construct
	response := make(map[string]interface{})
	response["name"] = name
	response["cheesecake"] = cheesecake

	ret := make(map[string]*data.Attribute)
	ret["code"], _ = data.NewAttribute("code", data.TypeInteger, 200)
	ret["data"], _ = data.NewAttribute("data", data.TypeAny, response)

	return ret, nil
}
```

From top to bottom the code does the following:

1) Get the name from the PATH parameter;
2) Execute the log activity (the inputs passed in as a `map[string]interface{}` are the same fields as in the [activity.json](https://github.com/TIBCOSoftware/flogo-contrib/blob/master/activity/log/activity.json));
3) Use a regular Go switch statement to determine the favorite cheesecake based on the name;
4) Create a `map[string]interface{}` with the return values of the app;
5) Return an HTTP statuscode and the message.

## Step 7: Complete app

Right now, your complete app should look like

```go
//go:generate go run $GOPATH/src/github.com/TIBCOSoftware/flogo-lib/flogo/gen/gen.go $GOPATH
package main

import (
    // Default Go packages
	"context"
	"os"
	"strconv"

    // The Flogo Log activity
    "github.com/TIBCOSoftware/flogo-contrib/activity/log"
    // The Flogo REST trigger
    "github.com/TIBCOSoftware/flogo-contrib/trigger/rest"
    // Core packages for the Flogo engine
	"github.com/TIBCOSoftware/flogo-lib/core/data"
	"github.com/TIBCOSoftware/flogo-lib/engine"
	"github.com/TIBCOSoftware/flogo-lib/flogo"
    "github.com/TIBCOSoftware/flogo-lib/logger"
)

var (
	httpport = os.Getenv("HTTPPORT")
)

func main() {
	// Create a new Flogo app
	app := appBuilder()

	e, err := flogo.NewEngine(app)

	if err != nil {
		logger.Error(err)
		return
	}

	engine.RunEngine(e)
}

func appBuilder() *flogo.App {
	app := flogo.NewApp()

	// Convert the HTTPPort to an integer
	port, err := strconv.Atoi(httpport)
	if err != nil {
		logger.Error(err)
	}

	// Register the HTTP trigger
	trg := app.NewTrigger(&rest.RestTrigger{}, map[string]interface{}{"port": port})
	trg.NewFuncHandler(map[string]interface{}{"method": "GET", "path": "/cheesecake/:name"}, Handler)

	return app
}

// Handler is the function that gets executed when the engine receives a message
func Handler(ctx context.Context, inputs map[string]*data.Attribute) (map[string]*data.Attribute, error) {
	// Get the name from the path
	name := inputs["pathParams"].Value().(map[string]string)["name"]

	// Log, using the Flogo log activity
	// There are definitely better ways to do this with Go, but we want to show how to use activities
	in := map[string]interface{}{"message": name, "flowInfo": "true", "addToFlow": "true"}
	_, err := flogo.EvalActivity(&log.LogActivity{}, in)
	if err != nil {
		return nil, err
	}

    // Set the result message
    var cheesecake string
    switch name {
    case "retgits":
        cheesecake = "Likes all cheesecakes"
    case "flynn":
        cheesecake = "Prefers some nectar!"
    default:
        cheesecake = "Plain cheesecake is the best"
    }

	// The return message is a map[string]*data.Attribute which we'll have to construct
	response := make(map[string]interface{})
	response["name"] = name
	response["cheesecake"] = cheesecake

	ret := make(map[string]*data.Attribute)
	ret["code"], _ = data.NewAttribute("code", data.TypeInteger, 200)
	ret["data"], _ = data.NewAttribute("data", data.TypeAny, response)

	return ret, nil
}
```

## Step 7: Build

To build the app, you'll need to run two commands:

```go
// Make sure that the metadata is generated
go generate
// Build the app
go build -o cheesecakesvc
```

Because you're using Flogo as a Library in your app, you don't need to use the `flogo build` command but instead use the regular `go build` with any parameters you might want to pass in (`-o cheesecakesvc` means the output will be an executable called `cheesecakesvc`).

## Step 8: Run

To run the app simply run

```bash
HTTPPORT=8888 ./cheesecakesvc
```

And in a separate terminal run to see the result of your app

```go
$ curl --request GET --url http://localhost:8888/cheesecake/retgits
{"cheesecake":"Likes all cheesecakes","name":"retgits"}
```