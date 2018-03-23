# Serverless Template for Project Flogo

This repository contains template for deploying serverless apps, using the [Serverless framework](https://serverless.com/), built with Project Flogo.

## Quick Start

1. Create a new service based on this template from the same folder as your flogo.json file

```
appname=${PWD##*/}
serverless create -u https://github.com/tibcosoftware/flogo/tree/master/serverless -p $appname
```

2. Copy your handler (check [here](https://tibcosoftware.github.io/flogo/faas/how-to/) to see how to build your handler for deploying Flogo apps as Lambda functions)

```
cp src/$appname/handler $appname/handler
```

3. Update the `serverless.yml` file to match your specific deployment requirements (for example bucket names, IAM roles, etcetera)

4. Package and/or Deploy!

```
# To package up your function before deploying run
serverless package
# To deploy your function run
serverless deploy
```

Special note, this unfortunately only works under Linux or macOS systems or when using the Windows Subsystem for Linux (WSL). This is because Windows developers may have trouble producing a zip file that marks the binary as exectuable on Linux (see also [here](https://github.com/aws/aws-lambda-go)).