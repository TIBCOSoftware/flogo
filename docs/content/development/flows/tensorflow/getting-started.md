---
title: Getting Started
weight: 4210
---

First and foremost, Flogo supports inferencing TensorFlow models, it does not support training of models using incoming data. The training should be performed in Python and the protobuf and checkpoints exported for inferencing at runtime in Flogo.

Before you can begin inferencing TensorFlow models within your Flogo Flows, you’ll need to consider a few requirements.

## Pre-requisites

The TensorFlow dynamic lib must be installed on both your development machine, as well as the target machine/device. The dynlib must be built specifically for your platform architecture, that is, Linux Arm, x86, x64, Darwin, etc. Follow the instructions documented by [TensorFlow](https://www.tensorflow.org/install/install_go), note that the only steps that you'll need to follow are 2 and 3: downloading the correct dynamic lib and setting your lib paths. You do not need to 'go get' TensorFlow.

## TensorFlow Models
As previously stated, Flogo is leveraged to inference models at runtime, not train any models. Flogo includes a native activity to inference models. The activity has been developed and tested against the output of the [tf.estimator](https://www.tensorflow.org/api_docs/python/tf/estimator) API from TensorFlow.