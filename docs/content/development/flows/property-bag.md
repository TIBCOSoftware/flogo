---
title: App Properties
weight: 4320
---

In Flogo, the concept of an application-level property bag is made available to flow developers that want to reuse properties across different flows, within the same application for trigger settings or as input to activities. Properties are exposed via the `$property` resolver and made available to the scopes defined in the [mappings]((../mapping/)) documentation.

### Flow configuration

Properties are defined within the root of the application json, as shown below via the **properties** element.

```json
{
  "name": "default_app",
  "type": "flogo:app",
  "version": "0.0.1",
  "description": "Sample flogo app",
  "properties": {
    "my_property": "My Property Value"
  }
  ```

As previously stated, properties are accessible via the `$property` resolver. Consider the following mappings into a log activity:

```json
{
  "id": "log_1",
  "name": "Logger",
  "description": "Simple Log Activity",
  "type": 1,
  "activityType": "github-com-tibco-software-flogo-contrib-activity-log",
  "activityRef": "github.com/TIBCOSoftware/flogo-contrib/activity/log",
  "attributes": [
  ],
  "inputMappings": [
    {
      "type": 1,
      "value": "$property.my_property",
      "mapTo": "message"
    }
  ]
}
```