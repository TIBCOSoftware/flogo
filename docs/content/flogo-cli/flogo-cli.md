---
title: flogo
weight: 5020
pre: "<i class=\"fa fa-terminal\" aria-hidden=\"true\"></i> "
---

The **flogo** CLI tool gives you the ability to build flows and microservices. With this tool you can, among other things, create your applications, build applications and install new extensions. It is also great to use with Continuous Integration and Continuous Deployment tools like Jenkins and Travis-CI. Below is a complete list of all all commands supported, including samples on how to use them.

{{% notice info %}}
Please make sure that you have installed the **flogo** tools as described in [Getting Started > Flogo CLI](../../getting-started/getting-started-cli/)
{{% /notice %}}

## build
Build the flogo application
```
Usage:

flogo build [-o][-e][-sp][-shim][-docker]

Options:
    -o      optimize for directly referenced contributions
    -e      embed application configuration into executable
    -sp     skip prepare
    -shim   trigger shim
    -docker create a docker image based on Alpine Linux
```
 	
options	

* [ -o ] : optimize compilation, compiled application will only contain contribution directly referenced in the flogo.json
* [ -e ] : embeds the configuration into the compiled application
* [ -sp ] : skip *prepare* step
* [ -shim ] : creates a package based on the availability of a shim in the trigger (for example when creating a cli app)
* [ -docker ] : creates a docker image of your app, where the docker image is based on [Alpine Linux](https://hub.docker.com/_/alpine/)

## create
Creates a flogo project
```
Usage:

flogo create AppName

Options:
    -flv     specify the flogo-lib version
    -f       specify the flogo.json to create project from
    -vendor  specify existing vendor directory to copy
```

Create the base sample project with a specific name.
```	
flogo create my_app
```

Create a flogo application project from an existing flogo application descriptor.
```	
flogo create -f myapp.json
```

## help
Provides help for a specific command
```
Usage:

flogo help <command>

Commands:

    build        build the flogo application
    create       create a flogo project
    help         Get help for a command
    install      install a flogo contribution
    list         list installed contributions
    prepare      prepare the flogo application
    uninstall    uninstall a flogo contribution
```

## install
Installs a flogo contribution.
```
Usage:

flogo  install [-v version][-p] contribution

Options:
    -v specify the version
    -p install palette file
```

Install an activity from GitHub
```
flogo install github.com/TIBCOSoftware/flogo-contrib/activity/log
```

## list
Lists installed contributions.
```
Usage:

flogo  list [-json] [actions|triggers|activities]

Options:
    -json generate output as json
```  

List the contributions you have used in your app
```
flogo list
	
actions:
  github.com/TIBCOSoftware/flogo-contrib/action/flow
activities:
	github.com/TIBCOSoftware/flogo-contrib/activity/log
flow-model:
	github.com/TIBCOSoftware/flogo-contrib/model/simple
triggers:
	github.com/TIBCOSoftware/flogo-contrib/trigger/rest
```

_The list can be generated in a JSON format using the `-json` flag_

## prepare
Prepare the flogo application. This consists of code generation for contribution metadata and go imports.
```
flogo  prepare [-o][-e]

Options:
    -o   optimize for directly referenced contributions
    -e   embed application configuration into executable
```
 	
options
	
* [ -o ] : optimize compilation, compiled application will only contain contribution directly referenced in the flogo.json
* [ -e ] : embeds the configuration into the compiled application	 	
	
## uninstall
Uninstalls a flogo contribution.
```
Usage:

flogo  uninstall contribution
```

Remove an activity from your project
```
flogo uninstall github.com/TIBCOSoftware/flogo-contrib/activity/log
```
