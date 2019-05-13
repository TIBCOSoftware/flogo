---
title: Mappings
weight: 4320
---

## What are mappings?

A mapping in Flogo can be used to assign the value of a parameter (flow input, for examle) to that of an input parameters of an activity or to the value of another flow scoped variable.

### Types of mappings

Flogo infers the mapping type based on the structure of the mapping itself. The following list details the specifics around each mapping type.

| Type | Description | Format |
| --- | --- | --- |
| literal | A literal mapping. For example, mapping the string "hello" to a string typed input. | Simply enclose your string literal in doubel quotes: \" \" |
| expression | Expression mapping.  This enable using functions and expression condition in mamping | The mapping string should begin with an equals character `=` | 
| object | Complex object. Used when a JSON-based object must be built and values assigned from other scoped properties/activity outputs. | See details below. |
| array | Array mapping. Mapping an Array of Objects. | See details below |

Mappings are quite straightforward, for example:

```json
{
  "isbn": "=$.event.isbn"
}
```

The above mapping indicates that the value of `evt.isbn` from a trigger input should be mapped to the action input named `isbn`. Consider two additional samples, below you will find a mapping to an activity from a `$flow` scoped property, a literal mapping, as well as an object type object mapping.

Type expression from a flow-scoped property

```json
{
  "isbn": "=$flow.isbn"
}
```

Type literal:

```json
{
  "isbn": "12937"
}
```

Type object:

```json
{
  "bookDetails": {
    "mapping": {
      "Author": "=$flow.author",
      "ISBN": "=$flow.name",
      "Price": "$20"
      }
  }
}
```
The literal mappings are pretty simple to understand, as are the flow scoped expression mappings. However type object does require a bit of an explanation. The `mapping` object is used to define how the object should be constructed and the various fields within the object mapped. This is done for performance reasons to avoid any unnecessary parsing of property values.

If you assign the value of an array then that param will be treated as an array, likewise for a string, int, etc. For example, let us pretend `$flow.Author` is an array, then the Author object would also be an array. In otherwords, direct assignment is occurring.

The WebUI insulates you frome much of this understanding and will infer the correct mapping type.


Additional type expression:

```json
{
  "data.description": "=string.concat(\"The pet category name is: \", $activity[rest_3].result.category.name)",
}
```

The above sample leverages the output of a REST Invoke activity to get [a pet](http://petstore.swagger.io/v2/pet/9233) from the public [petstore](http://petstore.swagger.io/) service.
The mapper uses a string concat function `string.concat(str1, str2, str3)` and assigns the function return to the `description` field.

Type array:

```json
Mapping sample here
```

Description of the mapping.

## Mapping Resolvers

Flogo will resolve mappings with the following reference. Note the scopes table below, which indicates what objects are accessible within what scope.

| Scope | Description |
| --- | --- |
| $env | Used to resolve an environment variable |
| $property | Used to resolve properties from the global application property bag |
| $flow | Used to resolve params from within the current flow. If a flow has a single trigger and no input params defined, then the output of the trigger is made available via $flow |
| $activity | Used to resolve activity params. Activities are referenced by id, for example, $activity[acivity_id].activity_property. |
| $iteration[key] && $iteration[value] | Used to resolve data scoped to a current iterator |

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

Flogo leverages a few simple syntax paradigms when mapping. The first being, the `$` character which is used when accessing/reading a property and the pre-fixed `.` indicates that the value is available within the current scope. For example, consider the following mapping:

```json
{
  "isbn": "=$.event.isbn"
}
```

The above mapping is from the Trigger/Handler, which we know, based on the indication of the `.`, we can only access trigger scoped (output) variables, thus `event.isbn` is within the trigger scope, as indicated by the preceding `.`.

What if you're accessing a property out of the immediate scope? The mapping should be prefixed with the `$` special character, indicating to the resolver that we're accessing a property out of the immediate scope. For example, consider the following.

```json
"input": {
  "message": "=string.concat(\"Hello \", $flow.name)"
}
```

This mapping is associated with Action->Flow->Activity->inputMapper. We know that all resolvers can be used within the context, however none of the variables would be within the immediate scope, hence the `$` should be used. For example, in the above snippet, we're grabbing the value of the flow variable named `name`, hence `$flow.name` is used. If we wanted to grab the value of an environment variable we could use `$env.VarName`.

### Accessing object properties

Most of the time you wont want to perform a direct assigning from one complex object to another, rather you'll want to grab a simple type property from one complex object and perform a direct assigning to another property. This can be done accessing children using a simple dot notation. For example, consider the following mapping.

```json
{
  "someObject": {
    "mapping": {
      "Title": "=$activity[rest_3].result.items[0].volumeInfo.title",
      "PublishedDate": "=$activity[rest_3].result.items[0].volumeInfo.publishedDate",
      "Description": "=$activity[rest_3].result.items[0].volumeInfo.description"
    }
  }
}
```
someObject is a type `object` and has the properties `Titie`, `PublishedDate`, `Description` which are being mapped from the response of an activity, this is fetched using the `$activity` scope. Consider one of the examples:

`$activity[rest_3].result.items[0].volumeInfo.title`

We're referencing the result property from the activity named rest_3. We're then accessing an items array (the first entry of the array) to another complex object, where finally we're at a simple string property named title.

### Using functions and expression

Most of time you want to add some custome logic to the mapping, such as concat/substring/length of a string or generate a random number base on a range and so on.  any logic you want to add you can come up with an function. Refer to the [functions repository](https://github.com/project-flogo/contrib/tree/master/function) for all available functions. Also note, you can install custom functions using the CLI's `flogo install` command.

```json
{
  "data.description": "string.concat(\"The pet category name is: \", $activity[rest_3].result.category.name)"
}
```

The function or expression condition can also use to link expreesion in branch, any functions that return a boolean can use in link expression.

```json
{
  "from": "log_2",
  "to": "log_4",
  "type": "expression",
  "value": "$activity[rest_3].result.category.name == \"BOOK\""
}

or
```

```json
{
  "from": "log_2",
  "to": "log_4",
  "type": "expression",
  "value": "string.len($flow.name) > 0"
}

```


### Hanlding arrays in mappings
TODO: UPDATE

There are lots of use cases for array mapping, map entire array to another or iterator partial array to another with functions
The array mapping value comes from a JSON format


```json
{
        "from": "$activity[rest_3].result.tags",
        "to": "data.response",
        "type": "foreach",
        "fields": [
            {
                "from": "$.id",
                "to": "$.id",
                "type": "primitive"
            },
            {
                "from": "string.concat($activity[rest_4].result.category.name, $.name)",
                "to": "$.name",
                "type": "primitive"
            }
        ]
 }
```

- **from**: Previous activity's array output field
- **to**: current activity's input array field
- **type**: foreach indicate iterator array element
- **fields**: list all element field that use to iterator and assign.
   - **from**: the value comes from
   - **to**:  to the current element, $. indicate current element.
   - **type**: The type either primitive or foreach. foreach mean another array mapping. nest array support without deep limitation


If you want to only create one element of array. using NEWARRAY for from field.

```
{
    "fields": [
        {
            "from": "10001",
            "to": "$.id",
            "type": "primitive"
        },
        {
            "from": "$activity[rest].result.category.name",
            "to": "$.name",
            "type": "primitive"
        }
    ],
    "from": "NEWARRAY",
    "to": "data.response",
    "type": "foreach"
}
```

Note:
You can use any literal string, functions, expression in **from** under fields node.