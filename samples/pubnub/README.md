# PubNub demo

Security matters, especially when it comes to microservices that handle your information. This demo app uses [PubNub](https://www.pubnub.com/), which provides end-to-end encryption of messages, to reveive messages from a predefined channel

## Building this app
### From the Web UI
To load this app into the Flogo Web UI, you'll need to import two activities first:

* Write To File: https://github.com/retgits/flogo-components/activity/writetofile
* PubNub subscriber: https://github.com/retgits/flogo-components/trigger/pubnubsubscriber

After you've done this, you can upload the `flogo.json` file and update the configuration of the PubNub subscriber to match your PubNub account. Now you can build and run the app.

### From the command line
To get started from the command line, download the `flogo.json` and update the variables for the Publish and Subscriber key, as well as the channel (all of them are set to `xxx`). Now, run `flogo create -f flogo.json pubnubapp` to create a new Flogo app with the name pubnubapp.

To build and run the app, execute
```
cd pubnubapp
flogo build -e
./bin/pubnupapp
```

## More information
If you're looking for a more in-depth overview of how the app is built, check out the [lab](http://tibcosoftware.github.io/flogo/labs/pubnub-demo/)