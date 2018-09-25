---
title: Tutorial for AWS IoT
weight: 2550
---

A device shadow is a digital representation in the cloud that stores and retrieves current state information for a device. You can get and set the state of a device over MQTT or HTTP, even if the device isn't connected to the Internet.

## What you'll need
### The Flogo Web UI
This demo makes use of the Flogo Web UI. If you don't have that one running yet, please check out [Getting Started with the Flogo Web UI](https://tibcosoftware.github.io/flogo/getting-started/getting-started-webui/)

### Certificates
The AWS IoT Device Shadow service requires a very specific setup to make use of SSL certificates. You'll need to download the AWS IoT certificate and private key files. You'll need to put everything in a special folder too, but you'll be able to do that later.

## Step 1: Create the app
Open the Flogo Web UI and from there, click "New" to create a new microservice and give your new app a name. Click "Create a Flow" to create a new flow and give it any name that you want. Now click on the flow you just created and to open the canvas where you can design your flow. 

![](../../images/labs/aws-iot/step1.png)

## Step 2: Add a trigger
Triggers are used to signal a flow to run. In this case you want to receive an HTTP message to update the device shadow. To add a trigger, click on the "+" icon on the left hand side of the screen and select the `Receive HTTP Message` trigger.

![](../../images/labs/aws-iot/step2.png)

The response to the HTTP request will be a message and the HTTP status code, and to be able to send data back you'll need to have **Output** parameters. You can create them by clicking on the grey "Input Output" bar on your screen. From there, select **Output** and configure two parameters:

* Parameter name: code
* Type: integer

Now click on the `+` sign to add a new parameter

* Parameter name: message
* Type: string

Now it is time to configure the trigger to listen to HTTP messages. To start, click on the trigger and a new dialog will open with a bunch of options. In this dialog you'll have to provide:

* Port: The port on which your app will listen
* Method: The HTTP method that will trigger this flow (set this to `GET`)
* Path: The path that will route the messages to this flow (this can be anything, like `/awsiot/status`)

After that, click on "Map to flow outputs" to map the output parameters you created earlier to the response of the trigger. The `code` parameter will already be selected, so click on "123 code" in the Flow Output section to create the mapping. Now click on "message" in the Trigger Response section and select "* data" from the Flow Output section to create the mapping. Click "save" to make sure everything is, well…, saved. You can click the little "X" on the top-right (no, not your browser…) to close the dialog window and go back to the flow. 

## Step 3: Add activities
You’ll have to add some acvitivities to the flow for it to do something. to start, add a `Log Message` activity. To add an activity click on the other large "+" sign

![](../../images/labs/aws-iot/step3.png)

A list with all the activities the Flogo Web UI knows about will appear. From the list you can pick the "Log Message" activity and click it to make sure it is added to the flow. As you hover over the newly added activity, a cog will appear and as you hover over that thing, a menu will appear to configure your activity. Select "message" and type `Received Rest request and starting trigger.` in the input box.

In the same way you just added the Log activity, now add a `Update AWS Device Shadow` activity and configure it in the same way with:

* thing: `flogo_test` (or the name of the device shadow you want to update)
* awsEndpoint: the MQTT endpoint for your device shadow
* desired: A JSON representation of the desired state of your device (for example `{"switch":"on"}`)
* reported: A JSON representation of the current state of your device (for example `{"switch":"off"}`)

This will tell the AWS IoT device shadow to update the reported state into the desired state and as soon as the thing connects to AWS IoT it will receive the new desired state and try to update itself.

Add another `Log Message` activity, but this time with the message `Set Report to off and desired to on`

## Step 4: Return to sender
To complete the app, add a `Return` activity. Hover over it to see the cog and select **configure** to bring up the modal to configure the activity. The return activity is always the last activity in a branch and sets the values that are returned to the trigger. Click on "123 code" and type _200_ in the input field to set the HTTP Response code to 200. Now click on "a.. message" and type `"AWS IOT update successful"` in the input field (the quotes are needed). Finally click "Save" to complete the mapping.

With all the updates, your flow should look something like the one below.

![](../../images/labs/aws-iot/step5.png)

## Step 5: Build
Those were all the steps needed to design the flow, now let's build an executable from it. On the main screen of your flow click on the "<" button on the top-left hand side of the screen. Click on build and select your operating system of choice!

## Step 6: Run
To run the app you'll need to create on the below structure on disk:

```bash
├── <app>                   <-- Your Flogo app 
├── things                  <-- A folder called things 
│   ├── root-CA.pem.crt     <-- The AWS IoT root certificate (you'll have to rename it to 'root-CA.pem.crt')
│   ├── flogo               <-- The name of the thing name (in this case the thing would be called flogo)
│   │   ├── device.pem.crt  <-- The AWS IoT device certificate (you'll have to rename it to 'device.pem.crt')
│   │   ├── device.pem.key  <-- The AWS IoT private key (you'll have to rename it to 'device.pem.key')
```

After you start the app, you can send POST requests to it like `curl --request GET --url http://localhost:9999/awsiot/status --header 'content-type: application/json' --data '{"switch": "on"}'`
