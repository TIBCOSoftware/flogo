---
title: Iterator
weight: 4320
---

## What is an iterator in Flogo?

The iterator construct in Flogo enables the iteration of a single activity. The configuration elements are associated with that activity. In Flogo, you can iterate only over a single activity. The iterator acts much like a for loop in any procedural language.

### Flow configuration

Iterators are associated with an activity. The activity type must be defined as a type **2**, which indicates that it is to be iterated over. Finally, a new settings element has been introduced, this is where you can define the array or literal to iterate over. Consider the JSON sample below of a log activity.


```json
{
  "id": "log_7",
  "name": "LogTitle",
  "description": "Simple Log Activity",
  "type": 2,
  "activityType": "github-com-tibco-software-flogo-contrib-activity-log",
  "activityRef": "github.com/TIBCOSoftware/flogo-contrib/activity/log",
  "attributes": [
  ],
  "inputMappings": [
    {
      "type": 1,
      "value": "$current.iteration.value.volumeInfo.title",
      "mapTo": "message"
    }
  ],
  "settings": {
    "iterate": "$activity[rest_3].result.items"
  }
}
```

A few important things to note:

- The type is **2**
- A new settings element with a property named **iterate** set to the array that should be iterated over. It is also possible to define a static value, for example, if the value of "10" was specified, the iterator construct would invoke this activity 10 times
- The $current scope has not been introduced and can be used to access the value and key of the current iteration.

The $current scope has two properties:

- $current.iteration.value: The value of the current iteration, that is, the object of the current array
- $current.iteration.key: The current key (1, 2, etc)