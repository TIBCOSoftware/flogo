---
title: Serverless Framework
hidden: true
---

Building serverless apps is awesome! As a developer you don't have to worry about provisioning or maintaining servers, and you only have to create the code that you need to power your next business idea! Deploying such apps is made super easy by the team at [Serverless Framework](https://serverless.com).With the Serverless Framework, you can configure which events should trigger it, where to deploy it and what kind of resources it is allowed to use without going into the AWS console.

## What you'll need

### Serverless Framework

You'll need to have the [Serverless Framework](https://serverless.com/framework/docs/providers/aws/guide/quick-start/) installed. If you haven't done that yet, now would be a great time to do so!

### AWS account

To finally deploy your apps you'll need an [AWS account](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html). If you haven't signed up yet, this would be a great time to do that too.

## Step 1: Using the template

The first step is to create a sample project based on the Flogo template.

```bash
serverless create -u https://github.com/tibcosoftware/flogo/tree/master/serverless -p myservice
```

That command just generated a bunch of files for you

```bash
myservice                       <-- A new directory with the name of your service
├── hello                       <-- A folder with the sources of your function
│   ├── function.go             <-- A Hello World function
│   └── main.go                 <-- The Lambda trigger code, created by Flogo
├── .gitignore                  <-- A .gitignore file to ignore the things you don't want in git
├── Makefile                    <-- A Makefile to build and deploy even faster
├── README.md                   <-- A quickstart guide
└── serverless.yaml             <-- The Serverless Framework template
```

The content of `main.go` comes directly from the [Lambda trigger](https://github.com/TIBCOSoftware/flogo-contrib/tree/master/trigger/lambda). The `function.go` file has three methods that make up the entire app

* **init**: The init method makes sure that everything is ready to go. It sets the default loglevels, creates an app by calling `shimApp()` and ultimately starts the engine
* **shimApp**: shimApp is used to build a new Flogo app and register the Lambda trigger with the engine. The shimapp is used by the shim, which triggers the engine every time an event comes into Lambda. It registers the method that it should call each time and in this case that method is `RunActivities`
* **RunActivities**: RunActivities is where the magic happens. This is where you get the input from any event that might trigger your Lambda function in a map called evt (which is part of the inputs). The sample will simply log "Go Serverless v1.x! Your function executed successfully!" and return the same as a response. The trigger, in main.go, will take care of marshalling it into a proper response for the API Gateway

## Step 2: Build and Deploy

To build the executable that you want to deploy to Lambda, you can run `make` or `make build`. That command, in turn, executes two other commands:

* `go generate ./...`: In order to run the activities and triggers that you have uses, the Flogo engine needs to have all the metadata available. This command generates the metadata so that it can be compiled into the executable
* `env GOOS=linux go build -ldflags="-s -w" -o bin/hello hello/*.go`: This command creates the executable (which should run on Linux) from the sources in the _hello_ folder and stores the result (a file called _hello_) in the **bin** folder.

To deploy the app run `make deploy` or, if you don't want to use make, run `sls deploy --verbose` to get the same result. This command will deploy your function to AWS Lambda.

The output on your screen will have something like what is pasted below:

```bash
<snip>
Service Information
service: myservice
stage: dev
region: us-east-1
stack: myservice-dev
api keys:
  None
endpoints:
  GET - https://xxx.execute-api.us-east-1.amazonaws.com/dev/hello
functions:
  hello: myservice-dev-hello
<snip>
```

## Step 3: Test it

Using cURL you can test your new function

```bash
curl --request GET --url https://xxx.execute-api.us-east-1.amazonaws.com/dev/hello --header 'content-type: application/json'
```

The above command will call your function and return a result:

```json
{"message": "Go Serverless v1.x! Your function executed successfully!"}
```

## Step 4: Adding a POST operation

That was pretty easy, and pretty cool, but not really useful. The next step is all about updating the code to not only handle `GET`, but also `POST` operations and provide a more _personalized_ response.

The first thing is to update the `serverless.yml` file with a new event handler. Around line 58 of the file you'll find the events and the types of events that can trigger your app. It already has an entry for `GET`, copy and paste that and change the method to `POST`.

```yaml
functions:
  hello:
    handler: bin/hello
    events:
      - http:
          path: hello
          method: get
      - http:
          path: hello
          method: post
```

## Step 5: Build the code

The second part is to update the `RunActivities` method. In this step you'll walk through the entire method.

In order to distinguish the two HTTP methods, you'll have to look at the `httpMethod` element of the incoming message:

```golang
// Get the HTTP method from the event
method := inputs["evt"].Value().(map[string]interface{})["httpMethod"].(string)

// Create a variable for the message
var message string

// Decide which way to take
switch method {
case "GET":

case "POST":

}
```

Creating the response, so after the switch statement is completed, will still be the same:

```golang
// Using a Flogo activity to log the message
in := map[string]interface{}{"message": message}
_, err := flogo.EvalActivity(&log.LogActivity{}, in)
if err != nil {
    return nil, err
}

// The response from the Lambda function is always in the form of a JSON message.
// In this case we're creating a structure with a single element called
// message
responseData := make(map[string]interface{})
responseData["message"] = message

// Because we're sending the result back to the API Gateway, it will expect to have
// both an HTTP result code (called code) and some response data. In this case we're
// sending back the data object we created earlier
response := make(map[string]*data.Attribute)
response["code"], _ = data.NewAttribute("code", data.TypeInteger, 200)
response["data"], _ = data.NewAttribute("data", data.TypeAny, responseData)

return response, nil
```

In case of a GET operation, the message should still be the same. You can update the GET part by pasting in `message = "Go Serverless v1.x! Your function executed successfully!"`

In case of a POST operation, the message will be a little different. In that case you want to reply with the name of the person that called your function.

```golang
// API Gateway passes in the body as a string, so the first step
// is to parse the body to a JON object, or map[string]interface{} in Go
var eventBody map[string]interface{}
if err := json.Unmarshal([]byte(inputs["evt"].Value().(map[string]interface{})["body"].(string)), &eventBody); err != nil {
    return nil, err
}

// The message you want to log
message = fmt.Sprintf("%v is going all in on Serverless v1.x!", eventBody["name"])
```

Putting everything together, the new method will look like

```golang
// Get the HTTP method from the event
method := inputs["evt"].Value().(map[string]interface{})["httpMethod"].(string)

// Create a variable for the message
var message string

// Decide which way to take
switch method {
case "GET":
    message = "Go Serverless v1.x! Your function executed successfully!"
case "POST":
    // API Gateway passes in the body as a string, so the first step
    // is to parse the body to a JON object, or map[string]interface{} in Go
    var eventBody map[string]interface{}
    if err := json.Unmarshal([]byte(inputs["evt"].Value().(map[string]interface{})["body"].(string)), &eventBody); err != nil {
        return nil, err
    }

    // The message you want to log
    message = fmt.Sprintf("%v is going all in on Serverless v1.x!", eventBody["name"])
}

// Using a Flogo activity to log the message
in := map[string]interface{}{"message": message}
_, err := flogo.EvalActivity(&log.LogActivity{}, in)
if err != nil {
    return nil, err
}

// The response from the Lambda function is always in the form of a JSON message.
// In this case we're creating a structure with a single element called
// message
responseData := make(map[string]interface{})
responseData["message"] = message

// Because we're sending the result back to the API Gateway, it will expect to have
// both an HTTP result code (called code) and some response data. In this case we're
// sending back the data object we created earlier
response := make(map[string]*data.Attribute)
response["code"], _ = data.NewAttribute("code", data.TypeInteger, 200)
response["data"], _ = data.NewAttribute("data", data.TypeAny, responseData)

return response, nil
```

## Step 6: Build and Deploy

To build and deploy the updates you can use one command: `make deploy`. This command will build the new executable and deploy your function to AWS Lambda.

The output on your screen will have something like what is pasted below:

```bash
<snip>
Service Information
service: myservice
stage: dev
region: us-east-1
stack: myservice-dev
api keys:
  None
endpoints:
  GET - https://xxx.execute-api.us-east-1.amazonaws.com/dev/hello
  POST - https://xxx.execute-api.us-east-1.amazonaws.com/dev/hello
functions:
  hello: myservice-dev-hello
<snip>
```

## Step 7: Test it... again

Using cURL you can test that your function still works for a GET operation. The command

```bash
curl --request GET --url https://xxx.execute-api.us-east-1.amazonaws.com/dev/hello --header 'content-type: application/json'
```

Should still respond with:

```json
{"message": "Go Serverless v1.x! Your function executed successfully!"}
```

When you POST a message, though

```bash
curl --request POST --url https://xxx.execute-api.us-east-1.amazonaws.com/dev/hello --header 'content-type: application/json' --data '{"name": "Flogo"}'
```

The result should be different

```json
{"message": "Flogo is going all in on Serverless v1.x!"}
```
