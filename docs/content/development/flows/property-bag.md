---
title: App Properties
weight: 4320
---

In Flogo, the concept of an application-level property bag is made available to flow developers that want to reuse properties across different flows, within the same application for trigger settings or as input to activities. Properties are exposed via the `$property` resolver and made available to the scopes defined in the [mappings](../mapping/) documentation.

### Flow configuration

Properties are defined within the root of the application json, as shown below via the **properties** element.

```json
{
  "name": "default_app",
  "type": "flogo:app",
  "version": "0.0.1",
  "description": "Sample flogo app",
  "properties": [
     {
       "name": "my_property",
       "type": "string",
       "value": "My Property Value"
     }
  ]
  ```

As previously stated, properties are accessible via the `$property` resolver. Consider the following mappings into a log activity:

```json
{
  "id": "log_2",
  "name": "Log",
  "description": "Logs a message",
  "activity": {
    "ref": "#log",
    "input": {
      "addDetails": false,
      "message": "=$property[my_property]"
    }
  }
}
```

### Grouping of properties
You can create an artifical grouping of related properties by using **<group1>.<group2>....<groupn>.<name>** naming convention. Note that property keys are still simply string literals, the engine does not do any grouping.

```json
{
  "name": "default_app",
  "type": "flogo:app",
  "version": "0.0.1",
  "description": "Sample flogo app",
  "properties": [
     {
       "name": "PURCHASE.SERVICE.DB.URL",
       "type": "string",
       "value": "postgres://10.10.10.10:5370/mydb"
     },
     {
       "name": "PURCHASE.SERVICE.DB.USER",
       "type": "string",
       "value": "testuser"
     },
     {
        "name": "INVENTORY.SERVICE.DB.URL",
        "type": "string",
        "value": "postgres://10.10.10.20:5370/mydb"
     },
     {
        "name": "INVENTORY.SERVICE.DB.USER",
        "type": "string",
        "value": "testuser"
     }
  ]
  ```

These properties can be accessed via $property[PURCHASE.SERVICE.DB.URL] or $property[INVENTORY.SERVICE.DB.URL]

### Overriding app properties at runtime

You can override app properties at runtime in two ways:

#### Using JSON

Define your new value for a given app prop in a json file as shown below:

props.json
{
 "MyProp1": "This is new value",
 "MyProp2": 20
}

Run app with the environment variable `FLOGO_APP_PROPS_OVERRIDE` set to `props.json`. For example:

```terminal
FLOGO_APP_PROPS_OVERRIDE=props.json ./MyApp
```

#### Using Key/Value pair

Run app with the environment variable `FLOGO_APP_PROPS_OVERRIDE` set to the key/value pairs. For example:

```terminal
FLOGO_APP_PROPS_OVERRIDE="MyProp1=This is newvalue,MyProp2=30" ./MyApp
```

### Working with external configuration management services

You can plug-in your own value resolver to resolve application property value from external configuration management services, such as, Consul, Spring Cloud Config etc. Just implement the following interface and register implementation with the runtime:

```go
// PropertyValueResolver used to resolve value from external configuration like env, file etc
type PropertyValueResolver interface {
	// Should return value and true if the given application property exists in the external configuration otherwise should return nil and false.
	LookupValue(propertyName string) (interface{}, bool)
}
```

#### Sample Resolver

```go
package sampleresolver

type SamplePropertyResolver struct {
}

func init() {
  app.RegisterPropertyValueResolver("sampleresolver", &SamplePropertyResolver{})
}

func (resolver *SamplePropertyResolver) LookupValue(propertyName string) (interface{}, bool) {
   // Resolve property value
  return some_value, true
}
```

Set the `FLOGO_APP_PROPS_RESOLVERS` env var to `sampleresolver` while running application. For example:

```terminal
FLOGO_APP_PROPS_RESOLVERS=sampleresolver ./<app_binary>
```