---
title: Retry On Error
weight: 4320
---

## What is an Retry On Error in Flogo?

There are certain scenarios where a user would like to retry an activity when an error is encountered. To support this, a new feature **`Retry On Error`** has been included as part of release **0.9.4**. 

For this feature to function two areas need to be have configured:
1. Flow configuration
2. Runtime Code

### Flow configuration
For an activity to be configured with `Retry on error`, a new node **`"retryOnError"`** must be added to the settings of the activity. There are two configuration attributes available on the **`"retryOnError"`** node:

1. **`count:`**(int) The maximum number of times the activity can be retried in case of an error.
2. **`interval:`** (int) The time in milliseconds between each retry attempt.

By default, the value for `interval` is `0`, which implies each retry attempt will be executed immediately.
For example, a sample rest activity configured with `retryOnError` will look as below:
```json
{
  "id": "rest_3",
  "name": "REST Invoke",
  "description": "Invokes a REST Service",
  "settings": {
    "retryOnError": {
      "count": 3,
      "interval": 2000
    }
  },
  "activity": {
    "ref": "#rest",
    "settings": {
      "method": "GET",
      "uri": "https://jsceholder.typicode.com/users/1"
    }
  }
}
```
The above activity will be retried for a maximum of three consecutive times when an error occurs. The activity will sleep for an interval of 2000ms between each retry attempt.

### Runtime code

To make all functional the runtime code must return false with retriable error at eval method, engine will retry only on retriable error.

such as:
```go

	resp, err := client.Do(req)
	if err != nil {
		if err2, ok := err.(*url.Error); ok {
			// Return retriable error
			return false, activity.NewRetriableError(err2.Error(), "", nil)
		}
		log.Errorf("Failed to send request due to error: %s", err.Error())
		return false, err
	}

```
