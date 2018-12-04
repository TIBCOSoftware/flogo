---
title: Labs
weight: 2500
chapter: true
pre: "<i class=\"fas fa-flask\" aria-hidden=\"true\"></i> "
---

# Labs

After getting up and running you might want to try your hand at some more advanced labs and tutorials. These labs provide you with a guides, tutorials and code samples and will help you work through building and deploying Flogo apps. The labs cover a wide range of topics like deploying to Kubernetes, using Flogo with the Serverless Framework and a bunch more! The colors of the cards have a meaning:

## Flogo CLI

These labs have an emphasis on using the [Flogo CLI](../getting-started/getting-started-cli) to build apps

<div class="cards">

  {{< bigcard img="../images/labs/047-safety-glasses.svg" headercolor="bg3" title="Flogo CLI" text="Project Flogo provides two different command-line interfaces and which you need depends on the task you need to execute. This tutorial covers the 'flogo' command" href="./flogo-cli">}}

  {{< bigcard img="../images/labs/047-safety-glasses.svg" headercolor="bg3" title="AWS Lambda" text="Flogo has first class support for AWS Lambda. This tutorial covers building Lambda apps using the Flogo CLI" href="./flogo-lambda">}}

  {{< bigcard img="../images/labs/047-safety-glasses.svg" headercolor="bg3" title="Building activities" text="Building new activities to extend the capabilities of Project Flogo is definitely not the most difficult thing on the planet. In fact, it's rather easy to get you started!" href="./building-activities">}}

  {{< bigcard img="../images/labs/047-safety-glasses.svg" headercolor="bg3" title="Building triggers" text="Triggers make it possible for Flogo to get data. How do you get started building a trigger, though? Check this tutorial to build a simple trigger." href="./building-triggers">}}

  {{< bigcard img="../images/labs/047-safety-glasses.svg" headercolor="bg3" title="Build using Go" text="Cheesecakes are important! In fact, we believe perhaps the most important thing, right after Flogo. In this tutorial you'll build a cheesecake service using the Go API." href="./cheesecake-service">}}

  {{< bigcard img="../images/labs/047-safety-glasses.svg" headercolor="bg3" title="Streams: Aggregate" text="Learn how to use the JSON DSL to build streaming pipelines using the power of Flogo." href="./streams-aggregate">}}

  {{< bigcard img="../images/labs/047-safety-glasses.svg" headercolor="bg3" title="Streams: Filter" text="Learn how to use the JSON DSL to build a simple streaming pipelines, using the power of Flogo, that filters out all zeros." href="./streams-filter">}}

</div>

## Flogo Web UI

These labs have an emphasis on using the [Flogo Web UI](../getting-started/getting-started-webui) to build apps

<div class="cards">

  {{< bigcard img="../images/labs/009-scientific.svg" headercolor="bg1" title="Timers" text="Timers are great to schedule stuff, and a great way to learn new technology! Use this lab to get familiar with some of the concepts of Flogo!" href="./timers">}}

  {{< bigcard img="../images/labs/009-scientific.svg" headercolor="bg1" title="Hello World" text="Hello World! This lab will walk you through building your first API with Project Flogo" href="./helloworld">}}

  {{< bigcard img="../images/labs/009-scientific.svg" headercolor="bg1" title="Bookstore" text="Who doesn't like a good book? But what if you really need to get some information about a book first? In that case you build a Flogo app that uses Google APIs to that!" href="./bookstore">}}

  {{< bigcard img="../images/labs/009-scientific.svg" headercolor="bg1" title="Raspberry Pi" text="Flogo runs perfectly on these small devices, and in this lab you'll build a sample to read and write data to the GPIO pins of the device to control your home lights!" href="./raspberry-iot">}}

  {{< bigcard img="../images/labs/009-scientific.svg" headercolor="bg1" title="AWS IoT" text="A device shadow is a digital representation in the cloud that stores and retrieves current state information for a device using AWS IoT." href="./aws-iot">}}

  {{< bigcard img="../images/labs/009-scientific.svg" headercolor="bg1" title="Invoice Service" text="Let's build an invoiceservice! In this tutorial we'll walk you through building an app with several community-driven activities and talks to other services as well." href="./invoiceservice">}}

  {{< bigcard img="../images/labs/009-scientific.svg" headercolor="bg1" title="Payment Service" text="Who doesn't want to know when payments are coming in? This service generates a payment date that can be used by the invoiceservice or standalone." href="./paymentservice">}}

</div>

## External tools

These labs have an emphasis on using external tools together with Project Flogo, like Kubernetes or the Serverless Framework

<div class="cards">

  {{< bigcard img="../images/labs/034-experiment.svg" headercolor="bg2" title="Kubernetes" text="Kubernetes is probably the most wellknown container orchestration platform out there. In this demo you explore how to run Flogo apps on Kubernetes." href="./kubernetes">}}

  {{< bigcard img="../images/labs/034-experiment.svg" headercolor="bg2" title="Docker" text="Flogo apps are ultralight, so building docker images is not only really easy, because it can embed all dependencies it can also run inside of super small containers." href="./docker">}}

  {{< bigcard img="../images/labs/034-experiment.svg" headercolor="bg2" title="Cloud Foundry" text="Cloud Foundry is an open-source platform as a service (PaaS) that provides you with a choice of clouds, developer frameworks, and application services (like Flogo!)." href="./cloudfoundry">}}

  {{< bigcard img="../images/labs/034-experiment.svg" headercolor="bg2" title="Serverless Framework" text="Developers never have to worry about provisioning or maintaining servers, and only have to create the code that they need to power their next business idea!" href="./serverless">}}

  {{< bigcard img="../images/labs/034-experiment.svg" headercolor="bg2" title="PubNub" text="Secure comms with PubNub: Building microservices is cool, having them talk to each other is awesome! But in today's world, you can't be too careful when it comes to your data." href="./pubnub">}}

  {{< bigcard img="../images/labs/034-experiment.svg" headercolor="bg2" title="IoT apps" text="Flogo can run almost anywhere. Take this lab to get yourself familiar with how to develop IoT apps using the Flogo CLI." href="./iot-howto">}}

  {{< bigcard img="../images/labs/034-experiment.svg" headercolor="bg2" title="BeagleBone" text="Deploying apps to a BeagleBone" href="./beaglebone-iot">}}

  {{< bigcard img="../images/labs/034-experiment.svg" headercolor="bg2" title="Intel Edison" text="Deploying apps to an Edison" href="./edison-iot">}}

  {{< bigcard img="../images/labs/034-experiment.svg" headercolor="bg2" title="Raspberry Pi (IoT)" text="Deploying apps to a Raspberry Pi" href="./raspberry-iot-cli">}}

  {{< bigcard img="../images/labs/034-experiment.svg" headercolor="bg2" title="CI/CD for Activities" text="A CI/CD pipeline is really important for proper a proper test and build cycle. This tutorial walks you through how to do that with Jenkins and Travis for Flogo activities." href="./cicd-for-activities">}}

  {{< bigcard img="../images/labs/034-experiment.svg" headercolor="bg2" title="AWS SAM" text="SAM provides a model to build Serverless apps for AWS. It also provides an easy way of testing your apps without deploying to AWS Lambda all the time..." href="./flogo-and-sam">}}

</div>
