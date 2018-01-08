---
date: 2016-04-09T16:50:16+02:00
title: CLI tools
weight: 30
pre: "<i class=\"fa fa-terminal\" aria-hidden=\"true\"></i> "
---

Project Flogo provides two different command-line interfaces and which you need depends on the task you need to execute.

* **flogo**: This CLI gives you the ability to build flows and microservices. With this tool you can, among other things, create your applications, build applications and install new extensions. This tool is great to use with Continuous Integration and Continuous Deployment tools like Jenkins and Travis-CI.
* **flogogen**: If you're looking to extend the functionality that Project Flogo offers out of the box, this is the tool you want to use. Flogogen generates the scafolding used by extensions (activity/trigger) developers to build new extensions.

Before you can get started with either of the cli tools you need to make sure you have the right prerequisites installed:

* The first step is to install the [Go programming language](https://golang.org/doc/install). 

{{% notice info %}}
Don't forget to set your `GOPATH` variable and make sure that `$GOPATH/bin` is part of your path. (see [here](https://golang.org/doc/code.html#GOPATH) or [here](https://github.com/golang/go/wiki/Setting-GOPATH) for more details)
{{% /notice %}}

* After that, **go get** flogo by running `go get -u github.com/TIBCOSoftware/flogo-cli/...`. This will get you both the CLI tools.
* If you want to develop extensions, by using the **flogogen** tool you should also install **golint** by running `go get -u github.com/golang/lint/golint`
* In order to simplify dependency management, we are using the go dep tool. You can install that by following the instructions [here](https://github.com/golang/dep#setup) .

{{% notice note %}}
If you want to update the CLI tools, you can run `go get -u github.com/TIBCOSoftware/flogo-cli/...` to get the latest version. 
{{% /notice %}}