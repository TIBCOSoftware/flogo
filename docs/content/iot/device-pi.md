---
title: Raspberry Pi 
weight: 7020
---

You can run your Flogo application on a Raspberry Pi device. (https://www.raspberrypi.org/) This documents contains all relevant information on this device including how to build.


## Build

To build a flogo application for Raspberry Pi, you simply use the build command with the appropriate enviroment variables set.

On mac or linux you execute the following command:

```bash
env GOARM=6 GOARCH=arm GOOS=linux flogo build -o
```
On windows you excute the following commands:

```bash
SET GOARM=6
SET GOARCH=arm
SET GOOS=linux
flogo build -o
```

This will compile your application and place the binary in the bin directory.   You can tweak the config.json and triggers.json in the bin directory.  In order to deploy to your device, you copy the contents of your *bin* directory to the device. To simplify deployment to a device you can incorporate the configuration files directly into the binary using the **-i** flag.

```bash
env GOARM=6 GOARCH=arm GOOS=linux flogo build -o -i
```

This way you only have to copy the executable to the device.

  For more information on configuring and bulding your application reference the [app command readme] (https://github.com/TIBCOSoftware/flogo-cli/blob/master/docs/app.md) file.


## References
* [GoArm](https://github.com/golang/go/wiki/GoArm) - General information on building for Go code for ARM 
* [Cross compilation with Go 1.5](http://dave.cheney.net/2015/08/22/cross-compilation-with-go-1-5)
