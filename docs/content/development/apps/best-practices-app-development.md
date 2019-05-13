---
title: Best practices for app development
weight: 4240
---

There are a few best practices that we recommend when developing apps and functions using Flogo.

## .gitignore
You definitely want to store your apps in a source control system and we recommend the the below template for your `.gitignore` for Flogo apps

```
## Project Flogo .gitignore
## To restore all dependencies and prepare the project for build run
## the command `flogo imports sync`

## bin folder is constructed using flogo build
/bin
```
## using the -cv flag
With the flogo cli you're usually on the latest tagged version of the main flogo repos. If you want to pick up the latest master branch, or a specific branch, you can use the `-cv` flag with `flogo create`. This flag will pull the specified version of the project-flogo/core when the app structure is built.

* For [flogo-lib](https://github.com/project-flogo/core) you can use `github.com/github.com/project-flogo/core@master`

_You can replace master with any branch/tag that you you want_

## update a package to a specific version
By default, the flogo cli will use the latest tagged version of any contrib. If you'd like to pick up the latest tagged release, master or a specific tagged release use the `flogo update` command:

```terminal
flogo update github.com/project-flogo/contrib/activity/trigger/rest@master
flogo update github.com/project-flogo/contrib/activity/trigger/rest@v1.0.0
flogo update github.com/project-flogo/contrib/activity/trigger/rest@latest
```