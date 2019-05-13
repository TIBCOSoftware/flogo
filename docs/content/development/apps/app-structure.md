---
title: App structure
weight: 4210
---

Every Flogo app has the same basic structure and files for an application.

```
myApp/
├── flogo.json
└── src
    ├── go.mod
    ├── go.sum
    ├── imports.go
    ├── main.go
```

## files
The most important files are

* *flogo.json* : flogo project application configuration descriptor file
* *imports.go* : contains go imports for contributions (activities, triggers, models and functions) used by the application
* *main.go* : main file for the engine.

## directories
The most important directories are

* *src* : the place where all code is stored