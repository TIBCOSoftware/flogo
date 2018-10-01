---
title: Application Configuration Provider
weight: 4230
---

Unless you want to provide the application configuration (for example: flogo.json) in a different way or format you should not worry about this feature.

We have provided an extension mechanism for you to override the default way of providing the application configuration if needed.

## Topics
* [Default behavior](#default-behavior)
* [Embedded configuration](#embedded-configuration)
* [Custom configuration](#custom-configuration)

## Default behavior

Out of the box, the default behavior will be as follows:

* Configuration will be passed to the engine in the JSON format
* Default path for the JSON file will be in the same directory as the application's binary
* Default name for the JSON file will be "flogo.json"
* Default path and name can be changed by setting an environment variable "flogo.config.path" (for example:)

```bash
# Example changing default configuration path and name
$ export flogo.config.path=/path/to/config/myconfig.json
```

## Embedded configuration

There is an option when building the application to compile the flogo.json and embed it into the code instead of loading it from a file.
```bash
 # Example building the application in embedded mode
 $ flogo build -e
```

## Custom configuration

If you need to customize the way the configuration is provided to the engine (for example: "change the format of the configuration"), you just need to do the following:
* Place a file in the "main" package of your application that looks like this:
```
package main

import (
	"github.com/TIBCOSoftware/flogo-lib/app"
)

func init () {
    // The name of this variable is IMPORTANT as it is initializing an existing 
    // variable in the main.go
	cp = MyProvider()
}

// myProvider implementation of ConfigProvider
type myProvider struct {
}

//OptimizedProvider returns an app config from a compiled json file
func MyProvider() (app.ConfigProvider){
	return &myProvider{}
}

// GetApp returns the app configuration
func (d *myProvider) GetApp() (*app.Config, error){

	app := &app.Config{}
	
	// Add your own code here
	...
	
	
	return app, nil
}
```