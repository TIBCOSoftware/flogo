# Accelerometer Example for a Tensorflow Estimator

To be able to use Machine Learning in Flogo you'll currently need to use TensorFlow.  One of the easiest ways to do that is to build and train a model with a pre-built algorithm, an Estimator.  This sample builds a model to predict if someone is standing, walking, or running, using the DNNClassifier Estimator with accelerometer data. This model is then exported into "models/TB/15*" directories.  The largest number is the most recent model.

## Usage
To use this model in Flogo you have to make the resultant exported SavedModel format in "models/TB/1519433427" accessable to the Inference Activity.  The easiest was to do that is to navigate to the "models/TB/1519433427" directory and run "zip -R Archive.zip saved_model.pb variables".  This creates the Archive.zip file which can be added to your app directory when you build your model.
