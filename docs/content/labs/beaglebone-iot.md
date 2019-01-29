---
title: "IoT Apps: BeagleBone"
hidden: true
---

Flogo can run almost anywhere. From the largest clouds, to the smallest of devices and everything in between. Take this lab to get yourself familiar with how to develop apps for IoT devices using the Flogo CLI. Let's look at building for BeagleBone!

## What you'll need

### Flogo CLI

This demo makes use of the Flogo CLI. If you don't have that one running yet, please check out [Getting Started with the Flogo CLI](../../getting-started/getting-started-cli/)

### IoT How-to

This demo makes use of the [IoT Apps](../iot-howto) tutorial. If you haven't done that one yet, this is a great time to do so!

### Need help

If you have any questions, feel free to post an [issue on GitHub](https://github.com/TIBCOSoftware/flogo/issues) and tag it as a question or chat with the team and community:

* The [project-flogo/Lobby](https://gitter.im/project-flogo/Lobby) Start here for all things Flogo!
* The [project-flogo/developers](https://gitter.im/project-flogo/developers) Developer/contributor focused conversations.

## Building an app

To build a Flogo application for BeagleBone, you simply use the build command with the appropriate enviroment variables set to compile to Go code for an ARM processor.

On macOS or Linux machines the additional parameters you need to set when building Flogo apps are:

```bash
env GOARM=7 GOARCH=arm GOOS=linux flogo build -e
```

On Windows the additional parameters you need to set when building Flogo apps are:

```bash
SET GOARM=7
SET GOARCH=arm
SET GOOS=linux
flogo build -e
```

Note that the above samples compile for an ARMv6 processor. You can check the BeagleBone [website](http://beagleboard.org/bone) to see which version of the ARM processor you have.
