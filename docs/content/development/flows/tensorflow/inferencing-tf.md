---
title: Inferencing
weight: 4220
---

Before you begin with the [ML Inferencing activity](https://github.com/TIBCOSoftware/flogo-contrib/tree/master/activity/inference), refer to the [Flows > TensorFlow > Getting Started](../../tensorflow/getting-started/) documentation.

## Overview of the Inference Activity

The inference activity was built to support the concept of plugable frameworks, however the only supported framework is currently **TensorFlow**. The activity leverages the Golang API from TensorFlow. You don't need Python or anything other than the TensorFlow dynamic library installed on your dev & target machine.

## Inputs

### model

The model input to the activity should be either of the following:

- An archive (zip) of the model
- A directory containing the exported protobuf and check point files

The activity has been tested with the exported model from the [tf.estimator.Exporter.export](https://www.tensorflow.org/api_docs/python/tf/estimator/Exporter) operation. After export, optionally zip the file, where the saved_model.pb file is located at the root of the archive.

The exported model from the tf.estimator package includes metadata defining the model. The signature_def element in the protobuf provides valuable data for inferencing the model that is leveraged by the Flogo activity. Some of the metadata includes

- the input key name, as well as the tensor (operation) to to be invoked. The input keyname is required as an input to the flogo activity
- the output keys, as well as the output tensors (which define the data types of the outputs). Multiple outputs can be present
- the method_name, such as classify, regression, etc

### inputName

The input key name for the input tensor. This can be fetched using the [SavedModel CLI tools](https://www.tensorflow.org/versions/r1.2/programmers_guide/saved_model_cli). Typically the name is **"inputs"**

### features

The features to pass into the SavedModel. This is of type object and should match the following format. Note that the input is a JSON object where the key is the feature name and the value is the value.

```json
{
    "z-axis-q75": 4.140586,
    "y-axis-q75": 4.140586
}
```

### framework

The deep learning framework to use for inferencing. Currently the only supported value is: **Tensorflow**

## Outputs

The output is an object and can contain multiple outputs. For example, for a classification model, the scores and classifications will ne held in a map:

```golang
map[scores:[[0.049997408 0.010411096 0.93959147]] classes:[[Jogging Sitting Upstairs]]]
```

## Sample application

Refer to the [TensorFlow samples](https://github.com/TIBCOSoftware/flogo/tree/master/samples/tensorflow)