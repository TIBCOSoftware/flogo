---
title: Quickstart
weight: 2010
pre: "<i class=\"fas fa-bolt\" aria-hidden=\"true\"></i> "
---

We think it is awesome that you want to get started with Project Flogo! To get started you don't even need to install anything other than Docker!

In this quickstart guide we'll walk you through the prerequisites for getting up and running with your first Flogo app.

### Getting Docker
To make it easy to get started the Flogo Web UI is packaged up as a docker image which you can get from [docker hub](https://hub.docker.com/r/flogo/flogo-docker/). To install Docker for your operating system click [here](https://docs.docker.com/docker-for-mac/install/) for macOS and [here](https://docs.docker.com/docker-for-windows/install/) for Windows. 

{{% notice note %}}
If you're planning to run on a Windows machine older than Windows 10, you'll need to install [Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/)
{{% /notice %}}

### Getting the Flogo Web UI
To get started with the latest version of the Flogo Web UI paste this command in a terminal window:

```docker run -it -p 3303:3303 flogo/flogo-docker:latest eula-accept```

The parameters after the `docker run` command are:

* **-it**: This parameter keeps a pseudo-tty terminal open and keeps the terminal running in interactive mode. The Flogo Web Ui will print logs to this terminal window
* **-p 3303:3303**: This parameter tells Docker to bind your computer's port 3303 to the container's port 3303
* **flogo/flogo-docker:latest**: This parameter tells the Docker daemon which container you want to run. In this case it will try to get the latest version of `flogo/flogo-docker`
* **eula-accept**: This parameter says you've accepted the EULA agreement on our [website](http://flogo.io)

After it is done starting the container, you'll see something like the image below in your terminal.

![Docker Container Started](../../images/start-docker-webui.png)

### Launching the Web UI
To launch Flogo WebUI simply open your favorite web browser, and navigate to http://localhost:3303. You'll see our mascot Flynn there to greet you!

![Web UI](../../images/webui-landing.png)

#### A new app
To create a new microservice app, simply click on the big blue button `new` and select **Microservice** as the profile. A new app will be created for you and at the top of the screen you can give the app a name and an optional description. The name of the app will also be used as the name of the executable later on, so you should use a meaningful name.

#### A new flow
To create a new flow you can click either the `+ New Flow` button at the top or the `Create a flow` button in the middle of the screen.

![screen1.png](../../images/screen1.png)

No matter which you pick, you'll be presented with a dialog to give your new flow a name and an optional description. Click **Create** to create the new flow and click on the newly created flow to open the editor.

![screen2.png](../../images/screen2.png)

#### Add a new trigger
To get started, click on the newly created flow to open the flow editor. On the left hand side of the screen you should see a dotted box with a `+` sign in it. 

![screen3.png](../../images/screen3.png)

When you click there you'll be asked to select a trigger to get started. For now we’ll choose the **Receive HTTP Message**, which means our microservice will listen to incoming HTTP messages.

![screen4.png](../../images/screen4.png)

#### Configure the trigger
Click on the trigger you just created. There are three settings that we'll configure:

* **port**: The HTTP port on which this flow should listen. For this example we’ll use 9233
* **method**: The HTTP method that will trigger the flow. To make testing a bit easier we’ll use the `GET` method so we can test it from the browser
* **path**: The path for the flow to listen to. We’ll set this to `/test/:name`

![screen5.png](../../images/screen5.png)

{{% notice tip %}}
The URL on which our microservice will listen will be `http://localhost:9233/test/:name` (the _:name_ is a parameter that you can replace with anything during runtime). If you made changes to any of the variables above, please make sure to change those in the rest of these examples.
{{% /notice %}}

#### Add Flow params
To add a new flow parameter, click on the large grey box called `Flow params`. In the iput section type _name_ in the box where it says _parameter name_ and in the output section type _greeting_ in the box where it says _parameter name_. Click the big blue **save** button to complete this step.

![screen6.png](../../images/screen6.png)

#### Add a log activity
You can add activities to the canvas by clicking the `+` button. Let's add a new **Log Message** activity to the service by clicking on the icon and choosing the **Log Message**. By default you'll have a bunch of activities to choose from and just as with triggers, if none of them fit your needs, you can either create new ones yourself or look at the [community](https://tibcosoftware.github.io/flogo/showcases/). The Log activity will give the flow the ability to write data to the standard output. As you hover over it, a panel will slide out and you can select **configure** to start configuring your activity.

The configuration should be as follows:

* message: `string.concat("Hello ", $flow.name)` (this will take the name you passed into the flow as a parameter and log a hello)

![screen7.png](../../images/screen7.png)

_Note: you can leave `flowInfo`and `addToFlow` blank_

#### Add a reply handler
The last step in the flow is to add a reply handler. You can do that in the same way we just added the Log activity in the previous step. Click on the `+` button and choose the **Return** activity.

![screen8.png](../../images/screen8.png)

#### Configure it
Hover over the new activity select **configure** to start mapping. Click on **greeting** on the left hand side of the screen (which is the flow param you created earlier). You can paste in `string.concat(\"Hello \", $flow.name)` and click the big blue **save** button to complete this step. This will return the same hello statement we logged in the earlier step.

![screen9.png](../../images/screen9.png)

#### One final mapping step
The last step to complete the mappings is to map all the input and output to the trigger. Hover over the trigger you created, a slide out panel will appear with an option for `Configure`. Click on that option to open the configuration pane. 

Select the option for **Flow Inputs** on the left hand side and click on `a.. name`. Type `$.pathParams.name` in the input box, which means you'll map the name parameter from the URL to this field.

![screen10.png](../../images/screen10.png)

Select the option for **Trigger Reply** on the left hand side and click on `1.. code`. Type the value `200` in the input box, which means you'll hardcode the value for code. While usually not a best practice to hardcode things, it is an easy way to test. Now click on `* data` and instead of typing a value, click on `a.. greeting` underneath the box. This means you'll map the flow parameter **greeting** as part of the output. Click the big blue **save** button to complete this step.

![screen11.png](../../images/screen11.png)

#### Build your app 
To build your executable and be able to run the app on your machine, click on the `<` at the top of the screen to go back to the page where you added your flows. Now we can build an executable out of it to run it on your machine. From the page you're on right now select build and choose the target plaform for which you want to build an executable. This will build an executable and give you the option to download it.

![screen12.png](../../images/screen12.png)

{{% notice tip %}}
Project Flogo can build binaries for most platforms that exist. If you choose to build one for a unix based system (e.g. Linux or macOS) be sure to add the executable property to it (`chmod +x <executable>`).
{{% /notice %}}

#### Running your app
To run your app simply execute the app from a terminal and you'll not only see the output of the log step, but you'll see the same in your browser window as well. The URL on which our microservice will listen should be `http://localhost:9233/test/:name` (or might be different if you made changes in the previous steps). If you're running it on your machine you can open a browser window and go to `http://localhost:9233/test/flogo` to see what the output was (spoiler alert: you'll see `"Hello flogo"` in your web browser). To stop your app simply close the terminal window in which you started the app or press **ctrl + c**