---
date: 2016-04-09T16:50:16+02:00
title: The CLI
weight: 30
---

Project Flogo provides two different command-line interfaces and which you need depends on the task you need to execute.

* **flogo**: This CLI gives you the ability to build flows and microservices. With this tool you can, among other things, create your applications, build applications and install new extensions. This tool is great to use with Continuous Integration and Continuous Deployment tools like Jenkins and Travis-CI.
* **flogogen**: If you're looking to extend the functionality that Project Flogo offers out of the box, this is the tool you want to use. Flogogen generates the scafolding used by extensions (activity/trigger) developers to build new extensions.

### Getting started
Before you can get started with either of the cli tools you need to make sure you have the right prerequisites installed:

* The first step is to install the [Go programming language](https://golang.org/doc/install). 

{{% notice note %}}
Don't forget to set your `GOPATH` variable and make sure that `$GOPATH/bin` is part of your path. (see [here](https://golang.org/doc/code.html#GOPATH) or [here](https://github.com/golang/go/wiki/Setting-GOPATH) for more details)
{{% /notice %}}

* After that, **go get** flogo by running `go get -u github.com/TIBCOSoftware/flogo-cli/...`. This will get you both the CLI tools.
* If you want to develop extensions, by using the **flogogen** tool you should also install **golint** by running `go get -u github.com/golang/lint/golint`
* In order to simplify development and building in Go, we are using the gb build tool. You can install that by running `go get github.com/constabulary/gb/...`