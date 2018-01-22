---
title: How-to for IOT
weight: 7010
---

Creating a flogo application is easy and we've outlined the steps for you in this howto guide. This guide will walk you through the steps required to create a simple flogo application which can also be used on an IOT device.

## Prerequisites
Before you can get started building IOT applications with flogo, you need to have the following prerequisites installed:

* The Go programming language should be [installed](https://golang.org/doc/install).
* In order to simplify development and building in Go, we recommend using the **gb** build tool.  It can be downloaded from [here](https://getgb.io).
* You should have Flogo installed: `go get github.com/TIBCOSoftware/flogo-cli/...`

## Creating your App

### Getting Started

Once you have the prerequisites installed, you can create your application using the flogo CLI tool.  You can get more information on using the tool from the flogo-cli [readme](https://github.com/TIBCOSoftware/flogo-cli/blob/master/README.md). You can also find additional documentation on creating an application using the CLI tool in the app command [readme](https://github.com/TIBCOSoftware/flogo-cli/blob/master/docs/app.md).

Lets get started by creating a simple IOT application that just counts the number of requests it recieves.

### Application

We are going to create an application from an existing flogo.json configuration file, create a file my_flogo.json and copy the following content to it

```json
{  
   "name":"counter",
   "type":"flogo:app",
   "version":"0.0.1",
   "description":"Sample flogo app",
   "triggers":[  
      {  
         "name":"Receiver",
         "ref":"github.com/TIBCOSoftware/flogo-contrib/trigger/rest",
         "description":"Simple REST Trigger",
         "settings":{  
            "port":"8189"
         },
         "id":"receiver",
         "handlers":[  
            {  
               "settings":{  
                  "method":"GET",
                  "path":"/counter",
                  "autoIdReply":"true",
                  "useReplyHandler":"true"
               },
               "actionId":"hello_world"
            }
         ]
      }
   ],
   "actions":[  
      {  
         "name":"HelloWorld",
         "data":{  
            "flow":{  
               "type":1,
               "attributes":[  

               ],
               "rootTask":{  
                  "id":1,
                  "type":1,
                  "tasks":[  
                     {  
                        "id":2,
                        "name":"Number Counter",
                        "description":"Simple Global Counter Activity",
                        "type":1,
                        "activityRef":"github.com/TIBCOSoftware/flogo-contrib/activity/counter",
                        "attributes":[  
                           {  
                              "name":"counterName",
                              "value":"number",
                              "required":false,
                              "type":"string"
                           },
                           {  
                              "name":"increment",
                              "value":"true",
                              "required":false,
                              "type":"boolean"
                           },
                           {  
                              "name":"reset",
                              "value":"false",
                              "required":false,
                              "type":"boolean"
                           }
                        ]
                     },
                     {  
                        "id":3,
                        "name":"Logger",
                        "description":"Simple Log Activity",
                        "type":1,
                        "activityRef":"github.com/TIBCOSoftware/flogo-contrib/activity/log",
                        "attributes":[  
                           {  
                              "name":"message",
                              "value":"hello world",
                              "required":false,
                              "type":"string"
                           },
                           {  
                              "name":"flowInfo",
                              "value":"true",
                              "required":false,
                              "type":"boolean"
                           },
                           {  
                              "name":"addToFlow",
                              "value":"true",
                              "required":false,
                              "type":"boolean"
                           }
                        ],
                        "inputMappings":[  
                           {  
                              "type":1,
                              "value":"{A2.value}",
                              "mapTo":"message"
                           }
                        ]
                     }
                  ],
                  "links":[  
                     {  
                        "id":1,
                        "from":2,
                        "to":3,
                        "type":0
                     }
                  ],
                  "attributes":[  

                  ]
               }
            }
         },
         "id":"hello_world",
         "ref":"github.com/TIBCOSoftware/flogo-contrib/action/flow"
      }
   ]
}
```

We will continue by creating the application using the CLI.  This creates the basic structure for your application and imports the needed dependencies according to the flogo.json (In this case my_flogo.json created in the previous step).

```bash
flogo create -f /path/to/file/my_flogo.json counter
cd counter
``` 

## Building your App
Now our application is ready to build. It can be built to run locally for preliminary testing and also for you IOT device.
### Local

To build a flogo application, you simply use the build command.

```bash
flogo build
```
This will compile your application and place the binary in the bin directory.  You can tweak the config.json and triggers.json and execute you application.  For more information on configuring and bulding your application reference the [app command readme] (https://github.com/TIBCOSoftware/flogo-cli/blob/master/docs/app.md) file.

### Device
Once you are ready to test your application on your device, the following links have information on specific devices including on how to build flogo for that device.

* [Raspberry Pi](https://tibcosoftware.github.io/flogo/iot/device-pi) 
* [C.H.I.P.](https://tibcosoftware.github.io/flogo/iot/device-chip)
* [Intel Edison](https://tibcosoftware.github.io/flogo/iot/device-edison)
* [BeagleBone](https://tibcosoftware.github.io/flogo/iot/device-beaglebone)

## Testing your App

Once you have your application built, you can execute the generated binary to test it out.

Once your app is started, you can test it out using a simple **curl** command.

```bash
curl http://localhost:8189/counter
```

Now you should see your counter value increment in the engine console with each invocation.


## References
* [GoArm](https://github.com/golang/go/wiki/GoArm) - General information on building for Go code for ARM 
* [Cross compilation with Go 1.5](http://dave.cheney.net/2015/08/22/cross-compilation-with-go-1-5)
* Supported Go [operating systems and architectures](https://golang.org/doc/install/source#environment)
