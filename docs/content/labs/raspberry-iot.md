---
title: Raspberry Pi
hidden: true
---

A Raspberry Pi is probably one of the most well-known small single-board computers built to promote the teaching of basic computer science, and increasingly used for cool IoT projects. Flogo runs perfectly on these small devices, and in this lab you'll build a sample to read and write data to the GPIO pins of the device

## What you'll need

### The Flogo Web UI

This demo makes use of the Flogo Web UI. If you don't have that one running yet, please check out [Getting Started with the Flogo Web UI](../../getting-started/getting-started-webui/)

### Devices

You'll definitely want to have a Raspberry Pi, to run the app!

## Step 1: Create the app

Open the Flogo Web UI and from there, click "_New_" to create a new microservice and give your new app a name. Click "_Create a Flow_" to create a new flow and give it any name that you want. Now click on the flow you just created and to open the canvas where you can design your flow.

![step 1](../../images/labs/aws-iot/step1.png)

## Step 2: Add a trigger

Triggers are used to signal a flow to run. In this case you want to receive an HTTP message to turn on or off the lights. To add a trigger, click on the `+` icon on the left hand side of the screen and select the `Receive HTTP Message` trigger.

![step 2](../../images/labs/raspberry-iot/step2.png)

The response to the HTTP request will be a message and the HTTP status code, and to be able to send data back you'll need to have **Output** parameters. You can create them by clicking on the grey "Input Output" bar on your screen. From there, select **Output** and configure two parameters:

* **Parameter name**: code
* **Type**: integer

Now click on the `+` sign to add a new parameter

* **Parameter name**: message
* **Type**: string

Now it is time to configure the trigger to listen to HTTP messages. To start, click on the trigger and a new dialog will open with a bunch of options. In this dialog you'll have to provide:

* **Port**: The port on which your app will listen (set this to `9233`)
* **Method**: The HTTP method that will trigger this flow (set this to `GET`)
* **Path**: The path that will route the messages to this flow (this can be anything, like `/light/status`)

After that, click on "_Map to flow outputs_" to map the output parameters you created earlier to the response of the trigger. The `code` parameter will already be selected, so click on "_123 code_" in the Flow Output section to create the mapping. Now click on "_message_" in the Trigger Response section and select "_* data_" from the Flow Output section to create the mapping. Click "_save_" to make sure everything is, well…, saved. You can click the little `X` on the top-right (no, not your browser…) to close the dialog window and go back to the flow.

## Step 3: Add activities

You’ll have to add some activities to the flow for it to do something. To add an activity click on the other large `+` sign

![step 3a](../../images/labs/raspberry-iot/step3a.png)

A list with all the activities the Flogo Web UI knows about will appear. From the list you can pick the "Log Message" activity (or use the searchbar to find it) and click it to make sure it is added to the flow. As you hover over the newly added activity, a cog will appear and as you hover over that thing, a menu will appear to configure your activity. In this window you can configure the inputs of the "Log Message" activity. Click on "_a.. message_" and type `Received request.` in the box (on the right hand side of the screen).

In the same way you just added the Log activity, now add a `Control GPIO` activity and configure it in the same way with:

* **method**: Direction
* **pinNumber**: 23
* **direction**: Output

This will tell the app you'll want to use pin number 23.

Add another `Control GPIO` activity and configure it in the same way with:

* **method**: Read State
* **pinNumber**: 23

This will tell the app you want to know the output state of pin number 23.

Your flow should look something like the one below.

![step 3b](../../images/labs/raspberry-iot/step5.png)

## Step 4: Adding a branch

To be able to switch from on to off and vice versa, you'll need to create two branches. One that turns off the light if it was on and one that does the opposite. You'll start by creating the "_Turn it on_" branch.

As you hover over the activity, a cog will appear and as you hover over that thing, a menu will appear to create a branch from your activity.

Click anywhere on the branch to be able to set a condition. The condition is a JavaScript-like syntax `$activity[gpio_4].result==0`. You can create the condition by simply typing it into the textbox. Where it says `gpio_4` in the condition, you might need to change that to match the ID of the activity you added last (it will have the name "_Control GPIO(2)_").

Add a new `Log Message` activity (click on the `+` right behind the created branch) and as you hover over the newly added activity, a cog will appear and as you hover over that thing, a menu will appear to configure your activity. In the modal that now appears, select "_a.. message_" to tell the app what the message is that will be logged. Now click on the caret next to the second GPIO activity to expand it and click "_123 result_" to tell the app to map the result from that activity to the message that will be logged.

![step 4a](../../images/labs/raspberry-iot/step4a.png)

Add another `Control GPIO` activity (_yes, a lot of GPIO activities are used in this flow..._) and configure it in the same way you did with the previous activities, but with the values:

* **method**: Set State
* **pinNumber**: 23
* **state**: high

To complete the branch, add a `Return` activity. Hover over it to see the cog and select **configure** to bring up the modal to configure the activity. The return activity is always the last activity in a branch and sets the values that are returned to the trigger. Click on "_123 code_" and type _200_ in the input field to set the HTTP Response code to 200.

![step 4b](../../images/labs/raspberry-iot/step4b.png)

Now click on "_a.. message_" and type _"Updated light to high successfully"_ (the quotes are needed). Finally click "_Save_" to complete the mapping.

With all the updates, your flow should look something like the one below.

![step 4c](../../images/labs/raspberry-iot-demo/step4c.png)

## Step 5: Adding another branch

To create the second branch, the "_Turn it off_" branch, select the activity from which you created the first branch. Create a branch in the same way, by hovering over the activity first. As you hover over the activity, a cog will appear and as you hover over that thing, a menu will appear to create a branch from your activity.

Click anywhere on the branch to be able to set a condition. This time, set the condition to `$activity[gpio_4].result==1`. Where it says `gpio_4` in the condition, you might need to change that to match the ID of the activity you added last (it will have the name "_Control GPIO(2)_").

Add a new `Log Message` activity (click on the `+` right behind the newly created branch) and as you hover over the newly added activity, a cog will appear and as you hover over that thing, a menu will appear to configure your activity. In the modal that now appears, select "_a.. message_" to tell the app what the message is that will be logged. Now click on the caret next to the second GPIO activity to expand it and click "_123 result_" to tell the app to map the result from that activity to the message that will be logged.

Add a `Control GPIO` activity (_we promise, this is the last GPIO activity..._) and configure it in the same way you did with the previous activities, but with the values:

* **method**: Set State
* **pinNumber**: 23
* **state**: low

This branch should be completed with a `Return` activity as well. Hover over it to see the cog and select **configure** to bring up the modal to configure the activity. Click on "_123 code_" and type _200_ in the input field to set the HTTP Response code to 200 and this time set the field "_a.. message_" to _"Updated light to low successfully"_ (the quotes are needed). Finally click "Save" to complete the mapping.

With all the updates, your final flow should look something like the one below.

![step 5](../../images/labs/raspberry-iot-demo/step5.png)

## Step 6: Build

Those were all the steps needed to design the flow, now let's build an executable from it. On the main screen of your flow click on the `<` button on the top-left hand side of the screen. That will bring you back to your microservice and from here you can select "Build" and choose `linux/arm` to make sure it is capable of running on a Raspberry Pi.

## Step 7: Run

To run your app copy it to your Raspberry Pi and run `curl --request GET --url http://localhost:9233/lights/status` (or replace `localhost` with the IP address of your device)