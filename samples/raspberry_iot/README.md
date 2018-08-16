# Flogo on Raspberry Pi

A Raspberry Pi is probably one of the most well-known small single-board computers built to promote the teaching of basic computer science, and increasingly used for cool IoT projects. Flogo runs perfectly on these small devices, so we built a cool sample!

## Building this app
### From the Web UI
You can upload the `flogo.json` file and update any configuration that you want. As you're building the app, please make sure you select `linux/arm` as the build target

### From the command line
To get started from the command line, download the `flogo.json` and update any variables you might want to update. Now, run `flogo create -f raspberry_iot.json raspberryapp` to create a new Flogo app with the name raspberryapp.

To build and run the app, execute
```
cd raspberryapp
GOOS=linux GOARCH=arm GOARM=7 flogo build -e
```

Now you can copy the exectuable from the `bin` directory to your Raspberry Pi!

Alternatively, you can also install Go on your Raspberry Pi and build everything from there :smile: 

## More information
If you're looking for a more in-depth overview of how the app is built, check out the [lab](http://tibcosoftware.github.io/flogo/labs/raspberry-iot/)
