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

Embrace serverless computing with Flogo's first class support for AWS Lambda. Infinitely scale Flogo's ultralight functions and scale back to zero when not in use with AWS Lambda's NoOps and seamless scaling capabilities.

We'll guide you through the set of steps required to build the most basic of functions for deployment to AWS Lambda. The flow you'll build will be the function you deploy.

## Prerequisites

Before we get started there are a few prerequisites that we need to take into account:

* You’ll need to have the [Flogo CLI](https://tibcosoftware.github.io/flogo/getting-started/getting-started-cli/) installed
* You’ll obviously need an AWS account :)

## Create the flogo.json

Every Flogo app starts with a flogo.json file. For this scenario we'll start with a very simple app that simply logs one line. You can copy the below content and paste it into a file called `flogo.json`

```json
{
  "name": "lambda",
  "type": "flogo:app",
  "version": "0.0.1",
  "description": "My flogo application description",
  "triggers": [
    {
      "id": "my_lambda_trigger",
      "ref": "github.com/TIBCOSoftware/flogo-contrib/trigger/lambda",
      "settings": {
      },
      "handlers": [
        {
          "actionId": "my_simple_flow",
          "settings": {
          }
        }
      ]
    }
  ],
  "actions": [
    {
      "id": "my_simple_flow",
      "name": "my simple flow",
      "ref": "github.com/TIBCOSoftware/flogo-contrib/action/flow",
      "data": {
        "flow": {
          "name": "my simple flow",
          "attributes": [],
          "rootTask": {
            "id": 1,
            "type": 1,
            "tasks": [
              {
                "id": 2,
                "type": 1,
                "activityRef": "github.com/TIBCOSoftware/flogo-contrib/activity/log",
                "name": "log",
                "attributes": [
                  {
                    "name": "message",
                    "value": "Simple Log",
                    "type": "string"
                  }
                ]
              }
            ],
            "links": [
            ]
          }
        }
      }
    }
  ]
}
```

## Create an app
With the flogo.json created, you can create an app out of it by simply executing one command:
```bash
flogo create -f flogo.json lambda
```

This command will download the Flogo Flow dependencies and create the directory structure for your new app.

## Build
To continue you'll need to change directories to the directory that was just created
```
cd lambda
```

We will build an embedded application [-e] option and with target shim [-shim] option using the trigger id as the shim. Note that the AWS Lambda trigger leverages a makefile to kick off the build process, the build process simply builds your Flogo application using the Lambdfa trigger shim and zips the binary for deployment to AWS Lambda.

```bash
flogo build -e -shim my_lambda_trigger
```

Once this command finishes successfully the zip file (handler.zip) will be located in your app src directory (for example /path/to/app/lambda/src/lambda/handler.zip).


## And deploy...
Deploy to AWS providing the following configuration

- Runtime: Go 1.x
- Handler: handler (this is the name of the executable file)