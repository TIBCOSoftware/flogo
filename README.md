<p align="center">
  <img src ="images/projectflogo.png" />
</p>

<p align="center" >
  <b>An open source framework that makes building reliable & efficent serverless functions and microservices easy!</b>
</p>

<p align="center">
  <img src="https://travis-ci.org/TIBCOSoftware/flogo.svg"/>
  <img src="https://img.shields.io/badge/dependencies-up%20to%20date-green.svg"/>
  <img src="https://img.shields.io/badge/license-BSD%20style-blue.svg"/>
  <a href="https://gitter.im/project-flogo/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link"><img src="https://badges.gitter.im/Join%20Chat.svg"/></a>
</p>

<p align="center">
  <a href="#highlights">Highlights</a> | <a href="#repos">Repos</a> | <a href="#getting-started">Getting Started</a> | <a href="#contributing">Contributing</a> | <a href="#license">License</a>
</p>

## Highlights

🎈 **Ultra-light process engine** 20x-50x lighter than Java or NodeRed <br/>
🏘 **Extensible & reusable** by design to build your own apps, frameworks & platforms <br/>
🎉 **100% Open Source** <br/>

## Repos

Project Flogo consists of the following sub-projects available as separate repos:
* [flogo-cli](https://github.com/TIBCOSoftware/flogo-cli):  Command line tools for building Flogo apps & extensions
* [flogo-lib](https://github.com/TIBCOSoftware/flogo-lib): The core Flogo library
* [flogo-services](https://github.com/TIBCOSoftware/flogo-services): Backing services required by Flogo 
* [flogo-contrib](https://github.com/TIBCOSoftware/flogo-contrib) : Flogo contributions/extensions

## Getting Started

We've made getting started with Project Flogo as easy as possible. The current set of tooling is designed for:

- Serverless function developers
- Cloud-native microservices developers
- IoT Solutions developers
- Go developers

### Zero-code Developers

If your background is in or you prefer to develop your apps using zero-coding environments, then read on, because we’ve been working on something special for you.

Flogo Web UI is available via [Docker Hub](https://hub.docker.com/r/flogo/flogo-docker) or [Flogo.io](http://flogo.io). The Docker image contains the Flogo Web UI along with all required components to begin developing, testing and building deployable artifacts right from your web browser.

To report any issues with Flogo Web UI, use the Issue tracker on this project.

![Flogo Web In Action](images/flogo-web2.gif)

### Go Developers

Getting started with the CLI couldn't be any easier (refer to [Flogo CLI](https://github.com/TIBCOSoftware/flogo-cli) repo for detail instructions and dependencies):

```bash
go get -u github.com/TIBCOSoftware/flogo-cli/...
```

![Flogo CLI](images/flogo-cli.gif)

* **flogo** the core CLI for creating and building your applications
* **flogogen** a scafolding tool to begin building your Flogo contributons (activities & triggers)

If you're interested in bulding your own Flogo Contributsions, refer to the [Flogo Documentation](https://tibcosoftware.github.io/flogo/) or join us on the [project-flogo/Lobby Gitter Channel](https://gitter.im/project-flogo/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link).

## Contributing
Want to contribute to Project Flogo? We've made it easy, all you need to do is fork the repository you intend to contribute to, make your changes and create a Pull Request! Once the pull request has been created, you'll be prompted to sign the CLA (Contributor License Agreement) online.

Not sure where to start? No problem, here are a few suggestions:

* [flogo-contrib](https://github.com/TIBCOSoftware/flogo-contrib): This repository contains all of the contributions, such as activities, triggers, etc. Perhaps there is something missing? Create a new activity or trigger or fix a bug in an existing activity or trigger.
* Browse all of the Project Flogo repositories and look for issues tagged 'kind/help-wanted' or 'good first issue'

If you have any questions, feel free to post an issue and tag it as a question, email flogo-oss@tibco.com or chat with the team and community:

* The [project-flogo/Lobby](https://gitter.im/project-flogo/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link) Gitter channel should be used for general discussions, start here for all things Flogo!
* The [project-flogo/developers](https://gitter.im/project-flogo/developers?utm_source=share-link&utm_medium=link&utm_campaign=share-link) Gitter channel should be used for developer/contributor focused conversations. 

For additional details, refer to the [Contribution Guidelines](https://github.com/TIBCOSoftware/flogo/blob/master/CONTRIBUTING.md).

## License 
The top level flogo repo, consisting of flow samples & documentation, is licensed licensed under a BSD-style license. Refer to [LICENSE](https://github.com/TIBCOSoftware/flogo/blob/master/LICENSE) for license text.

Flogo source code in [flogo-cli](https://github.com/TIBCOSoftware/flogo-cli), [flogo-lib](https://github.com/TIBCOSoftware/flogo-lib), [flogo-contrib](https://github.com/TIBCOSoftware/flogo-contrib) & [flogo-services](https://github.com/TIBCOSoftware/flogo-services) repos are licensed under a BSD-style license. Refer to [flogo-cli license](https://github.com/TIBCOSoftware/flogo-cli/blob/master/TIBCO%20LICENSE.txt) for license text. 

### Usage Guidelines

We’re excited that you’re using Project Flogo to power your project(s). Please adhere to the [usage guidelines](http://flogo.io/brand-guidelines) when referencing the use of Project Flogo within your project(s) and don't forget to let others know you're using Project Flogo by proudly displaying one of the following badges or the Flynn logo, found in the [branding](branding) folder of this project.
