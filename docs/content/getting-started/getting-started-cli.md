---
title: Flogo CLI
weight: 2030
pre: "<i class=\"fas fa-terminal\" aria-hidden=\"true\"></i> "
---

### Before you get started
Before you can get started with the cli tools you need to make sure you have the [Go programming language](https://golang.org/doc/install) installed.

{{% notice note %}}
Flogo makes use of [Go Modules](https://github.com/golang/go/wiki/Modules), as such, you'll need to ensure that you have at least **Go 1.11**.
{{% /notice %}}

{{% notice info %}}
Don't forget to set your `GOPATH` variable and make sure that `$GOPATH/bin` is part of your path. (see [here](https://golang.org/doc/code.html#GOPATH) or [here](https://github.com/golang/go/wiki/SettingGOPATH) for more details)
{{% /notice %}}

### Installing the cli tools
Now that you've installed the Go programming language there are a few commands you can run to install the cli and make developing with the cli tools even easier

* First you'll need to **go get** flogo by running `go get -u github.com/project-flogo/cli/...`. This will fetch, build and install the Flogo CLI for your machine.

{{% notice note %}}
If you want to update the CLI tools, you can run `go get -u github.com/project-flogo/cli/...` to get the latest version. 
{{% /notice %}}
