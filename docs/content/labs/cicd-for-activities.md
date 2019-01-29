---
title: Continuously testing Flogo activities
hidden: true
---

Depending on where you store the source code and how publicly you want to have the code available you have a few options to continuously testing Flogo activities. In this tutorial you'll look at [Jenkins](https://jenkins.io/) when using a local git server and [Travis-CI](travis-ci.org) for activities on GitHub

## What you'll need

### Flogo CLI

This demo makes use of the Flogo CLI. If you don't have that one running yet, please check out [Getting Started with the Flogo CLI](../../getting-started/getting-started-cli/)

### Jenkins & Travis-CI

You'll need to have Jenkins set up, together with the Go plugin (Go version 1.10 or higher) and you'll need an account to [Travis-CI](travis-ci.org). An account for the latter is free, if you want to use it with Open Source repositories.

### Need help

If you have any questions, feel free to post an [issue on GitHub](https://github.com/TIBCOSoftware/flogo/issues) and tag it as a question or chat with the team and community:

* The [project-flogo/Lobby](https://gitter.im/project-flogo/Lobby) Start here for all things Flogo!
* The [project-flogo/developers](https://gitter.im/project-flogo/developers) Developer/contributor focused conversations.

## Structure

The project structure we'll use has separate folders for activities and triggers. A sample layout would look like this:

```bash
├───<Repo root>
│   └───activity
|   |   └───<my-activity>
|   |       |───<all my files>
│   └───trigger
|       └───<my-trigger>
|           |───<all my files>
```

For example, the [Flogo Contrib](https://github.com/TIBCOSoftware/flogo-contrib) repository looks like:

```bash
├─── flogo-contrib
│   └───a ctivity
|       └─── log
|           |─── README.md
|           |─── activity.go
|           |─── activity.json
|           |─── activity_test.go
```

## Jenkins

### Installing the Go Plugin

To get started with Go in Jenkins there is a great plugin that makes it all very easy. To install the [Go Plugin](https://wiki.jenkins.io/display/JENKINS/Go+Plugin) for Jenkins go to `Manage Jenkins -> Manage Plugins` and search for `Go Plugin` on the _Available_ tab. After that select `Download now and install after restart` to restart Jenkins.

After you've done that, it is time to select the version of Go you want to use for the builds. Go to `Manage Jenkins -> Global Tool Configuration` and look for the `Go` section. Click on the button **Go installations...** and specify a name for your installation. The name itself doesn't have any significance, but it will make it a lot easier to find the right one later on. Check the box for **Install automatically** and select the version you want to have installed. After that click **Apply** follows by **Save**.

### Configuring the build job

Within Jenkins create a `New Item` and select a **Freestyle** project. Since repositories can have multiple activities, you can select a parameterized project.

In the _Build Environment_ section you need to check two boxes:

* `Delete workspace before build starts`: This makes sure you always start with fresh code and nothing lingers around;
* `Set up Go programming language tools`: This was added by the Go Plugin and lets you pick the Go version you configured earlier (this is where the name comes in).

In the _Build_ section add a new build step that executes a shell command. The shell command will take care of getting the dependencies and executing the test cases:

```bash
## Go get the Project Flogo dependencies
go get github.com/TIBCOSoftware/flogo-lib/...
go get github.com/TIBCOSoftware/flogo-contrib/...

## Go get the test dependencies
go get github.com/stretchr/testify/assert

## Find all the activities and run the test cases for them
for path in ./activity/*; do
    [ -d "${path}" ] || continue # if not a directory, skip
    dirname="$(basename "${path}")"

    ## Run the test cases
    go test ./activity/$dirname
done
```

## Travis-CI

For code that exists on GitHub there are a lot of options (including Jenkins), but let's look at Travis-CI. Travis-CI is continuous integration for projects hosted on GitHub and provides automation for testing building and deploying. They have quite a good [Getting Started guide](https://docs.travis-ci.com/user/for-beginners), so this tutorial skips that part of the setup and dives right into it.

As you push your code to GitHub, the only additional file you need for Travis-CI to work is a file called `.travis.yml` (and you'll need to turn on the builds from the Travis Web UI).

```yaml
## We don't need elevated privileges
sudo: false

## The language should be Go and we'll use version 1.8.3
language: go
go:
- 1.10

## The below statement skips all branches that start with a 'v' (e.g. v1) so that we can have working branches that get committed.
branches:
  except:
  - /^v.*/

## Install the dependencies we need
install:
- go get github.com/TIBCOSoftware/flogo-lib/...
- go get github.com/TIBCOSoftware/flogo-contrib/...
- go get github.com/stretchr/testify/assert

## The script is the same as it was in Jenkins, though joined to be a single line
script:
- for path in ./activity/*; do [ -d "${path}" ] || continue; dirname="$(basename "${path}")"; go test ./activity/$dirname; done; zip -r release.zip ./activity/ ./connector/
```