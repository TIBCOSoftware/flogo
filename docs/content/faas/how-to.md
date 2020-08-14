---
title: Flogo and Lambda
weight: 8010
---

<center>
<svg xmlns="http://www.w3.org/2000/svg" width="418" height="236" viewBox="0 0 418 236">
    <g fill="none" fill-rule="evenodd">
        <g stroke="#87909B" opacity=".2" transform="rotate(-90 143.625 -33.375)">
            <path stroke-width="3.39" d="M82.24 31.092H59.96a10.734 10.734 0 0 1-7.864-3.428l-6.528-7.027a10.734 10.734 0 0 0-7.864-3.428H6.78M0 28.451h22.262a10.76 10.76 0 0 1 7.883 3.43l6.523 7.022"/>
            <ellipse cx="90.96" cy="30.137" stroke-width="4.52" rx="9.04" ry="8.993"/>
            <ellipse cx="39.831" cy="42.222" stroke-width="3.955" rx="6.78" ry="6.755" transform="matrix(-1 0 0 1 79.661 0)"/>
            <ellipse cx="68.079" cy="5.124" stroke-width="3.955" rx="6.78" ry="6.755"/>
            <path stroke-width="3.39" d="M12.495 4.983H61.22"/>
        </g>
        <g stroke="#87909B" transform="translate(224 72.25)">
            <path stroke-width="6" d="M145.563 124.699H106.16a19 19 0 0 1-13.953-6.104l-11.546-12.492A19 19 0 0 0 66.708 100H12M0 120h39.403a19 19 0 0 1 13.953 6.103l11.546 12.492"/>
            <circle cx="161" cy="123" r="16" stroke-width="8"/>
            <circle cx="70.5" cy="144.5" r="12" stroke-width="7" transform="matrix(-1 0 0 1 141 0)"/>
            <circle cx="120.5" cy="78.5" r="12" stroke-width="7"/>
            <path stroke-width="6" d="M22.116 78.249h86.245M12 56.699h39.403a19 19 0 0 0 13.953-6.104l11.546-12.492A19 19 0 0 1 90.855 32h54.708M0 36.699h39.403a19 19 0 0 0 13.953-6.104l11.546-12.492"/>
            <circle cx="161" cy="32" r="16" stroke-width="8"/>
            <circle cx="70.5" cy="8.5" r="12" stroke-width="7"/>
        </g>
        <g stroke="#87909B" transform="matrix(-1 0 0 1 180 71.25)">
            <path stroke-width="6" d="M133.563 114.699H94.16a19 19 0 0 1-13.953-6.104L68.661 96.103A19 19 0 0 0 54.708 90H0M2 114h39.403a19 19 0 0 1 13.953 6.103l11.546 12.492"/>
            <circle cx="149" cy="113" r="16" stroke-width="8"/>
            <circle cx="74.5" cy="141.5" r="12" stroke-width="7" transform="matrix(-1 0 0 1 149 0)"/>
            <path stroke-width="6" d="M44 36.699h39.403a19 19 0 0 0 13.953-6.104l11.546-12.492"/>
            <circle cx="114.5" cy="8.5" r="12" stroke-width="7"/>
        </g>
        <g stroke="#87909B" opacity=".2" transform="matrix(-1 0 0 1 134 112.25)">
            <path stroke-width="3.39" d="M104 36H77.598a10.734 10.734 0 0 1-7.863-3.427l-8.5-9.146A10.734 10.734 0 0 0 53.37 20H17M9 33h25.484a12.28 12.28 0 0 1 9.024 3.954l7.468 8.092"/>
            <circle cx="113.5" cy="34.5" r="10.5" stroke-width="4.52"/>
            <circle cx="54.5" cy="48.5" r="7.477" stroke-width="3.955" transform="matrix(-1 0 0 1 109 0)"/>
            <circle cx="87.5" cy="5.5" r="7.477" stroke-width="3.955"/>
            <path stroke-width="3.39" d="M.5 5.5H79"/>
        </g>
        <g transform="translate(111 78.25)">
            <circle cx="70" cy="71.75" r="66.875" fill="#576474"/>
            <g transform="translate(34 31)">
                <rect width="74" height="24" fill="#FFF" rx="3"/>
                <path fill="#D3D6DA" d="M41 7h22v3H41zM41 14h22v3H41z"/>
                <circle cx="13" cy="12" r="6" fill="#D3D6DA"/>
            </g>
            <g transform="translate(34 59)">
                <rect width="74" height="24" fill="#FFF" rx="3"/>
                <path fill="#D3D6DA" d="M41 7h22v3H41zM41 14h22v3H41z"/>
                <circle cx="13" cy="12" r="6" fill="#D3D6DA"/>
            </g>
            <g transform="translate(34 87)">
                <rect width="74" height="24" fill="#FFF" rx="3"/>
                <path fill="#D3D6DA" d="M41 7h22v3H41zM41 14h22v3H41z"/>
                <circle cx="13" cy="12" r="6" fill="#D3D6DA"/>
            </g>
            <circle cx="71" cy="71" r="67" stroke="#36BFBB" stroke-width="8"/>
        </g>
        <path fill="#FECB38" d="M92.635 64.986L77.5 117.084l19.738-4.452a1 1 0 0 1 1.174 1.276l-9.697 30.808a1 1 0 0 0 1.823.795l26.191-46.019a1 1 0 0 0-1.043-1.48l-18.116 3.21a1 1 0 0 1-1.086-1.397l15.273-33.848a1 1 0 0 0-.894-1.41l-17.252-.302a1 1 0 0 0-.977.72z"/>
        <path stroke="#36BFBB" stroke-width="12" d="M134.266 190.55l91.71-91.71"/>
    </g>
</svg>
</center>

Serverless is all around us and perhaps the fastest growing market for compute. Flogo has first class support for AWS Lambda. So you can infinitely scale your ultralight functions and scale back to zero when not in use with AWS Lambda’s NoOps and seamless scaling capabilities.

We’ll guide you through the set of steps required to build the most basic of functions for deployment to AWS Lambda. The flow you’ll build will be the function you deploy.

## Prerequisites

Before we get started there are a few prerequisites that we need to take into account:

* You’ll need to have the [Flogo CLI](https://tibcosoftware.github.io/flogo/getting-started/getting-started-cli/) and at least Go 1.11 installed
* If you want to deploy using the AWS cli you'll need to install [that](https://docs.aws.amazon.com/cli/latest/userguide/installing.html) too
* You’ll obviously need an AWS account :)

## Create the flogo.json

Flogo apps are constructed using a JSON file called `flogo.json`. You can create those files using the Flogo Web UI, or you can create them manually. You can copy the below content and paste it into a file called `flogo.json`. The Flogo app has a Lambda trigger which can be triggered by any event supported by AWS Lambda.

```json
{
  "name": "myApp",
  "type": "flogo:app",
  "version": "0.0.1",
  "description": "",
  "appModel": "1.1.0",
  "imports": [
    "github.com/project-flogo/flow",
    "github.com/project-flogo/aws-contrib/trigger/lambda",
    "github.com/project-flogo/contrib/activity/actreturn",
    "github.com/project-flogo/contrib/activity/log",
    "github.com/project-flogo/contrib/function/string"
  ],
  "triggers": [
    {
      "id": "aws_lambda_trigger",
      "ref": "#lambda",
      "settings": null,
      "handlers": [
        {
          "settings": null,
          "actions": [
            {
              "ref": "#flow",
              "settings": {
                "flowURI": "res://flow:my_function"
              },
              "input": {
                "name": "=$.event.name"
              },
              "output": {
                "data": "=$.greeting",
                "status": 200
              }
            }
          ]
        }
      ]
    }
  ],
  "resources": [
    {
      "id": "flow:my_function",
      "data": {
        "name": "MyFunction",
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
            "name": "Log",
            "description": "Logs a message",
            "activity": {
              "ref": "#log",
              "input": {
                "addDetails": false,
                "message": "=string.concat(\"Hello \", $flow.name)"
              }
            }
          },
          {
            "id": "actreturn_3",
            "name": "Return",
            "description": "Return Activity",
            "activity": {
              "ref": "#actreturn",
              "settings": {
                "mappings": {
                  "greeting": {
                    "mapping": {
                      "Hello": "=$flow.name"
                    }
                  }
                }
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

## Create an app
To create the source code simply execute 
```
flogo create -f flogo.json myapp
```
This tells the flogo cli to take the flogo.json file and create the source for the app in a folder called `myapp`. It will also download a few Go packages that the app will need.

## Build
The next step is to build the executable and for that we need to be in the directory `myapp`. To build a flogo app from the source that you can run on AWS Lambda we'll need to execute the command
```
flogo build -e --shim aws_lambda_trigger
```
. This command tells the flogo cli to build the app as an embedded application (the -e option) and with a target shim (the --shim option which uses the trigger id). The AWS Lambda trigger leverages a makefile to kick off the build process, which simply builds your Flogo application using the Lambda trigger shim and zips the binary for deployment to AWS Lambda.

Once this command finishes successfully the zip file (handler.zip) will be located in your app src directory (for example /path/to/app/lambda/src/lambda/handler.zip).


## Deploy
There are several ways to deploy to AWS Lambda. A non-exhaustive list is:

* Uploading the code
* Using SAM templates
* Using Serverless Framework
* Using the AWS CLI

In this scenario we'll look at numbers 1 and 4

### Uploading the code
From the Lambda console you can easily create a new function. As you do that set the runtime to **Go 1.x**, upload the zip file and set the handler to **handler**.

### Using the AWS CLI
To deploy your app using the AWS CLI go to the directory where the zip was created and from there execute the command 
```
aws lambda create-function --function-name tutorial --runtime go1.x --role arn:aws:iam::<account>:role/<role name> --handler handler --zip-file "fileb://handler.zip"
```
This will create a new function in Lambda called _tutorial_, which uses the Go runtime. The _--role arn:aws:iam::<account>:role/<role name>_ is the full ARN of the IAM role used to deploy this function. If all went well you'll see a JSON response like this:
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

## Testing 1... 2... 3...
The only thing left is to test your function. To do that log into AWS and select "Lambda", you'll be presented with all the functions you've deployed so far and one of them will be called `tutorial`. Click on that, and you'll see the overview of your function, including a large button that says "Test". Click "Test" to configure a new test event. The input for the test event should be
```
{
  "name": "World"
}
```
_You can replace "world" with any name or message you want_

From there, click "Test" and the execution logs will display the result

```
{
  "Hello": "World"
}
```

And the log output
```
START RequestId: 2f4086f8-5721-4bf4-b0b7-94cb9d52c709 Version: $LATEST
2019/05/13 13:13:37 Received request: 2f4086f8-5721-4bf4-b0b7-94cb9d52c709
2019/05/13 13:13:37 Payload Type: unknown
2019/05/13 13:13:37 Payload: 'map[name:Matt]'
END RequestId: 2f4086f8-5721-4bf4-b0b7-94cb9d52c709
REPORT RequestId: 2f4086f8-5721-4bf4-b0b7-94cb9d52c709	Duration: 0.76 ms	Billed Duration: 100 ms 	Memory Size: 512 MB	Max Memory Used: 30 MB
```

As you're glancing over the results, also look at the _Duration_ and _Max Memory Used_. Isn't that one of the smallest functions you've seen?!
