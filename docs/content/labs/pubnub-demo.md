---
title: Tutorial for PubNub
weight: 2510
---

Building microservices is awesome, having them talk to each other is even more awesome! But in today's world, you can't be too careful when it comes to sending sensitive data across the wire. In this demo you explore how to build a simple microservice to receive the messages from PubNub and write that data to a file.

## What you'll need
### The Flogo Web UI
This demo makes use of the Flogo Web UI. If you don't have that one running yet, please check out [Getting Started with the Flogo Web UI](https://tibcosoftware.github.io/flogo/getting-started/getting-started-webui/)

### A PubNub account
In order to work with PubNub, you'll really need a PubNub account. Luckily, registration is very easy. Go to https://dashboard.pubnub.com/login and use "SIGN UP" to create a new account. 

## Step 1: Create an app in PubNub
After signing up, use the big red button to create a new app (the name doesn't matter, and if you want you can change it later too). Now click on the newly created app and you'll see a new KeySet. The Publish and Subscriber key are quite important as they make sure you can connect to your PubNub account. 

![](../../images/labs/pubnub-demo/step1.png)

## Step 2: Create an an in the Flogo Web UI
Open the Flogo Web UI and from there, click "New" to create a new microservice and give your new app a name. Click "Create a Flow" to create a new flow and give it any name that you want. Now click on the flow you just created and to open the canvas where you can design your flow. 

![](../../images/labs/pubnub-demo/step2.png)

## Step 3: Import a new trigger
Out of the box, Flogo doesn't come with a trigger for PubNub so using the awesome [SDK](https://www.pubnub.com/docs/go/pubnub-go-sdk) provided by the PubNub team we've built one for you! To install that into your Web UI, click on the "+" icon on the left hand side of the screen.

![](../../images/labs/pubnub-demo/step3.png)

From there click on "Install new" and paste "https://github.com/retgits/flogo-components/trigger/pubnubsubscriber" into the input dialog to get this new trigger. After the installation is completed, you can click on "Receive PubNub messages" to add the trigger to your app.

## Step 4: Configuration
The thing we want to store in a file is the message coming from PubNub. To do so, you'll need to create an Input parameter which you can do by clicking on the grey "Input Output" bar on your screen. For example, you can call the parameter "pubnubmessage", keep the type as "string" and click save.

Now it is time to configure the trigger to listen to messages coming from PubNub. To start, click on the trigger and a new dialog will open with a bunch of options. In this dialog you'll have to provide:

* publishKey: The key from PubNub (usually starts with pub-c)
* subscribeKey: The key from PubNub (usually starts with sub-c)
* channel: The channel on which messages will come (totally up to you to choose this)

After that, click on "Map to flow inputs" to map the message from PubNub to the "pubnubmessage" parameter we created earlier. The parameter will already be selected because it is the only one, so the only task left is to click "* message" in the Trigger Output section and "save" to make sure everything is, well…, saved. You can click the little "X" on the top-right (no, not your browser…) to close the dialog window and go back to the flow. 

## Step 5: Adding activities
You’ll have to add some acvitivities to the flow for it to do something. In this demo you'll add two activities to the flow. The first activity will log the message and the second one will store the data in a file. To add an activity click on the other large "+" sign

![](../../images/labs/pubnub-demo/step5.png)

On the right-hand side of the screen a list with all the activities the Flogo Web UI knows about will appear. From the list you can pick the "Log Message" activity and click it to make sure it is added to the flow. As you hover over the newly added activity, a cog will appear and as you hover over that thing, a menu will appear to configure your activity. In this window you can configure the inputs of the "Log Message" activity using data from all other activities and triggers in your flow. Right now, we have only the incoming data from PubNub so select "message" in the "Activity Inputs" section and expand the "flow (flow)" section (by clicking on the little black caret) to be able to select the "pubnubmessage". 

![](../../images/labs/pubnub-demo/step5a.png)

Now hit the "save" button and we're done with this part!

Now we need to add a new activity to the Flogo Web UI to make sure you can add things to a file. On the main screen of your flow click "Install new activity" to get the same dialog as when installing the trigger. 

![](../../images/labs/pubnub-demo/step5b.png)

In the dialog window you can paste "https://github.com/retgits/flogo-components/activity/writetofile". Once the activity is installed you can select it from the list to add it to your flow. Again, hover over the newly added activity and expand the menu to configure your activity. For this activity you'll have to configure all the parameters:

* Append: Should the content be appended to the file or not? In this case we want to, so type "true" in the box
* Content: The content we want to add to the file. In this case it is the message from PubNub again, so expand the "flow (flow)" section (by clicking on the little black caret) and select the "pubnubmessage"
* Create: Should the file be created if it doesn't exist? Well, yes, in this case that is probably a good idea so type "true" in the box
* Filename: The name of the file you want to write the data to. In this case you can call the file whatever you want, like "visitors.txt" (please be sure to add the double quotes as you type in the box)

Click "save" to save the data and return to the main screen of your flow. The completed flow will look like

![](../../images/labs/pubnub-demo/step5c.png)

## Step 6: Build
Those were all the steps needed to design the flow, now let's build an executable from it. On the main screen of your flow click on the "<" button on the top-left hand side of the screen. That will bring you back to your microservice and from here you can select "Build" and choose your operating system of choice. That will tell the Flogo Web UI to go build your microservice and give you a tiny executable in return (about 12mb).

## Step 7: Test
You can run your microservice by either double-clicking it (on Windows) or using a terminal window to run your app (macOS or Linux).  If the app started successfully it will give you a message like:
`2018-08-06 21:20:02.867 INFO   [engine] - Received status [pubnub.PNConnectedCategory], this is expected for a subscribe, this means there is no error or issue whatsoever`

To test the microservice you can use the PubNub debug console. 

![](../../images/labs/pubnub-demo/step7.png)

In the "Default Channel" you'll have to type the same channel name as you configured in your Flogo app (MyChannel, in this example). You can click "ADD CLIENT" to create a new client which will be able to send and receive data. The cool thing that PubNub offers, is that you don't have to open any firewall ports to have the debug console and the microservice talk to each other. At the bottom of the page it will now say "{"text":"Enter Message Here"}", which is the message that you can send to your microservice. Either hit "SEND" or perhaps replace the default message with something like "{"Hello":"World"}". After you click "SEND" the exact message will appear in the window where your microservice is running

![](../../images/labs/pubnub-demo/step7a.png)

And in the log file that was created in the same location as your app

![](../../images/labs/pubnub-demo/step7b.png)