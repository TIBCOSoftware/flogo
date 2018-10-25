//go:generate go run $GOPATH/src/github.com/TIBCOSoftware/flogo-lib/flogo/gen/gen.go $GOPATH
package main

import (
	"context"
	"os"
	"strconv"

	"github.com/TIBCOSoftware/flogo-contrib/activity/inference"
	rt "github.com/TIBCOSoftware/flogo-contrib/trigger/rest"
	"github.com/TIBCOSoftware/flogo-lib/core/data"
	"github.com/TIBCOSoftware/flogo-lib/engine"
	"github.com/TIBCOSoftware/flogo-lib/flogo"
	"github.com/TIBCOSoftware/flogo-lib/logger"
)

var (
	httpport = os.Getenv("HTTPPORT")
)

func main() {
	// Create a new Flogo app and uses it to listen for a triggering event
	app := appBuilder()

	e, err := flogo.NewEngine(app)
	if err != nil {
		logger.Error(err)
		return
	}

	engine.RunEngine(e)
}

//  Defines the flogo app and the events for which it listens
func appBuilder() *flogo.App {
	app := flogo.NewApp()

	// Convert the HTTPPort to an integer
	port, err := strconv.Atoi(httpport)
	if err != nil {
		logger.Error(err)
	}

	// Register the HTTP trigger - Specificically a POST  (handler points to the handler function below)
	trg := app.NewTrigger(&rt.RestTrigger{}, map[string]interface{}{"port": port})
	trg.NewFuncHandler(map[string]interface{}{"method": "POST", "path": "/gaussian"}, handler)

	return app
}

// Where We handle the results of the REST request
func handler(ctx context.Context, inputs map[string]*data.Attribute) (map[string]*data.Attribute, error) {

	modelPath := "Archive_simpleCNN.zip"
	framework := "Tensorflow"

	// features is the array that will be used to hold the input feature set that we pass into the inference activity
	var features []interface{}

	// So I read in the list of gaussin arrays from the POST request, but I need to convert them to the form the CNN model expects
	//    (for an array of shape [x,10] to a tensor of shape [x,10,1,1] where x is the number of gaussians sent)
	d := inputs["content"].Value().(map[string]interface{})["Input"].([]interface{})
	var datafeat [][][][]float32 // the data features that will be sent to the TF model
	for _, row := range d {      // looping over each gaussian sent
		row2 := row.([]interface{})
		var gaus [][][]float32
		for _, item := range row2 { // looping over each item in the gaussian
			gaus = append(gaus, [][]float32{{float32(item.(float64))}})
		}
		datafeat = append(datafeat, gaus)
	}

	// Now append the input feature with the name X to the features array. This will be passed into
	// the inference activity.
	features = append(features, map[string]interface{}{
		"name": "X",
		"data": datafeat,
	})

	// defining a map containing all the inputs to send to inference activity.
	//    The keys correspond to inputs defined in the activity.json file for the inference activity
	in := map[string]interface{}{"model": modelPath, "framework": framework, "features": features}

	// Calling the Inference Activity
	out, err := flogo.EvalActivity(&inference.InferenceActivity{}, in)
	if err != nil {
		return nil, err
	}

	// Extracting the predictions from the inference activity output
	mapPred := out["result"].Value().(map[string]interface{})["pred"].([]int64)

	// The return message is a map[string]*data.Attribute which we'll have to construct
	response := make(map[string]interface{})
	response["output"] = mapPred

	ret := make(map[string]*data.Attribute)
	ret["code"], _ = data.NewAttribute("code", data.TypeInteger, 200)
	ret["data"], _ = data.NewAttribute("data", data.TypeAny, response)

	return ret, nil
}
