---
title: Tutorial with Serverless Framework
weight: 2540
---

You can deploy your Flogo apps to, for example, AWS Lambda using the [Serverless Framework](https://serverless.com).With the Serverless Framework, you can configure which events should trigger it, where to deploy it and what kind of resources it is allowed to use without going into the AWS console.

## Prerequisites
In this tutorial, we’ll walk you through deploying your Flogo app to AWS Lambda using Serverless. 

You’ll need to have:

1. an app built for [AWS Lambda](https://tibcosoftware.github.io/flogo/faas/how-to/)
1. the [Serverless Framework](https://serverless.com/framework/docs/providers/aws/guide/quick-start/)
1. an [AWS account](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html) 

_Note that if you don’t have that done yet, the links will guide you through the steps_

For this tutorial we'll assume the name of the directory of the app is `serverlesslambdaapp`

## Deploying Apps with Serverless
The team at Serverless did an amazing job making deployments and packaging really simple. When you've built your app you only need a few steps to deploy using Serverless.

The first thing is to create a new Serverless service in the same folder as your `flogo.json` file:
```
# Let’s create a serverless service with the same name as the app
serverless create -u https://github.com/tibcosoftware/flogo/tree/master/serverless -p serverlesslambdaapp
```

The next step is to copy the `handler` over to the newly-created Serverless folder:
```
cp src/serverlesslambdaapp/handler serverlesslambdaapp/handler
```

This would be an ideal time to update your `serverless.yml` file with any bucket names, IAM roles, environment variables or anything that you want to configure, because the only thing left is to deploy!
```
# To package up your function before deploying run
cd serverlesslambdaapp
serverless package

# To deploy, which also does the packaging, your function run
cd serverlesslambdaapp
serverless deploy
```

*Note: this unfortunately only works under Linux or macOS systems, or when using the Windows Subsystem for Linux (WSL). This is because Windows developers may have trouble producing a zip file that marks the binary as executable on Linux. [See here for more info](https://github.com/aws/aws-lambda-go)).
