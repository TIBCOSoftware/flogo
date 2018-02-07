---
title: Mappings
weight: 4320
---

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

The WebUI insulates you frome much of this understanding and will infer the correct mapping type.

## Mapping Resolvers

Flogo will resolve mappings with the following. Note the scopes table below, which indicates what objects are accessible within what scope.

| Scope | Description |
| --- | --- |
| $env | Used to resolve an environment variable |
| $property | Used to resolve properties from the global application property bag |
| $flow | Used to resolve params from within the current flow. If a flow has a single trigger and no input params defined, then the output of the trigger is made available via $flow |
| $activity | Used to resolve activity params. Activities are referenced by id, for example, $activity[acivity_id].activity_property. |
| $current | Used to resolve data scoped to a current iterator |

## Mapping Scopes

Flogo has the concept of mapping resolvers and resolvers are contained within a specific scope, hence not all objects can be accessed from anywhere within the scope.

| Mapper | Scope |
| --- | --- |
| Trigger->Settings | env and property resolvers |
| Trigger->Handler->Settings | env and property resolvers |
| Trigger->Handler->actionMapper/input | Trigger ouput <-- "value" field - only property and env resolver can be used. That is, only the output of the trigger or an environment variable can be used here. |
| Trigger->Handler->actionMapper/output | action scope. Properties defined as ahe output of the flow can be used. |
| Action->Flow->Activity->inputMapper/input | flow  <-- "value" field  - all resolvers can be used |
| Action->Flow->Activity->inputMapper/output | activity input |
| Action->Flow->Activity->outputMapper/input | activity output |
| Action->Flow->Activity->outputMapper/output | flow |
| Link Expression | all resolvers can be used for link expressions. |

## Mapping Syntax

Flogo leverages a few simple syntax paradigms when mapping. The first being, the $ character is used when accessing/reading someone not within the immediate scope. For example, consider the following mapping.

```json
"actionMappings": {
  "input": [
    {
      "mapTo": "ISBN",
      "type": 1,
      "value": "pathParams.ISBN"
    }
  ]
```

The above mapping is from the Trigger/Handler, which we know, based on the resolver, we can only access trigger scoped (output) variables, thus pathParam is within the trigger scope and does not need any special characters when accessing.

What is you're accessing someone out of the immediate scope? The mapping should be prefixed with the $ special character, indicating to the resolver that we're accessing someone out of the immediate scope. For example, consider the following.

```json
"inputMappings": [
  {
    "type": 1,
    "value": "$flow.ISBN",
    "mapTo": "message"
  }
]
```

This mapping is associated with Action->Flow->Activity->inputMapper. We know that all resolvers can be used within the context, however none of the variables would be within the immediate scope, hence the $ should be used. For example, in the above snippet, we're grabbing the value of the flow variable named ISBN, hence $flow.ISBN is used. If we wanted to grab the value of an environment variable we could use $env.VarName.

### Accessing object properties

Most of the time you wont want to perform a direct assigning from one complex object to another, rather you'll want to grab a simple type property from one complex object and perform a direct assigning to another property. This can be done accessing children using a simple dot notation. For example, consider the following mapping.

```json
{
  "mapTo": "someResponse",
  "type": 4,
  "value": {
    "Title": "{{$activity[rest_3].result.items[0].volumeInfo.title}}",
    "PublishedDate": "{{$activity[rest_3].result.items[0].volumeInfo.publishedDate}}",
    "Description": "{{$activity[rest_3].result.items[0].volumeInfo.description}}"
  }
}
```
First note that this is from a Return activity, which is mapping a complex object (type 4) to a flow paramater named someResponse. The object we're accessing is from the response of an activity, this is fetched using the $activity scope. Consider one of the examples:

$activity[rest_3].result.items[0].volumeInfo.title

We're referencing the result property from the activity named rest_3. We're then accessing an items array (the first entry of the array) to another complex object, where finally we're at a simple string property named title.

## Recap

- A mapping without a special character indicates a locally scoped object
- A mappig with the $ indicates an object outside of the current scope
- Flow properties are accessible via: $flow.<PROPERTY_NAME>
- Activity output properties/objects are accessible via: $activity[<ACTIVITY_NAMER>].property
- Envrionment variables are accessible via: $env
