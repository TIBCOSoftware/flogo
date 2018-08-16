//go:generate go run $GOPATH/src/github.com/TIBCOSoftware/flogo-lib/flogo/gen/gen.go $GOPATH
// Package main implements the main logic of the function
package main

// The ever important imports
import (
	"context"

	"github.com/TIBCOSoftware/flogo-contrib/activity/log"
	"github.com/TIBCOSoftware/flogo-contrib/trigger/lambda"
	"github.com/TIBCOSoftware/flogo-lib/config"
	"github.com/TIBCOSoftware/flogo-lib/core/data"
	"github.com/TIBCOSoftware/flogo-lib/flogo"
	"github.com/TIBCOSoftware/flogo-lib/logger"
)

// Init makes sure that everything is ready to go!
func init() {
	config.SetDefaultLogLevel("INFO")
	logger.SetLogLevel(logger.InfoLevel)

	app := shimApp()

	e, err := flogo.NewEngine(app)

	if err != nil {
		logger.Error(err)
		return
	}

	e.Init(true)
}

// shimApp is used to build a new Flogo app and register the Lambda trigger with the engine.
// The shimapp is used by the shim, which triggers the engine every time an event comes into Lambda.
func shimApp() *flogo.App {
	// Create a new Flogo app
	app := flogo.NewApp()

	// Register the Lambda trigger with the Flogo app
	trg := app.NewTrigger(&lambda.LambdaTrigger{}, nil)
	trg.NewFuncHandler(nil, RunActivities)

	// Return a pointer to the app
	return app
}

// RunActivities is where the magic happens. This is where you get the input from any event that might trigger
// your Lambda function in a map called evt (which is part of the inputs). The below sample,
// will simply log "Go Serverless v1.x! Your function executed successfully!" and return the same as a response.
// The trigger, in main.go, will take care of marshalling it into a proper response for the API Gateway
func RunActivities(ctx context.Context, inputs map[string]*data.Attribute) (map[string]*data.Attribute, error) {
	// The message you want to log
	message := "Go Serverless v1.x! Your function executed successfully!"

	// Using a Flogo activity to log the message
	in := map[string]interface{}{"message": message}
	_, err := flogo.EvalActivity(&log.LogActivity{}, in)
	if err != nil {
		return nil, err
	}

	// The response from the Lambda function is always in the form of a JSON message.
	// In this case we're creating a structure with a single element called
	// message
	responseData := make(map[string]interface{})
	responseData["message"] = message

	// Because we're sending the result back to the API Gateway, it will expect to have
	// both an HTTP result code (called code) and some response data. In this case we're
	// sending back the data object we created earlier
	response := make(map[string]*data.Attribute)
	response["code"], _ = data.NewAttribute("code", data.TypeInteger, 200)
	response["data"], _ = data.NewAttribute("data", data.TypeAny, responseData)

	return response, nil
}
