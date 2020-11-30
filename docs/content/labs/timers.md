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

To create a new app, open the Flogo Web UI and from there, click "_New_" to create a new microservice and give your new app a name. Click "_Create an Action_" and select "_Flow_" to create a new flow and give it any name that you want. Now click on the flow you just created and to open the canvas where you can design your flow.

![step 1](../../images/labs/timers/step1.png)

## Step 2: Add a trigger

Flogo is an event-driven framework. A trigger is the entrypoint for events to, as the name implies, trigger the functionality of your app. A trigger can be a subscriber on an MQTT topic, Kafka topic, HTTP REST interface or a specific IoT sensor. The trigger is responsible for accepting the incoming event and invoking one or more defined actions (flows).

In this case you want to start with a `Timer`. To add a trigger, click on the "+" icon on the left hand side of the screen and select the `Timer` trigger.

![step 2](../../images/labs/timers/step2.png)

Now it is time to configure the trigger. To start, click on the trigger and a new dialog will open with a bunch of options. In this dialog you'll have to provide:

* **startDelay**: The start delay (ex. 1s, 1m, 1h, 1h30m etc.), immediate if not specified
* **repeatInterval**: The repeat interval (ex. 1m, 1h, etc.), doesn't repeat if not specified

Click "_save_" to make sure everything is, well…, saved. You can click the little `X` on the top-right (no, not your browser…) to close the dialog window and go back to the flow.

## Step 3: Add activities

An activity is the unit of work that can be leveraged within a Flow. An activity can be any number of things and can be compared to a simple function in Go or any other procedural language, that is, an activity accepts input params and will return one or more objects on return, both input & output params are defined by the activity metadata. You’ll have to add some activities to the flow for it to do something. To add an activity click on the large `+` sign

![step 3a](../../images/labs/timers/step3a.png)

A list with all the activities the Flogo Web UI knows about will appear. From the list you can pick the "Log Message" activity (or use the searchbar to find it) and click it to make sure it is added to the flow. As you hover over the newly added activity, a ellipsis (...) will appear, click this and a menu will appear with options to configure or delete your activity. Click the gear icon to configure your activity. In this window you can configure the inputs of the "Log Message" activity. Click on "_a.. message_" and type `Hello World` in the box (on the right hand side of the screen).

![step 3b](../../images/labs/timers/step3b.png)

With all the updates, your flow should look something like the one below.

![step 3c](../../images/labs/timers/step3c.png)

## Step 4: Build

Those were all the steps needed to design the flow, now let's build an executable from it. On the main screen of your flow click on the `<` button on the top-left hand side of the screen. Click on build and select your operating system of choice! Flogo will compile a statically linked binary, meaning that there are no other dependencies that the executable you're getting from the Flogo Web UI. No libraries to install, no frameworks to maintain or upgrade, just that one single binary that takes care of your flows.

## Step 5: Run

To run the app double-click it (on Windows), or open a terminal and execute:

```bash
2019-07-25T07:46:46.224-0600	INFO	[flogo.engine] -	Starting app [ app-build ] with version [ 0.0.1 ]
2019-07-25T07:46:46.224-0600	INFO	[flogo.engine] -	Engine Starting...
2019-07-25T07:46:46.224-0600	INFO	[flogo.engine] -	Starting Services...
2019-07-25T07:46:46.224-0600	INFO	[flogo] -	ActionRunner Service: Started
2019-07-25T07:46:46.224-0600	INFO	[flogo.engine] -	Started Services
2019-07-25T07:46:46.224-0600	INFO	[flogo.engine] -	Starting Application...
2019-07-25T07:46:46.224-0600	INFO	[flogo] -	Starting Triggers...
2019-07-25T07:46:46.224-0600	INFO	[flogo.trigger.timer] -	Scheduling a repeating timer
2019-07-25T07:46:46.224-0600	INFO	[flogo] -	Trigger [ timer ]: Started
2019-07-25T07:46:46.224-0600	INFO	[flogo] -	Triggers Started
2019-07-25T07:46:46.224-0600	INFO	[flogo.engine] -	Application Started
2019-07-25T07:46:46.224-0600	INFO	[flogo.engine] -	Engine Started
2019-07-25T07:46:46.225-0600	INFO	[flogo.activity.log] -	Hello World
2019-07-25T07:46:46.225-0600	INFO	[flogo.flow] -	Instance [19ffa126322448d04fee092d29a7ce7b] Done
2019-07-25T07:46:51.227-0600	INFO	[flogo.activity.log] -	Hello World
2019-07-25T07:46:51.227-0600	INFO	[flogo.flow] -	Instance [1affa126322448d04fee092d29a7ce7b] Done
```

Every 5 seconds a new entry will appear in the log.
