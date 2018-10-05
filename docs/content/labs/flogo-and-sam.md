---
title: Flogo and SAM
hidden: true
---

The [AWS Serverless Application Model (AWS SAM)](https://github.com/awslabs/serverless-application-model) helps you to define serverless applications in simple and clean syntax. You can use the [SAM CLI](https://github.com/awslabs/aws-sam-cli) to manage Serverless applications written with AWS Serverless Application Model (SAM). SAM CLI can be used to test functions locally, start a local API Gateway from a SAM template, validate a SAM template, fetch logs, generate sample payloads for various event sources, and generate a SAM project in your favorite Lambda Runtime.

In this tutorial you'll use the AWS SAM CLI to test a Flogo app that has a Lambda trigger, without deploying it to AWS Lambda. This will obviously increase the developer productivity even more!

## What you'll need

### Flogo CLI

This demo makes use of the Flogo CLI. If you don't have that one running yet, please check out [Getting Started with the Flogo CLI](../../getting-started/getting-started-cli/)

### AWS SAM CLI

The demo makes use of the AWS SAM CLI. If you haven't installed it yet, please check out the [installation](https://github.com/awslabs/aws-sam-cli/blob/develop/docs/installation.rst) instructions for your OS.

### Docker

The AWS SAM CLI makes use of Docker images to run your app locally. You need to have Docker installed and running on your machine to complete this tutorial.

### Need help

If you have any questions, feel free to post an [issue on GitHub](https://github.com/TIBCOSoftware/flogo/issues) and tag it as a question or chat with the team and community:

* The [project-flogo/Lobby](https://gitter.im/project-flogo/Lobby) Start here for all things Flogo!
* The [project-flogo/developers](https://gitter.im/project-flogo/developers) Developer/contributor focused conversations.

## Step 1: Building the app

For this tutorial, you can make use of any app that uses the Lambda trigger. If you don't have an app yet, you can use this one:

The Flogo app has a Lambda trigger and a PATH parameter called `name`.

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

To create a Lambda file from this, you can run:

```bash
// Create the app
flogo create -f flogo.json myapp
// Build the app
cd myapp
flogo build -e -shim start_flow_as_a_function_in_lambda
```

## Step 2: Create a template.yml

 > You can use the `sam local invoke` command to manually test your code by running Lambda function locally. With SAM CLI, you can easily author automated integration tests by first running tests against local Lambda functions before deploying to the cloud.

Now that is awesome! In order to make that work, SAM needs to have a descriptor called `template.yml` that describes what the function is and what other parameters it has. Assuming you've used the app above, a YAML file could look like

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Transform: 'AWS::Serverless-2016-10-31'
Description: Serverless Application Model
Resources:
  flogoapp: # The name you want to give your Lambda function
    Type: 'AWS::Serverless::Function'
    Properties:
      CodeUri: bin/ # The location where to find the executable file (not the zip file from the Web UI)
      Handler: handler # The name of the handler generated by the flogo build command
      Runtime: go1.x
      Tracing: Active
      Timeout: 120
      Events:
        flogoevent: # This is a sample event
          Type: Schedule
          Properties:
            Schedule: cron(0 2 * * ? *) # Run at 2:00 am (UTC) every day
      Description: Run Hello World every night! # A description for your Lambda app
      MemorySize: 128 # The amount of memory you want to give your app in Lambda
```

For clarity sake, you can create a new directory called `lambda` and put all files in that directory.

## Step 3: Events

To be able to test the apps locally, SAM makes use of events from JSON files. Events describe the input that would normally come from external apps like Amazon S3 or Amazon API Gateway. In this case, the event will be really simple. You'll have to create a new file called `event.json` and the content of the file will be:

```json
{
  "name": "World"
}
```

## Step 4: Run locally

Before you can run the app, the final step is to copy the executable file (generated in step 1) to the right location. Create a `bin` folder in the `lambda` folder you created earlier and copy the file `/src/myapp/handler` to that location.

From a terminal window you can now use the SAM CLI to run your app locally:

```bash
sam local invoke <function> -e <event.json file>
```

So in this case the command will be

```bash
sam local invoke flogoapp -e event.json
```

As you run that, the output will look like (the last line will display the result of your app)

```bash
2018-10-03 16:53:03 Invoking handler (go1.x)
2018-10-03 16:53:03 Found credentials in shared credentials file: ~/.aws/credentials

Fetching lambci/lambda:go1.x Docker container image......
2018-10-03 16:53:04 Mounting /Users/lstigter/Downloads/myapp/lambda/bin as /var/task:ro inside runtime container
START RequestId: 8791ddd9-c612-1864-f381-75d1506ad692 Version: $LATEST
2018-10-03 23:53:05.119 INFO   [trigger-flogo-lambda] - Starting AWS Lambda Trigger
2018/10/03 23:53:05 Starting AWS Lambda Trigger
2018/10/03 23:53:05 Received evt: 'map[name:World]'
2018/10/03 23:53:05 Received ctx: 'map[awsRequestId:8791ddd9-c612-1864-f381-75d1506ad692 functionName:test functionVersion:$LATEST logGroupName:/aws/lambda/test logStreamName:2018/10/03/[$LATEST]b1ff97369e34dbbe4f8ee4f578cde273 memoryLimitInMB:128]'
2018-10-03 23:53:05.123 INFO   [activity-flogo-log] - Hello World
END RequestId: 8791ddd9-c612-1864-f381-75d1506ad692
REPORT RequestId: 8791ddd9-c612-1864-f381-75d1506ad692	Duration: 5.38 ms	Billed Duration: 100 ms	Memory Size: 128 MB	Max Memory Used: 8 MB
{"Hello":"World"}
```