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
## the command `flogo ensure`

## bin folder is constructed using flogo build
/bin
## pkg folder is constructed using flogo ensure
/pkg
## vendor folder in src is constructed using flogo ensure
/src/*/vendor
```

## using the -flv flag
With the flogo cli you're usually on the latest tagged version of the main flogo repos. If you want to pick up the latest master branch, or a specific branch, you can use the `-flv` flag with `flogo create`. The flag wraps the `dep` command and since dep expects go code at the root of a repo, you'll need to specify specify a package within that repo rather than the repo itself for the main flogo repositories:

* For [flogo-contrib](https://github.com/TIBCOSoftware/flogo-contrib) you can use `github.com/TIBCOSoftware/flogo-contrib/action/flow@master`
* For [flogo-lib](https://github.com/TIBCOSoftware/flogo-lib) you can use `github.com/TIBCOSoftware/flogo-lib/engine@master`

_You can replace master with any branch you want_
