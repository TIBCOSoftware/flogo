---
title: Inferencing
weight: 4220
---

Before you begin with the [ML Inferencing activity](https://github.com/project-flogo/ml/activity/inference), refer to the [Flows > TensorFlow > Getting Started](../../tensorflow/getting-started/) documentation.

## Overview of the Inference Activity

The inference activity was built to support the concept of plugable frameworks, however the only supported framework is currently **TensorFlow**. The activity leverages the Golang API from TensorFlow. You don't need Python or anything other than the TensorFlow dynamic library installed on your dev & target machine.

## Inputs

### model

The “model” input to the activity should be either of the following:

- An archive (zip) of the TensorFlow model
- A directory containing the exported protobuf and check point files

The activity has been tested with the exported model from the [tf.estimator.Exporter.export](https://www.tensorflow.org/api_docs/python/tf/estimator/Exporter) operation as well as manually built models exported with the [tf.saved_model](https://www.tensorflow.org/api_docs/python/tf/saved_model) module. After export, optionally zip the file, where the saved_model.pb file is located at the root of the archive.

The SavedModel format contained in the protobuf includes metadata (interpret this as an instruction manual) on how to use the model.  The below inputs and outputs are which parts of the metadata to use to connect to this model.

### features

The data to be passed into the SavedModel are defined in “features”. This is an array of maps and should match the following format.  For estimators an example of “features” is:

```json
[
{
    "name": "inputs",
    "data":{
         "z-axis-q75": 4.140586,
         "y-axis-q75": 4.140586
    }
}
]
```
And, for manually build models with multiple inputs “features” would be something like:

```json
[
{
    "name": "X1",
    "data":[
        [1,2,3],
        [4,5,6],
        [7,8,9]
     ]
},
{
    "name": "X2",
    "data":[
        [0.1,0.2,0.3],
        [0.4,0.5,0.6],
        [0.7,0.8,0.9]
     ]
}
]
```

### framework

The deep learning framework to use for inferencing. Currently the only supported value is: **Tensorflow**

### tag (default: “serve”) and sigDefName (default: “serving_default”)

A TensorFlow model consists of a complex graph (network) of mathematical operations that can contain many moving parts.  Another way to consider this is that a model consists of connected “computers” that each have a purpose.   To use the model we have to know which computer/part of the model to use.  “tag” is used to identify within the model metadata which part of the model to use.  Once we have selected the “computer” to use we then need to know which “ports” to use.  “sigDefName” is used within the model metadata to properly connect Flogo to the model.  These Inputs into the inference activity default to the standard values used by TensorFlow.

## Outputs

The output is an object and can contain multiple outputs. For example, for a classification model, the scores and classifications will be held in a map:

```golang
map[scores:[[0.049997408 0.010411096 0.93959147]] classes:[[Jogging Sitting Upstairs]]]
```

## Sample application

Refer to the [TensorFlow samples](https://github.com/project-flogo/ml/tree/master/examples)
