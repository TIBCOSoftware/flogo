---
title: Contributing to the Showcase
weight: 9200
---

Have an activity, trigger or app that you want to share with the Flogo comunity? That's awesome! To contribute to the showcase follow the steps below.

## Folders
The showcase is located at the root of the [flogo](https://github.com/TIBCOSoftware/flogo) repo and is structured as follows.

    showcases
    ├── data 
    │   ├── items.toml                  <-- the showcase data file

{{% notice note %}}
items.toml is the file that you'll need to edit to add your activity, trigger or app.
{{% /notice %}}

## Adding your contribution
After you've forked the [flogo](https://github.com/TIBCOSoftware/flogo) repo and cloned it to your local machine, open showcases/data/items.toml in your favorite text editor. Append your specific contribution, as shown below.

```toml
[[items]]
name = "Aggregate"
type = "activity"
description = "This activity provides your flogo application with rudimentary aggregation capabilities."
url = "https://github.com/TIBCOSoftware/flogo-contrib/tree/master/activity/aggregate"
uploadedon = "January 8, 2018"
author = "TIBCOSoftware"
```

* Enter your contribution name
* Specify the type: activity, trigger or app
* Supply a short description
* Provide the GitHub url
* Specify your uploaded date
* Provide your github id

## Building the showcase
In order to build and submit your changes, please follow the instructions below:

* Fork the [flogo](https://github.com/TIBCOSoftware/flogo) repo
* Update the showcase with your content, as shown above
* Create a PR against the [flogo](https://github.com/TIBCOSoftware/flogo) repo