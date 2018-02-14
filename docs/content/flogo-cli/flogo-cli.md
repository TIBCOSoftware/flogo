---
title: flogo
weight: 5020
pre: "<i class=\"fa fa-terminal\" aria-hidden=\"true\"></i> "
---

The **flogo** CLI tool gives you the ability to build flows and microservices. With this tool you can, among other things, create your applications, build applications and install new extensions. It is also great to use with Continuous Integration and Continuous Deployment tools like Jenkins and Travis-CI. Below is a complete list of all all commands supported, including samples on how to use them.

{{% notice info %}}
Please make sure that you have installed the **flogo** tools as described in [Getting Started > Flogo CLI](../../getting-started/getting-started-cli/)
{{% /notice %}}

## Commands

### create
This command is used to create a flogo application project.

*Create the base sample project with a specific name.*
	
	flogo create my_app
	
*Create a flogo application project from an existing flogo application descriptor.*
	
	flogo create -f myapp.json
	
*Create a flogo application project using your own vendor directory.*
	
	flogo create -vendor /path/to/my/vendor
	
Important, when using -vendor option use 'flogo ensure -no-vendor' when updating dependencies to not override your imported vendor folder.

*Create a flogo application project specifying constraints for your libraries.*
	
	flogo create -flv github.com/TIBCOSoftware/flogo-lib@0.0.0,github.com/TIBCOSoftware/flogo-contrib@0.0.0

{{% notice note %}}
Pass a comma separated value of libraries and dependencies (you can also use branches and tags).
{{% /notice %}}
		
### install
This command is used to install a contribution to your project.

*Install an activity using the latest version, or existing version constraint*

	flogo install github.com/TIBCOSoftware/flogo-contrib/activity/log

*Install an activity with a specific version constraint*

	flogo install -v 0.0.0 github.com/TIBCOSoftware/flogo-contrib/activity/log

Note: if an existing constraint for the given package exist, the version will be ignored
	
*Install a trigger the latest version, or existing version constraint*

	flogo install github.com/TIBCOSoftware/flogo-contrib/trigger/rest
	
*Install a trigger with a specific version constraint*

	flogo install -v 0.0.0 github.com/TIBCOSoftware/flogo-contrib/trigger/rest

Note: if an existing constraint for the given package exist, the version will be ignored
	
### uninstall
This command is used to remove a contribution to your project.

*Uninstall an activity*

	flogo uninstall github.com/TIBCOSoftware/flogo-contrib/activity/log
	
*Uninstall a trigger*

	flogo uninstall github.com/TIBCOSoftware/flogo-contrib/trigger/rest
	
### list
This command is used to list the activities, triggers and flows installed in the application.  
	 
	flogo list
	
	actions:
	  github.com/TIBCOSoftware/flogo-contrib/action/flow
	activities:
	  github.com/TIBCOSoftware/flogo-contrib/activity/log
	triggers:
	  github.com/TIBCOSoftware/flogo-contrib/trigger/rest

The list can be generated in a JSON format using the 'json' flag

	flogo list -json
	[
	  {
	    "type": "action",
	    "ref": "github.com/TIBCOSoftware/flogo-contrib/action/flow"
	  },
	  {
	    "type": "activity",
	    "ref": "github.com/TIBCOSoftware/flogo-contrib/activity/log"
	  },
	  {
	    "type": "trigger",
	    "ref": "github.com/TIBCOSoftware/flogo-contrib/trigger/rest"
	  }
	]

### prepare
Note: This command is deprecated! please use instead

 	flogo build [-gen]

This command is used to prepare the application. Preparation consist of code generation for contribution metadata and go imports.

 	flogo prepare
 	
**options**
	
- [ -o ] : optimize compilation, compiled application will only contain contribution directly referenced in the flogo.json
- [ -e ] : embeds the configuration into the compiled application	 	 

### build
This command is used to build the application.  The generation of metadata is done by default when doing a build, if you don't want to regenerate the metadata use [-nogen] option.

 	flogo build
 	
**options**
	
- [ -o ]    : optimize compilation, compiled application will only contain contribution directly referenced in the flogo.json
- [ -e ]    : embeds the configuration into the compiled application
- [-nogen]  : ONLY perform the build, without performing the generation of metadata
- [-gen]    : ONLY perform generation of metadata, without performing the build
- [ -sp ]   : [Deprecated, use '-nogen' instead] skip *prepare* step
- [ -shim ] : trigger shim creates an app as shim, pass trigger id as value (for example flogo build -shim my_trigger_id)
- [ -docker ] : creates a docker image of your app, where the docker image is based on [Alpine Linux](https://hub.docker.com/_/alpine/). This switch takes a single argument, a trigger ID for the port to expose. If you don't want to expose any port specify 'no-trigger'.

### ensure
This command is used to manage project dependencies. It is mainly a wrapper for the 'dep ensure' command for the official [dep](https://github.com/golang/dep) library

 	flogo ensure
 	
**options**

- [ -add ]          : add new dependencies, or populate Gopkg.toml with constraints for existing dependencies (default: false)
- [ -no-vendor ]    : update Gopkg.lock (if needed), but do not update vendor/ (default: false)
- [ -update ]       : update the named dependencies (or all, if none are named) in Gopkg.lock to the latest allowed by Gopkg.toml (default: false)
- [ -v ]            : enable verbose logging (default: false)
- [ -vendor-only ]  : populate vendor/ from Gopkg.lock without updating it first (default: false)

### help
This command is used to display help on a particular command
	
	flogo help build 

## Application Project

### Structure

The create command creates a basic structure and files for an application.


	my_app/
		flogo.json
		src/
			my_app/
			    vendor/
			    Gopkg.lock
			    Gopkg.toml
				imports.go
				main.go
		
**files**

- *flogo.json* : flogo project application configuration descriptor file
- *imports.go* : contains go imports for contributions (activities, triggers and models) used by the application
- *main.go*    : main file for the engine.
- *Gopkg.toml* : manifest file including dependency contraints and overrides.
- *Gopkg.lock* : lock file including the actual revision used according to the contraints.

**directories**	
	
- *vendor* : go libraries