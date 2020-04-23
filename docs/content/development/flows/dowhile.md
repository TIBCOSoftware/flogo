---
title: Repeat on True(dowhile)
weight: 4320
---

## What is an Repeat on True(doWhile) in Flogo?

The current `iterator` feature allows a user to repeat an activity on a fixed number of times by configuring the `iterate` property. However, there are are certain scenarios where a user would like to repeat an activity based on the output of the current activity or previous activties. To support this, a new feature **`Repeat on true`** has been included as part of release **0.9.4**.


### Flow configuration

Repeat on True(dowhile) are associated with an activity. The activity must have the `type` declared and set to `doWhile`.

To begin with, the `Repeat on true` feature has two attributes under setting
1. `condition`: A boolean expression that can be built using the current activity's output and previous activity's outputs.
2. `delay`: The time in milliseconds to wait before executing the next iteration, by default, the `delay` is `0` implying there will be no delay between each iteration.

Along with the current and previous activities' output, the value for `condition` can use a special attribute `$iteration[index]` to track the `index` of the iteration. This is often useful if the user does not want the activity to repeat indefinitely.


```json
{
  "id": "rest_3",
  "name": "REST Invoke",
  "description": "Invokes a REST Service",
  "settings": {
     "condition": "$activity[RESTInvoke].data.username == \"Bret\" && $iteration[index]<=3",
     "delay": 2000
  },
  "type": "doWhile",
  "activity": {
    "ref": "#rest",
    "settings": {
      "method": "GET",
      "uri": "https://jsonplaceholder.typicode.com/users/1"
    }
  }
}
```

Important note: 
The condition evalucate after activity execution and `$iteration[index]` start with 0, which also means first execution must been made to determin next or not base on condition.  The activity will always been execute `$iteration[index] + 1` times

Since the activity is of type `"doWhile"`, the `condition` attribute is evaluated to determine if/not the activity must be repeated. For the above activity, since the first part of the condition is always true for that url, the second part i.e `$iteration[index]<=3` will determine if the activity needs to be repeated or not.
