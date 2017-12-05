---
date: 2016-04-09T16:50:16+02:00
title: Flow Mappings
weight: 20
---

On this page we'll analyze the different types of mappings available to you as a Flow developer.

## What are mappings?

A mapping in a Flogo Flow can be used to assign the value of a variable to that of an input parameters of an activity or to the value of another flow scoped variable.

### Types of mappings

If you peak under the covers, you'll note that we have a number of different mapping types supported in the Flogo engine. These include:

| Type | Description |
| --- | --- |
| 1 | Direct mapping. Assigning the value from var1 to var2. No other implied logic. |
| 2 | A literal mapping. For example, mapping the string "hello" to a string typed variable. |
| 3 | Reserved for future use. |
| 4 | Complex object. Used when a JSON-based complex object must be built and assigned. |

Types manifest themselves directly in your application json, as follows:

```json
{
  "mapTo": "ISBN",
  "type": 1,
  "value": "evt.ISBN"
}
```

The obove mapping indicates that the value of evt.ISBN should be mapped to the variables named ISBN. This is a type 1 mapping, hence the value of evnt.ISBN is assigned directly to ISBN. Consider two additional samples, below you will find a type 2 mapping, as well as a complex object, type 4 mapping.

Type 2:
```json
{
  "mapTo": "ISBN",
  "type": 2,
  "value": "12937"
}
```

Type 4:
```json
{
  "mapTo": "ISBN",
  "type": 4,
  "value": { "ISBN": "12937", "Author": "{{$flow.Author}}" }
}
```

The type 2 mapping is pretty simple to understand, however type 4 does require a bit of an explanation. Note that the value param is assigned an object, not a string, and also note the use of the template style variable injection. You can use "{{ }}" when you need to inject the value of another object into your complex object. If you assign the value of an array then that param will be treated as an array, likewise for a string, int, etc. For example, let us pretend flow.Author is an array, then the Author object would be an array. In otherwords, direct assignment is occurring.