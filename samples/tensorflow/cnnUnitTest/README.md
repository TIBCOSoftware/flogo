# CNN model for unit test for Flogo inference activity

This directory contains what is needed to construct a CNN model for a unit test for the Flogo Inference Activity.  Specifically, the goal of this sample is to create a model to be used as:
1. A unit test for the Flogo Inference Activity
2. Sample of building and exporting a model into a format that can be used in Flogo's inference activity
3. An example for incorporating a model into a flogo app.
4. Solution to the toy problem: Given an array of size "size" containing a gaussian determine whether the maximum value is in the lower half of the array (value=0) or the upper half (value=1).

## Creating the model
### A) Creating Model with Jupyter notebook

The [making_basic_cnn_model.ipynb](making_basic_cnn_model.ipynb) Jupyter notebook works through python and TensorFlow to build the model.  For more detail please see the notebook.

### B) Zipping model
Once a model has been produced by the jupyter notebook we need to convert it into a portable form.  The Flogo Inference Activity does take directories of models as input, but it is much more convienent (especially for size concerns like storing a unit test on github) to zip the model.  To do that from a terminal located in this directory you do the following:
```
$ pwd  
  TIBCOSoftware/flogo/samples/tensorflow/cnnUnitTest
$ cd SimpleCNNModel/154031266409/
$ zip -r Archive_simpleCNN.zip saved_model.pb variables/
  adding: saved_model.pb (deflated 85%)
  adding: variables/ (stored 0%)
  adding: variables/variables.data-00000-of-00001 (deflated 5%)
  adding: variables/variables.index (deflated 38%)
$ mv Archive_simpleCNN.zip ../../.
$ cd ../..
$ ls
  Archive_simpleCNN.zip		SimpleCNNModel			making_basic_cnn_model.ipynb
  README.md			SimpleCNNTextModel
```

### C) Using Model
This model can be used in two ways.

##### C1) Including in unit test

The first way to use this model is to use it as a unit test in the flogo-contrib repo [inference activity](https://github.com/TIBCOSoftware/flogo-contrib/blob/master/activity/inference/).  The [Archive_simpleCNN.zip](https://github.com/TIBCOSoftware/flogo-contrib/blob/master/activity/inference/Archive_simpleCNN.zip) file in that directory was generated using this example.  The inputs for the CNN model are included in the [activity_test.go](https://github.com/TIBCOSoftware/flogo-contrib/blob/master/activity/inference/activity_test.go) file starting on line 171.

##### C2) Building app

To build a Flogo app including the inference activity you can either use the CLI tool (as done [here](https://github.com/TIBCOSoftware/flogo/tree/master/samples/tensorflow/helloworld)) or you can use the Flogo library in your own go code.  Since there is already an example using the CLI trigger, here we will build an app leveraging the Flogo Go API in our own Go package.  The file [main.go](main.go) is generously commented to aid in understanding.  The one thing the go code does that might be confusing is that it converts an array of size 10 of `float64`s into a `[][][][]float32`, which is the tensor structure read in by the CNN model.

To run this program to create a REST portal on your machine after making sure your GOPATH is defined.

```
$ export HTTPPORT=8080
$ go generate
$ go run main.go
```

Using your favorite method (I used Postman) to send the following data to localhost:8080/gaussian as the body of a POST request:

```
{
	"Input":[[0.0000000856947568, 0.00000331318370, 0.0000858655563, 0.00149167657, 0.0173705094, 0.135591557, 0.709471493, 2.48839579, 5.85040827, 9.22008867],[0.0000000856947568, 0.00000331318370, 0.0000858655563, 0.00149167657, 0.0173705094, 0.135591557, 0.709471493, 2.48839579, 5.85040827, 9.22008867]]
	
}
```

the resulting response should be:

 ```
 {
    "output": [
        1,
        1
    ]
}
 ```
 since both gaussians sent had a maximum in the top half of the array.
