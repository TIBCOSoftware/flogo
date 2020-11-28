---
title: Invoice Service
hidden: true
---

Let's build an invoiceservice! In this tutorial we'll walk you through building an app with several community-driven activities and talks to other services as well. The lab also covers Input/Output mappings, Invoking a REST service and Complex object mapping.

## What you'll need

### The Flogo Web UI

This demo makes use of the Flogo Web UI. If you don't have that one running yet, please check out [Getting Started with the Flogo Web UI](../../getting-started/getting-started-webui/)

### Apps

This demo builds one of the services of the [Kubernetes](../kubernetes) tutorial. After building this app, you might want to try and deploy it to Kubernetes too! The app will use the [Payment Service](../paymentservice) to get some data, so you'll likely want to start with that one if you haven't built it yet.

### Need help

If you have any questions, feel free to post an [issue on GitHub](https://github.com/TIBCOSoftware/flogo/issues) and tag it as a question or chat with the team and community:

* The [project-flogo/Lobby](https://gitter.im/project-flogo/Lobby) Start here for all things Flogo!
* The [project-flogo/developers](https://gitter.im/project-flogo/developers) Developer/contributor focused conversations.

## Step 1: Create the app

Open the Flogo Web UI and from there, click "_New_" to create a new microservice and give your new app a name. Click "_Create a Flow_" to create a new flow and give it any name that you want. Now click on the flow you just created and to open the canvas where you can design your flow.

![step 1](../../images/labs/invoiceservice/step1.png)

## Step 2: Add a trigger

Triggers are used to signal a flow to run. In this case you want to receive an HTTP message to get invoice information. To add a trigger, click on the "+" icon on the left hand side of the screen and select the `Receive HTTP Message` trigger.

![step 2](../../images/labs/invoiceservice/step2.png)

The invoice ID for which you want the information comes from the HTTP request. To get that parameter into the flow, you'll need to create an Input parameter which you can do by clicking on the grey "_Input Output_" bar on your screen. For example, you can call the parameter "_id_", keep the type as "_string_" and click save.

The response to the HTTP request will be a message and the HTTP status code, and to be able to send data back you'll need to have **Output** parameters. You can create them by clicking on the grey "Input Output" bar on your screen. From there, select **Output** and configure two parameters:

* **Parameter name**: code
* **Type**: integer

Now click on the `+` sign to add a new parameter

* **Parameter name**: response
* **Type**: any

Now it is time to configure the trigger to listen to HTTP messages. To start, click on the trigger and a new dialog will open with a bunch of options. In this dialog you'll have to provide:

* **Port**: The port on which your app will listen (set this to `9234`)
* **Method**: The HTTP method that will trigger this flow (set this to `GET`)
* **Path**: The path that will route the messages to this flow (set this to `/api/invoices/:id`, the `:id` means that you can use that as a path parameter in your mappings)

After that, click on "_Map to flow inputs_" to map the invoiceId from the HTTP trigger to the "_id_" parameter we created earlier. The parameter will already be selected because it is the only one. Since the data will come from the PATH parameters, you'll need to type `$.pathParams.id` in the input box, which means the Flogo app will expect a PATH parameter called invoiceId to be present.

With the inputs taken care off, let's look at the outputs. Click on "_Map to flow outputs_" to map the output parameters you created earlier to the response of the trigger. The `code` parameter will already be selected, so click on "_123 code_" in the Flow Output section to create the mapping. Now click on "_response_" in the Trigger Response section and select "_* data_" from the Flow Output section to create the mapping. Click "_save_" to make sure everything is, well…, saved. You can click the little `X` on the top-right (no, not your browser…) to close the dialog window and go back to the flow.

{{% notice tip %}}
The URL on which our microservice will listen will be `http://localhost:9234/api/invoices/:id` (the _:invoiceId_ is a parameter that you can replace with anything during runtime). If you made changes to any of the variables above, please make sure to change those in the rest of these examples.
{{% /notice %}}

## Step 3: Add activities

You’ll have to add some activities to the flow for it to do something. To add an activity click on the large `+` sign

![step 3a](../../images/labs/invoiceservice/step3a.png)

A list with all the activities the Flogo Web UI knows about will appear. From the list you can pick the "Log Message" activity (or use the searchbar to find it) and click it to make sure it is added to the flow. As you hover over the newly added activity, a cog will appear and as you hover over that thing, a menu will appear to configure your activity. In this window you can configure the inputs of the "Log Message" activity. Click on "_a.. message_" and type `string.concat("Get Invoice request received for: ", $flow.id)` in the box (on the right hand side of the screen). This will, when you run the app, concatenate a string and the id.

In the same way, add a new activity. The activity that is needed, to generate a random number, isn't part of the out-of-the-box activities so you'll need to import it.  

![step 3b](../../images/labs/invoiceservice/step3b.png)

Click "Install new activity" and a dialog appears where you can paste (or type) the URL of where the Flogo Web UI can get the sources. For this activity you can use <https://github.com/retgits/flogo-components/activity/randomnumber>. From the updated list you can pick the "Random number" activity (or use the searchbar to find it) and click it to make sure it is added to the flow. As you hover over the newly added activity, a cog will appear and as you hover over that thing, a menu will appear to configure your activity. In this window you can configure the inputs of the "Random number" activity.

* **max**: `2000` (the maximum value the random number will have)
* **min**: `1000` (the minimum value the random number will have)

In the same way, add a new activity and this time install the "Combine" activity to concatenate multiple values. The URL you'll need to use to install the activity is <https://github.com/jvanderl/flogo-components/activity/combine>.

![step 3b](../../images/labs/paymentservice/step3b.png)

* **delimeter**: `"-"` (the delimeter used to separate the strings)
* **part1**: `"INV"` (a hardcoded string)
* **part2**: `$flow.id` (the id that was passed in as a PATH parameter)

Add another "Random number" activity to the flow, in the same way you've done before. This time you won't need to install it, because the Flogo Web UI already knows about it. As you hover over the newly added activity, a cog will appear and as you hover over that thing, a menu will appear to configure your activity. In this window you can configure the inputs of the "Random number" activity.

* **max**: `1000` (the maximum value the random number will have)
* **min**: `0` (the minimum value the random number will have)

The next step is to add a "_Invoke REST Service_" activity, which will call the [Payment Service](../paymentservice) to get some data. You can add the activity in the same way you've done before. As you hover over the newly added activity, a cog will appear and as you hover over that thing, a menu will appear to configure your activity. In this window you can configure the inputs:

* **content**: `<empty>` (the content you want to send to the REST service, in this case the service doesn't need any so you can keep this field empty)
* **header**: `<empty>` (any header parameters you want to send to the REST service, in this case the service doesn't need any so you can keep this field empty)
* **method**: `"GET"` (the HTTP method to call the other service)
* **pathParams**: `{"id":"{{$flow.id}}"}` (this will add a PATH parameter with the value of the id that was passed into this flow)
* **proxy**: `<empty>` (HTTP proxy settings you need to call the other service you can keep this field empty)
* **queryParams**: `<empty>` (any query parameters you want to send to the REST service, in this case the service doesn't need any so you can keep this field empty)
* **skipSsl**: `"false"` (This setting indicates if, when HTTPS is used, the certificate check should be skipped or not)
* **uri**: `http://localhost:9233/api/expected-date/:id` (This is the URL, including any PATH parameters used, to call the other service. In this case the [Payment Service](../paymentservice))

## Step 4: Return data

To complete the flow, add a `Return` activity. Hover over it to see the cog and select **configure** to bring up the modal to configure the activity. The return activity is always the last activity in a branch and sets the values that are returned to the trigger. Click on "_123 code_" and type _200_ in the input field to set the HTTP Response code to 200.

Now click on "* message" and type (or copy) the structure below. Finally click "Save" to complete the mapping.

```json
{
    "id":"{{$flow.id}}",
    "ref":"{{$activity[combine_4].result}}",
    "amount":"{{$activity[randomnumber_3].result}}",
    "balance":"{{$activity[randomnumber_5].result}}",
    "expectedPaymentDate":"{{$activity[rest_6].result.expectedDate}}",
    "currency":"USD"
}
```

The above snippet maps the values from the REST service to fields that are sent back to the trigger. The mapping is done in a JavaScript-like syntax, so `$flow.id` means it will get the id that was used as an input parameter to the flow (the one you configured earlier) and the `$activity[xxx].result` will get the result elements from the various activities. The double curly braces are used as by Go's templating engine.

Your final flow should look something like the one below.

![step 4](../../images/labs/invoiceservice/step4.png)

## Step 5: Build

Those were all the steps needed to design the flow, now let's build an executable from it. On the main screen of your flow click on the "<" button on the top-left hand side of the screen. That will bring you back to your microservice and from here you can select "Build". Choose whichever operating system you're running on to download the executable.

## Step 6: Run

To see the results, start both apps and run `curl --request GET --url http://localhost:9234/api/invoices/12345`. That will give you a result like

```json
{"amount":1456,"balance":456,"currency":"USD","expectedPaymentDate":"2018-02-28","id":"2345","ref":"INV-2345"}
```
