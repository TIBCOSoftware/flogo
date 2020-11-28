---
title: Bookstore
hidden: true
---

Who doesn't like a good book? But what if you really, really need to get some information about a book first? In that case you build a Flogo app that uses the Google APIs to get book information!

## What you'll need

### The Flogo Web UI

This demo makes use of the Flogo Web UI. If you don't have that one running yet, please check out [Getting Started with the Flogo Web UI](../../getting-started/getting-started-webui/)

## Step 1: Create the app

Open the Flogo Web UI and from there, click "_New_" to create a new microservice and give your new app a name. Click "_Create a Flow_" to create a new flow and give it any name that you want. Now click on the flow you just created and to open the canvas where you can design your flow.

![step 1](../../images/labs/bookstore/step1.png)

## Step 2: Add a trigger

Triggers are used to signal a flow to run. In this case you want to receive an HTTP message to update the device shadow. To add a trigger, click on the "+" icon on the left hand side of the screen and select the `Receive HTTP Message` trigger.

![step 2](../../images/labs/bookstore/step2.png)

The thing you need to send to the Google Books API is the isbn coming from the HTTP request. To do so, you'll need to create an Input parameter which you can do by clicking on the grey "_Input Output_" bar on your screen. For example, you can call the parameter "_isbn_", keep the type as "_string_" and click save.

The response to the HTTP request will be a message and the HTTP status code, and to be able to send data back you'll need to have **Output** parameters. From the screen where you are now, select **Output** and configure two parameters:

* **Parameter name**: code
* **Type**: integer

Now click on the `+` sign to add a new parameter

* **Parameter name**: message
* **Type**: any

Now it is time to configure the trigger to listen to HTTP messages. To start, click on the trigger and a new dialog will open with a bunch of options. In this dialog you'll have to provide:

* **Port**: The port on which your app will listen (set this to `9233`)
* **Method**: The HTTP method that will trigger this flow (set this to `GET`)
* **Path**: The path that will route the messages to this flow (set this to `/books/:isbn`, the `:isbn` means that you can use that as a path parameter in your mappings).

After that, click on "_Map to flow inputs_" to map the isbn from the HTTP trigger to the "_isbn_" parameter we created earlier. The parameter will already be selected because it is the only one. You'll need to concatenate `isbn:` with the actual number so you'll need to type (or paste) the following `string.concat("isbn:", $.pathParams.isbn)`.

Now for the outputs, click on "_Map to flow outputs_" to map the output parameters you created earlier to the response of the trigger. The `code` parameter will already be selected, so click on "_123 code_" in the Flow Output section to create the mapping. Now click on "_message_" in the Trigger Response section and select "_* data_" from the Flow Output section to create the mapping. Click "_save_" to make sure everything is, well…, saved. You can click the little `X` on the top-right (no, not your browser…) to close the dialog window and go back to the flow.

## Step 3: Adding activities

You’ll have to add some activities to the flow for it to do something. To add an activity click on the large `+` sign

![step 3a](../../images/labs/bookstore/step3a.png)

On the right-hand side of the screen a list with all the activities the Flogo Web UI knows about will appear. From the list you can pick the "Log Message" activity and click it to make sure it is added to the flow. As you hover over the newly added activity, a cog will appear and as you hover over that thing, a menu will appear to configure your activity. In this window you can configure the inputs of the "_Log Message_" activity using data from all other activities and triggers in your flow. Right now, you only have the incoming data from the HTTP trigger. To make the log message a little more useful you can concatenate things together like in the HTTP trigger. To do so select the **concat** function from the string category (see #1), which will put a new function in the window. Now replace _str1_ with `"Getting book data for: "`, as that will be the first part of the message to log (see #2). The second part will be the isbn. To get the isbn on the place of _str2_, select _str2_ first and after that expand the "flow (flow)" section (by clicking on the little black caret) and click "_a.. isbn_" (see #3). That will enter the selected value on the place of _str2_ (see #4).

![step 3b](../../images/labs/bookstore/step3b.png)

## Step 4: Invoking a REST service

The Google API for books is a REST service. To invoke a REST service you can add a new **Invoke REST Service** activity. As you hover over it to configure the values, you'll notice this activity has a lot more fields you can configure. For now the configuration should be:

* **method**: `"GET"` (to get data from the API)
* **uri**: `https://www.googleapis.com/books/v1/volumes` (the URL of the service you want to call)
* **queryParams**: `{"q":"=$flow.isbn"}` (this appends a query parameter called `q` with the value of the isbn to the URL)

## Step 5: Return data

To complete the flow, add a `Return` activity. Hover over it to see the cog and select **configure** to bring up the modal to configure the activity. The return activity is always the last activity in a branch and sets the values that are returned to the trigger. Click on "_123 code_" and type _200_ in the input field to set the HTTP Response code to 200.

Now click on "* message" and type (or copy) the structure below. Finally click "Save" to complete the mapping.

```json
{
  "title": "=$activity[rest_3].result.items[0].volumeInfo.title",
  "publishedDate": "=$activity[rest_3].result.items[0].volumeInfo.publishedDate",
  "description": "=$activity[rest_3].result.items[0].volumeInfo.description"
}
```

The above snippet maps the values from the REST service to fields that are sent back to the trigger. The mapping is done in a JavaScript-like syntax, so `$activity[rest_3].result.items[0].volumeInfo.title` means it will get the first result (arrays start with 0) and from that result get the _volumeInfo_ element and from that get the _title_ element. The double curly braces are used as by Go's templating engine.

Your final flow should look something like the one below.

![step 5](../../images/labs/bookstore/step5.png)

## Step 6: Build

Those were all the steps needed to design the flow, now let's build an executable from it. On the main screen of your flow click on the "<" button on the top-left hand side of the screen. That will bring you back to your microservice and from here you can select "Build". Choose whichever operating system you're running on to download the executable.

## Step 7: Run

To see the results, start your app and run `curl --request GET --url http://localhost:9233/books/0747532699`. That will give you the details on _Harry Potter and the Philosopher's Stone_