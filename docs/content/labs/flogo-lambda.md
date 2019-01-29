---
title: Building Flogo apps for Lambda
hidden: true
---

Serverless is all around us and perhaps the fastest growing market for compute. Flogo has first class support for AWS Lambda. So you can infinitely scale your ultralight functions and scale back to zero when not in use with AWS Lambda’s NoOps and seamless scaling capabilities.

We’ll guide you through the set of steps required to build the most basic of functions for deployment to AWS Lambda. The flow you’ll build will be the function you deploy.

## What you'll need

### Flogo CLI

This demo makes use of the Flogo CLI. If you don't have that one running yet, please check out [Getting Started with the Flogo CLI](../../getting-started/getting-started-cli/)

#### AWS CLI

To deploy your app at the end of this scenario you'll need the AWS CLI. There are a few ways how you can install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/installing.html).

### Need help

If you have any questions, feel free to post an [issue on GitHub](https://github.com/TIBCOSoftware/flogo/issues) and tag it as a question or chat with the team and community:

* The [project-flogo/Lobby](https://gitter.im/project-flogo/Lobby) Start here for all things Flogo!
* The [project-flogo/developers](https://gitter.im/project-flogo/developers) Developer/contributor focused conversations.

## Step 1: flogo.json

Flogo apps are constructed using a JSON file called `flogo.json`. You can create those files using the Flogo Web UI, or you can create them manually. Now let's create the flogo.json file. To do that, execute `touch flogo.json` in a terminal (or open up a new file in your text editor), which will create a new empty file for you.

Now you can copy the contents below to the newly created flogo.json file. The Flogo app has a Lambda trigger and a PATH parameter called `name`.

```json
{
  "name": "Tutorial",
  "type": "flogo:app",
  "version": "0.0.1",
  "appModel": "1.0.0",
  "triggers": [
    {
      "id": "start_flow_as_a_function_in_lambda",
      "ref": "github.com/TIBCOSoftware/flogo-contrib/trigger/lambda",
      "name": "Start Flow as a function in Lambda",
      "description": "Simple Lambda Trigger",
      "settings": {},
      "handlers": [
        {
          "action": {
            "ref": "github.com/TIBCOSoftware/flogo-contrib/action/flow",
            "data": {
              "flowURI": "res://flow:lambda_flow"
            },
            "mappings": {
              "input": [
                {
                  "mapTo": "name",
                  "type": "assign",
                  "value": "$.evt.name"
                }
              ],
              "output": [
                {
                  "mapTo": "data",
                  "type": "assign",
                  "value": "$.greeting"
                }
              ]
            }
          }
        }
      ]
    }
  ],
  "resources": [
    {
      "id": "flow:lambda_flow",
      "data": {
        "name": "LambdaFlow",
        "metadata": {
          "input": [
            {
              "name": "name",
              "type": "string"
            }
          ],
          "output": [
            {
              "name": "greeting",
              "type": "any"
            }
          ]
        },
        "tasks": [
          {
            "id": "log_2",
            "name": "Log Message",
            "description": "Simple Log Activity",
            "activity": {
              "ref": "github.com/TIBCOSoftware/flogo-contrib/activity/log",
              "input": {
                "message": "",
                "flowInfo": "false",
                "addToFlow": "false"
              },
              "mappings": {
                "input": [
                  {
                    "type": "expression",
                    "value": "string.concat(\"Hello \", $flow.name)",
                    "mapTo": "message"
                  }
                ]
              }
            }
          },
          {
            "id": "actreturn_3",
            "name": "Return",
            "description": "Simple Return Activity",
            "activity": {
              "ref": "github.com/TIBCOSoftware/flogo-contrib/activity/actreturn",
              "input": {
                "mappings": [
                  {
                    "mapTo": "greeting",
                    "type": "object",
                    "value": {"Hello": "{{$flow.name}}"}
                  }
                ]
              }
            }
          }
        ],
        "links": [
          {
            "from": "log_2",
            "to": "actreturn_3"
          }
        ]
      }
    }
  ]
}
```

## Step 2: Building an app

To create the source code simply execute `flogo create -f flogo.json myapp`. This tells the flogo cli to take the flogo.json file and create the source for the app in a folder called `myapp`. It will also download a few Go packages that the app will need.

The next step is to build the executable and for that we need to be in the directory `myapp` (`cd myapp`). To build a flogo app from the source that you can run on AWS Lambda we'll need to execute a command that is very similar to the one we had in the [cli tutorial](../flogo-cli), but with some added parameters. The command you need to run is `flogo build -e -shim start_flow_as_a_function_in_lambda`, which tells the flogo cli to build the app as an embedded application (the -e option) and with a target shim (the -shim option which uses the trigger id). The AWS Lambda trigger leverages a makefile to kick off the build process, which simply builds your Flogo application using the Lambda trigger shim and zips the binary for deployment to AWS Lambda.

Once this command finishes successfully the zip file (handler.zip) will be in the `src` directory.

## Step 3: AWS Lambda

Great! So we've built the zip that we need to deploy to Lambda and that is exactly what we'll do in this step.

### IAM policies and roles

Generally speaking it is a good idea to create separate IAM users for deploying to AWS. This allows you to explicitly control which resources a Lambda function can use. For now, you can make use of any IAM user that has the ability to deploy to AWS Lambda and you'll need the Access Key ID and Secret Access Key for this step.

As you go on with building apps for Lambda we do strongly recommend looking atht the [AWS IAM documentation](http://docs.aws.amazon.com/IAM/latest/UserGuide/introduction_access-management.html) to find out which policies you need to set for your IAM user.

For this tutorial we'll also assume that you have an IAM role with enough permissions to create a Lambda function. If you've used the AWS Lambda console, there will likely be an IAM role called **lambda_basic_execution** which you can use for this tutorial. In any case you'll need the ARN of this role later in this step (which you can find in the IAM console).

### Configure AWS CLI

Run the command `aws configure` to start the configuration of your AWS CLI. You'll be asked to provide:

* AWS Access Key ID
* AWS Secret Access Key
* Default region name (the region you want to deploy to, like `us-west-2`)
* Default output format (the output format you want, like `json`)

### Deploy your app

To deploy your app go to the directory where the zip was created. From here you can execute the command `aws lambda create-function --function-name tutorial --runtime go1.x --role arn:aws:iam::<account>:role/<role name> --handler handler --zip-file "fileb://handler.zip"`. This will create a new function in Lambda called _tutorial_, which uses the Go runtime. The _--role arn:aws:iam::<account>:role/<role name>_ is the full ARN of the IAM role used to deploy this function. If all went well you'll see a JSON response like this:

```json
{
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "CodeSha256": "KzHoXLnTXi9uMugXAOLrMHq6qJ6RimzYdNfrWXIxwLw=",
    "FunctionName": "tutorial",
    "CodeSize": 4026592,
    "RevisionId": "94b184e5-74e3-4881-abf5-debad47541b5",
    "MemorySize": 128,
    "FunctionArn": "arn:aws:lambda:<region>:<account>:function:tutorial",
    "Version": "$LATEST",
    "Role": "arn:aws:iam::<account>:role/<role>",
    "Timeout": 3,
    "LastModified": "2018-05-12T19:30:41.116+0000",
    "Handler": "handler",
    "Runtime": "go1.x",
    "Description": ""
}
```

## Step 4: Testing

The only thing left is to test your function. To do that log into AWS and select "_Lambda_", you'll be presented with all the functions you've deployed so far and one of them will be called `tutorial`. Click on that, and you'll see the overview of your function, including a large button that says "_Test_". Click "_Test_" to configure a new test event. The input for the test event should be (_you can replace "world" with any name or message you want_)

```json
{
  "name": "World"
}
```

From there, click "Test" and the execution logs will display the result

```json
{
  "Hello": "World"
}
```

And the log output

```json
START RequestId: 4f26990d-561d-11e8-96ca-bb9eb4465310 Version: $LATEST
2018-05-12 19:47:31.969 INFO   [trigger-flogo-lambda] - Starting AWS Lambda Trigger
2018/05/12 19:47:31 Starting AWS Lambda Trigger
2018/05/12 19:47:31 Received evt: 'map[name:World]'
2018/05/12 19:47:31 Received ctx: 'map[logStreamName:2018/05/12/[$LATEST]7f886628e07a4256b0f411b6cd3b6915 memoryLimitInMB:128 awsRequestId:4f26990d-561d-11e8-96ca-bb9eb4465310 functionName:tutorial functionVersion:$LATEST logGroupName:/aws/lambda/tutorial]'
2018-05-12 19:47:31.969 INFO   [activity-flogo-log] - Hello World
$flow.nameEND RequestId: 4f26990d-561d-11e8-96ca-bb9eb4465310
REPORT RequestId: 4f26990d-561d-11e8-96ca-bb9eb4465310	Duration: 1.63 ms	Billed Duration: 100 ms 	Memory Size: 128 MB	Max Memory Used: 23 MB
```

As you're glancing over the results, also look at the _Duration_ and _Max Memory Used_. Isn't that one of the smallest functions you've seen?!