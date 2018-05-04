---
title: Best practices for app development
weight: 4220
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