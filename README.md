<p align="center">
  <img src ="images/projectflogo.png" />
</p>

<p align="center" >
  <b>Project Flogo is an Open Source stack for event-driven apps</b>
</p>

<p align="center">
  <img src="https://travis-ci.org/TIBCOSoftware/flogo.svg"/>
  <img src="https://img.shields.io/badge/dependencies-up%20to%20date-green.svg"/>
  <img src="https://img.shields.io/badge/license-BSD%20style-blue.svg"/>
  <a href="https://gitter.im/project-flogo/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link"><img src="https://badges.gitter.im/Join%20Chat.svg"/></a>
</p>

<p align="center">
  <a href="#project-flogo-stack">Flogo Stack</a> | <a href="#flogo-core">Flogo Core</a> | <a href="#flogo-flows">Flogo Flows</a> | <a href="#flogo-streams">Flogo Streams</a> | <a href="#golang-api">Go Developers</a> | <a href="#contributing">Contributing</a> | <a href="#license">License</a>
</p>

<br/>

Project Flogo is an ultra-light, Go-based open source stack for building event-driven apps. Event-driven, you say? Yup, the notion of *triggers* and *actions* are leveraged to process incoming events. An action, a common interface, exposes key capabilities such as application integration, stream processing, etc.
<br/>

<p align="center">
  <img src ="images/eventhandlers.png" />
</p>
<br/>

- **App = Trigger(s) + Actions[&Activities]**
- **Triggers**
  - receive data from external sources.
  - are managed by a configurable threading model
  - have a common interface enabling anyone to build a Flogo trigger.
- **Handlers**
  - dispatch events to actions
- **Actions**
  - process events in a manner suitable with the implementation
  - have a common interface enabling unique event processing capabilities

# Project Flogo Stack

All capabilities within the Flogo Stack have a few things in common, they all process events (in a manner suitable for the specific purpose) & they all implement the *action* interface exposed by Flogo Core.

Some of the key highlights of the entire stack, include:

🎈**Ultra-light** 20x-50x lighter than Java or Node.js <br/>
⚡️**Event-driven** Powerful event-driven programming model based on *triggers* and *actions*<br/>
⚙️**Common core** a single, common core enables reuse and flexibility across all eventing constructs<br/>
✏️**Golang based** Written entirely in Golang for efficiency<br/>
💪**Deployment flexibility** Deploy as ultra-lightweight serverless functions, containers or static binaries on IoT edge devices<br/>
😍 **100% Open Source** for your dev & hacking pleasure<br/>

<p align="center">
  <img src ="images/flogostack.png" />
</p>

* **Integration Flows** Application Integration process engine with conditional branching and a visual development environment<br/>
* **Stream Processing** a simple pipeline-based stream processing action with event joining capabilities across multiple triggers & aggregation over time windows<br/>
* **Contextual Decisioning**  Declarative Rules for Real-time Contextual Decisions<br/>
* **Microgateway**

The concept is simple, an event is just that, an event, how it’s processed is what differs. Flogo Core eases the burden by enabling a common set of functionality, such as:

- threading
- logging
- data type coercion
- data mapping
- tracing & monitoring hooks 

While also exposing a common set of contributions via activities and triggers. For example, all available triggers can be leveraged to dispatch events to any action implementation, that is, flows for application integration, streams for stream processing, rules for contextual rule processing, etc.

# Flogo Core

Flogo Core is an event-driven app framework used to develop apps for the cloud & IoT edge. It can also be thought of as a lightweight *app kernel* used by open source & commercial solutions.

Flogo Core provides the following key benefits:

⛓ **Action chaining** enables communication between one or more capabilities in a single, sub 10MB binary!<br/>
🏘 **Common contribution model** build activities and triggers that can be leveraged by all capabilities<br/>
🔨 **Extensible** easily extend the capabilities available by building your own action using the common interfaces<br/>

## Flogo Core Contribution Model

Flogo Core exposes three principal contribution interfaces that enable developers to build common capabilities and functionality. These contribution interfaces include:

* **Trigger Interface** a common interface for building event-consumers that dispatch events to one or more actions. The Kafka subscriber is an example of a trigger.
* **Activity Interface** a common interface for exposing common application logic in a reusable manner. Think of this as a function, such as write to database, publish to Kafka, etc that can be used by all applications within the Project Flogo Stack.
* **Action Interface** a common interface for processing events. Actions contain the specific capability logic, such as integration, stream processing, rule processing, etc. Actions have a great deal of flexibility in how they’re developed and how developers leverage actions within their overall applications. For example, flows and streams expose JSON-based DSLs & Go APIs for maximum developer flexibility.

# Repos

Project Flogo consists of the following sub-projects available as separate repos:

* [flogo-cli](https://github.com/TIBCOSoftware/flogo-cli):  Command line tools for building Flogo apps & extensions
* [flogo-lib](https://github.com/TIBCOSoftware/flogo-lib): The core Flogo library
* [flogo-services](https://github.com/TIBCOSoftware/flogo-services): Backing services required by Flogo 
* [flogo-contrib](https://github.com/TIBCOSoftware/flogo-contrib): Flogo contributions/extensions
* [flogo-oss/stream](https://github.com/flogo-oss/stream): Flogo Streams Action

# Flogo Flows

Flogo Flows provides application integration capabilities and includes the following key highlights.

🌈**Painless development** Visual modeler with step-back debugging capabilities & elegant DSL<br/>
⚙️**Ultra-light process engine** for conditional flow control


## Getting Started

We've made getting started with Flogo Flows as easy as possible. The current set of tooling is designed for:

- Serverless function developers
- Cloud-native microservices developers
- IoT Solutions developers
- <a href="#golang-api">Go Developers</a>

### Zero-code Developers

If your background is in or you prefer to develop your apps using zero-coding environments, then read on, because we’ve got something special for you.

Flows Web UI is available via [Docker Hub](https://hub.docker.com/r/flogo/flogo-docker) or [Flogo.io](http://flogo.io). The Docker image contains the Flows Web UI along with all required components to begin developing, testing and building deployable artifacts right from your web browser.

To report any issues with, use the Issue tracker on this project.

![Flogo Web In Action](images/flogo-web2.gif)

# Flogo Streams

Edge devices have the potential for producing millions or even billions of events at rapid intervals, often times the events on their own are meaningless, hence the need to provide basic streaming operations against the slew of events.

A native streaming action as part of the Project Flogo Stack accomplishes the following primary objectives:

- Enables apps to implement basic streaming constructs in a simple pipeline fashion
- Provides non-persistent state for streaming operations
  - Streams are persisted in memory until the end of the pipeline
- Serves as a pre-process pipeline for raw data to perform basic mathematical and logical operations. Ideal for feeding ML models

Some of the key highlights include:

😀**Simple pipeline** construct enables a clean, easy way of dealing with streams of data<br/>
⏳**Stream aggregation** across streams using time or event tumbling & sliding windows<br/>
🙌**Join streams** from multiple event sources<br/>
🌪**Filter** out the noise with stream filtering capabilities<br/>

## Getting Started

We’ve made building powerful streaming pipelines as easy as possible. Develop your pipelines using:

- A simple, clean JSON-based DSL
- Golang API

See the sample below of an aggregation pipeline (for brevity, the triggers and metadata of the resource has been omitted). Also don’t forget to check out the examples in the [flogo-oss/stream](https://github.com/flogo-oss/stream/tree/master/examples) repo.

```json
  "stages": [
    {
      "ref": "github.com/TIBCOSoftware/flogo-contrib/activity/aggregate",
      "settings": {
        "function": "sum",
        "windowType": "timeTumbling",
        "windowSize": "5000"
      },
      "input": {
        "value": "=$.input"
      }
    },
    {
      "ref": "github.com/TIBCOSoftware/flogo-contrib/activity/log",
      "input": {
        "message": "=$.result"
      }
    }
  ]
```

# Flogo Rules

## Getting Started
Build your Declarative Rules app as a Flogo Action type or execute as a standalone lib 

# The CLI

The CLI is used to build all applications that leverage the JSON-based DSL. If you’re using the Go API to build your apps, feel free to just `go build` your stuff without the flogo CLI.

Getting started with the CLI couldn't be any easier (refer to [Flogo CLI](https://github.com/TIBCOSoftware/flogo-cli) repo for detail instructions and dependencies):

* Install the CLI
```bash
go get -u github.com/TIBCOSoftware/flogo-cli/...
```

* Create & build your app
<img src="images/flogo-cli.gif" width="70%"/>

* **flogo** the core CLI for creating and building your applications
* **flogogen** a scaffolding tool to begin building your Flogo contributions (activities, triggers & actions)

If you're interested in building your own contribution(s), refer to the [Flogo Documentation](https://tibcosoftware.github.io/flogo/) or join us on the [project-flogo/Lobby Gitter Channel](https://gitter.im/project-flogo/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link).

# Golang API

So you’re a Go dev and would rather code your own apps, but would love to leverage the capabilities exposed by the Flogo Stack? Makes total sense, we just ❤️to code, as well! We’ve exposed a number of Go APIs for leveraging the various action types, activities and triggers. Getting started is pretty easy, just follow the steps below.

Go get …

Sample app

```go
Sample app
```

Sample leveraging your Flow or Stream.

# Contributing
Want to contribute to Project Flogo? We've made it easy, all you need to do is fork the repository you intend to contribute to, make your changes and create a Pull Request! Once the pull request has been created, you'll be prompted to sign the CLA (Contributor License Agreement) online.

Not sure where to start? No problem, here are a few suggestions:

* [flogo-contrib](https://github.com/TIBCOSoftware/flogo-contrib): This repository contains all of the contributions, such as activities, triggers, etc. Perhaps there is something missing? Create a new activity or trigger or fix a bug in an existing activity or trigger.
* Browse all of the Project Flogo repositories and look for issues tagged `kind/help-wanted` or `good first issue`

If you have any questions, feel free to post an issue and tag it as a question, email flogo-oss@tibco.com or chat with the team and community:

* The [project-flogo/Lobby](https://gitter.im/project-flogo/Lobby) Gitter channel should be used for general discussions, start here for all things Flogo!
* The [project-flogo/developers](https://gitter.im/project-flogo/developers) Gitter channel should be used for developer/contributor focused conversations. 

For additional details, refer to the [Contribution Guidelines](https://github.com/TIBCOSoftware/flogo/blob/master/CONTRIBUTING.md).

# License 
The top level flogo repo, consisting of flow samples & documentation, is licensed licensed under a BSD-style license. Refer to [LICENSE](https://github.com/TIBCOSoftware/flogo/blob/master/LICENSE) for license text.

Flogo source code in [flogo-cli](https://github.com/TIBCOSoftware/flogo-cli), [flogo-lib](https://github.com/TIBCOSoftware/flogo-lib), [flogo-contrib](https://github.com/TIBCOSoftware/flogo-contrib) & [flogo-services](https://github.com/TIBCOSoftware/flogo-services) are all licensed under a BSD-style license, refer to [LICENSE](https://github.com/TIBCOSoftware/flogo/blob/master/LICENSE) 

## Usage Guidelines

We’re excited that you’re using Project Flogo to power your project(s). Please adhere to the [usage guidelines](http://flogo.io/brand-guidelines) when referencing the use of Project Flogo within your project(s) and don't forget to let others know you're using Project Flogo by proudly displaying one of the following badges or the Flynn logo, found in the [branding](branding) folder of this project.
