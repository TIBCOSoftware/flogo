---
title: Accumulate Activity Output for All Iterations
weight: 4320
---

## What is an Accumulating the Activity Output

When using iterate over an activity or Repeat on True, you have the option to specify if you want to cumulative data from all iterations. 
You can do so by adding  `accumulate:true` to setting, By defaut it set to false


```json
{
  "id": "rest_3",
  "name": "REST Invoke",
  "description": "Invokes a REST Service",
  "settings": {
     "condition": "$activity[RESTInvoke].data.username == \"Bret\" && $iteration[index]<1",
     "delay": 2000,
     "accumulate": true
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

When the accumulate set to true, the activity accumulates the data from each iteration and outputs that collective data as an array of objects, where each object contains the output from the corresponding iteration.

So the output of the above activity `$activity[rest_3]` returns

```json

[
   {
      "status":200,
      "header":{
          "Content-Type":"application/json"
      },
      "data":{
         "id":1,
         "name":"Leanne Graham",
         "username":"Bret",
         "email":"Sincere@april.biz",
         "address":{
            "street":"Kulas Light",
            "suite":"Apt. 556",
            "city":"Gwenborough",
            "zipcode":"92998-3874",
            "geo":{
               "lat":"-37.3159",
               "lng":"81.1496"
            }
         },
         "phone":"1-770-736-8031 x56442",
         "website":"hildegard.org",
         "company":{
            "name":"Romaguera-Crona",
            "catchPhrase":"Multi-layered client-server neural-net",
            "bs":"harness real-time e-markets"
         }
      }
   },
   {
      "status":200,
      "header":{
          "Content-Type":"application/json"
      },
      "data":{
         "id":1,
         "name":"Leanne Graham",
         "username":"Bret",
         "email":"Sincere@april.biz",
         "address":{
            "street":"Kulas Light",
            "suite":"Apt. 556",
            "city":"Gwenborough",
            "zipcode":"92998-3874",
            "geo":{
               "lat":"-37.3159",
               "lng":"81.1496"
            }
         },
         "phone":"1-770-736-8031 x56442",
         "website":"hildegard.org",
         "company":{
            "name":"Romaguera-Crona",
            "catchPhrase":"Multi-layered client-server neural-net",
            "bs":"harness real-time e-markets"
         }
      }
   }
]

```
