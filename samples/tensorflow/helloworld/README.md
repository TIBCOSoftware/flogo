# PredictMovement
This sample Flogo application is used to demonstrate some key Flogo constructs:

- TensorFlow inferencing
- CLI Trigger
- Complex object mapping

## Building the app
To build via the Flogo CLI, simply download the PredictMovement.json to your local machine and create the app structure:

```{r, engine='bash', count_lines}
flogo create -flv github.com/TIBCOSoftware/flogo-contrib/action/flow@master,github.com/TIBCOSoftware/flogo-lib/engine@master -f PredictMovement.json
cd PredictMovement
```

Note that the above command indicates that the master branch of flogo-lib & flogo-contrib should be used when the dependencies are fetched.

You can now build the application and target the CLI trigger as the entrypoint. When targeting a specific trigger, the resulting binary will include only the flow(s) where the trigger is mapped will be included.

```{r, engine='bash', count_lines}
flogo build -e -shim cli_trigger
```

- the -e switch indicates that the binary should embed the flogo.json.
- the -shim cli_trigger indicates that the entrypoint will be via the CLI trigger

## Run the application

Don't forget to download and place [Archive.zip](https://github.com/TIBCOSoftware/flogo/blob/master/samples/tensorflow/helloworld/Archive.zip) in the bin directory before running the application. The zip file contains the TensorFlow model that will be run by the inference activity.

Now that the application has been built, run the application:

```{r, engine='bash', count_lines}
cd bin
./PredictMovement
```

The following result should appear:

```{r, engine='bash', count_lines}
2018-02-06 11:02:50.751 DEBUG  [activity-tibco-inference] - Loaded Framework: Tensorflow
2018-02-06 11:02:50.778579: I tensorflow/cc/saved_model/loader.cc:226] Loading SavedModel from: /var/folders/t9/2d315wj12g5f6pw50k0pw5dm0000gp/T/26B7F65E-01A5-F8FC-25C0-3E7E9FC0BB4B
2018-02-06 11:02:50.784177: W tensorflow/core/platform/cpu_feature_guard.cc:45] The TensorFlow library wasn't compiled to use SSE4.2 instructions, but these are available on your machine and could speed up CPU computations.
2018-02-06 11:02:50.784198: W tensorflow/core/platform/cpu_feature_guard.cc:45] The TensorFlow library wasn't compiled to use AVX instructions, but these are available on your machine and could speed up CPU computations.
2018-02-06 11:02:50.784205: W tensorflow/core/platform/cpu_feature_guard.cc:45] The TensorFlow library wasn't compiled to use AVX2 instructions, but these are available on your machine and could speed up CPU computations.
2018-02-06 11:02:50.784210: W tensorflow/core/platform/cpu_feature_guard.cc:45] The TensorFlow library wasn't compiled to use FMA instructions, but these are available on your machine and could speed up CPU computations.
2018-02-06 11:02:50.791659: I tensorflow/cc/saved_model/loader.cc:145] Restoring SavedModel bundle.
2018-02-06 11:02:50.799570: I tensorflow/cc/saved_model/loader.cc:180] Running LegacyInitOp on SavedModel bundle.
2018-02-06 11:02:50.803453: I tensorflow/cc/saved_model/loader.cc:274] Loading SavedModel: success. Took 24917 microseconds.
2018-02-06 11:02:50.812 DEBUG  [activity-tibco-inference] - Incoming features:
2018-02-06 11:02:50.812 DEBUG  [activity-tibco-inference] - map[y-axis-skew:-0.49036224958471764 z-axis-q25:-1.9477097 x-axis-sd:6.450293741961166 x-axis-q25:-3.1463003 x-axis-q75:6.3198414 y-axis-sd:-7.959084724314854 x-axis-skew:0.09756801680727022 y-axis-mean:9.389463650669393 x-axis-mean:1.7554575428900194 z-axis-sd:4.6888631696380765 corr-x-y:0.08100326860866637 z-axis-mean:1.1226106985139188 corr-z-y:0.3467060369518231 corr-x-z:0.1381063882214782 z-axis-skew:-0.3619011587545954 y-axis-q75:16.467001 z-axis-q75:4.140586 y-axis-q25:3.0645783]
2018-02-06 11:02:50.812 DEBUG  [activity-tibco-inference] - Parsing of features completed
2018-02-06 11:02:50.824 DEBUG  [activity-tibco-inference] - Model execution completed with result:
2018-02-06 11:02:50.824 INFO   [activity-tibco-inference] - map[classes:[[Jogging Sitting Upstairs]] scores:[[0.049997408 0.010411096 0.93959147]]]
2018-02-06 11:02:50.824 DEBUG  [model-tibco-simple] - done task: Invoke ML Model
2018-02-06 11:02:50.824 DEBUG  [model-tibco-simple] - notifying parent that task is done
2018-02-06 11:02:50.824 DEBUG  [model-tibco-simple] - all child tasks done or skipped
2018-02-06 11:02:50.824 DEBUG  [model-tibco-simple] - done task:
2018-02-06 11:02:50.824 DEBUG  [model-tibco-simple] - notifying parent that task is done
2018-02-06 11:02:50.824 DEBUG  [model-tibco-simple] - Flow Done
```
