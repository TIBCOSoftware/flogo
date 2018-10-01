---
title: "My First App: Timers"
hidden: true
---

Timers are great to schedule stuff, and a great way to learn new technology! Use this lab to get familiar with some of the concepts of Flogo!

## What you'll need

### The Flogo Web UI

This demo makes use of the Flogo Web UI. To make it easy to get started the Flogo Web UI is packaged up as a docker image which you can get from docker hub. If you don't have that one running yet, please check out [Getting Started with the Flogo Web UI](../../getting-started/getting-started-webui/). The Flogo Web UI contains everything you'll need to build your Flogo apps, without ever writing code.

## Step 1: Create the app

In Flogo terminology, an app is comprised of one or more triggers and flows (actions). The app itself is really just an organizational mechanism that can be leveraged when developing microservices & functions. An app contains a set of configurations, as well as triggers and a collection of flows.

To create a new app, open the Flogo Web UI and from there, click "_New_" to create a new microservice and give your new app a name. Click "_Create a Flow_" to create a new flow and give it any name that you want. Now click on the flow you just created and to open the canvas where you can design your flow.

![step 1](../../images/labs/timers/step1.png)

## Step 2: Add a trigger

Flogo is an event-driven framework. A trigger is the entrypoint for events to, as the name implies, trigger the functionality of your app. A trigger can be a subscriber on an MQTT topic, Kafka topic, HTTP REST interface or a specific IoT sensor. The trigger is responsible for accepting the incoming event and invoking one or more defined actions (flows).

In this case you want to start with a `Timer`. To add a trigger, click on the "+" icon on the left hand side of the screen and select the `Timer` trigger.

![step 2](../../images/labs/timers/step2.png)

Now it is time to configure the trigger. To start, click on the trigger and a new dialog will open with a bunch of options. In this dialog you'll have to provide:

* **repeating**: This tells the trigger wheter it should stop after executing once, or repeat itself after a certain interval (set this to `true`)
* **notImmediate**: This tells the trigger to wait until tehe first interval is done or start right away (set this to `false`)
* **startDate**: You can specify what the start date is for the trigger to become active, for example if you want to deploy the app and want it to start in a few hours (keep this at `2018-01-01T12:00:00Z00:00`)
* **hours**: This will tell the trigger how many hours to wait between runs (keep this field empty)
* **minutes**: This will tell the trigger how many minutes to wait between runs (keep this field empty)
* **seconds**: This will tell the trigger how many seconds to wait between runs (set this to `5`, to start a new flow every 5 seconds)

Click "_save_" to make sure everything is, well…, saved. You can click the little `X` on the top-right (no, not your browser…) to close the dialog window and go back to the flow.

## Step 3: Add activities

An activity is the unit of work that can be leveraged within a Flow. An activity can be any number of things and can be compared to a simple function in Go or any other procedural language, that is, an activity accepts input params and will return one or more objects on return, both input & output params are defined by the activity metadata. You’ll have to add some acvitivities to the flow for it to do something. To add an activity click on the large `+` sign

![step 3a](../../images/labs/timers/step3a.png)

A list with all the activities the Flogo Web UI knows about will appear. From the list you can pick the "Log Message" activity (or use the searchbar to find it) and click it to make sure it is added to the flow. As you hover over the newly added activity, a cog will appear and as you hover over that thing, a menu will appear to configure your activity. In this window you can configure the inputs of the "Log Message" activity. Click on "_a.. message_" and type `Hello World` in the box (on the right hand side of the screen).

![step 3b](../../images/labs/timers/step3b.png)

With all the updates, your flow should look something like the one below.

![step 3c](../../images/labs/timers/step3c.png)

## Step 4: Build

Those were all the steps needed to design the flow, now let's build an executable from it. On the main screen of your flow click on the `<` button on the top-left hand side of the screen. Click on build and select your operating system of choice! Flogo will compile a statically linked binary, meaning that there are no other dependencies that the executable you're getting from the Flogo Web UI. No libraries to install, no frameworks to maintain or upgrade, just that one single binary that takes care of your flows.

## Step 5: Run

To run the app double-click it (on Windows), or open a terminal and execute:

```bash
2018-09-26 14:03:31.917 INFO   [engine] - Engine Starting...
2018-09-26 14:03:31.917 INFO   [engine] - Starting Services...
2018-09-26 14:03:31.917 INFO   [engine] - Started Services
2018-09-26 14:03:31.917 INFO   [engine] - Starting Triggers...
2018-09-26 14:03:31.917 INFO   [trigger-flogo-timer] - Scheduling a repeating job
2018-09-26 14:03:31.917 INFO   [engine] - Trigger [ timer ]: Started
2018-09-26 14:03:31.917 INFO   [engine] - Triggers Started
2018-09-26 14:03:31.917 INFO   [engine] - Engine Started
2018-09-26 14:03:31.917 INFO   [engine] - Running FlowAction for URI: 'res://flow:timers'
2018-09-26 14:03:31.918 INFO   [activity-flogo-log] - Hello World...
2018-09-26 14:03:31.918 INFO   [engine] - Flow instance [db4cb555d16b2c2189f1a2b217379b66] Completed Successfully
2018-09-26 14:03:36.919 INFO   [engine] - Running FlowAction for URI: 'res://flow:timers'
2018-09-26 14:03:36.919 INFO   [activity-flogo-log] - Hello World...
2018-09-26 14:03:36.919 INFO   [engine] - Flow instance [d84cb555d16b2c2189f1a2b217379b66] Completed Successfully
```

Every 5 seconds a new entry will appear in the log.
