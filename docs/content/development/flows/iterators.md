---
title: Iterator
weight: 4320
---

## What is an iterator in Flogo?

The iterator construct in Flogo enables the iteration of a single activity. The configuration elements are associated with that activity. In Flogo, you can iterate only over a single activity. The iterator acts much like a foreach loop in any procedural language. If you need to iterate over multiple activity calls, simply place an iterator on a subflow.

### Flow configuration

Iterators are associated with an activity. The activity must have the `type` declared and set to `iterator`, as well as the `iterate` setting defined and the value would be either the array to iterate over or a scalar value. 


```json
{
  "id": "log_2",
  "type": "iterator",
  "name": "Log",
  "description": "Logs a message",
  "settings": {
    "iterate": 1
  },
  "activity": {
  "ref": "#log",
  "input": {
    "addDetails": false,
    "message": "=string.concat(\"Hello \", $flow.name)"
    }
  }
}
```

A few important things to note:

- A new settings element with a property named **iterate** set to the array that should be iterated over. It is also possible to define a static value, for example, if the value of "10" was specified, the iterator construct would invoke this activity 10 times
- The $iterate scope has now been introduced and can be used to access the value and key of the current iteration.

The $iterate scope has two properties:

- $current[value]: The value of the current iteration, that is, the object of the current array
- $current[key]: The current key (1, 2, etc)