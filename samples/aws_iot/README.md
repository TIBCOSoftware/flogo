# Device Shadows for AWS IoT

A device shadow is a digital representation in the cloud that stores and retrieves current state information for a device. You can get and set the state of a device over MQTT or HTTP, even if the device isn't connected to the Internet.

## Building this app
### From the Web UI
You can upload the `flogo.json` file and update any configuration that you want. As you're building the app, please make sure you select `linux/arm` as the build target

### From the command line
To get started from the command line, download the `flogo.json` and update any variables you might want to update. Now, run `flogo create -f aws_iot.json awsapp` to create a new Flogo app with the name awsapp.

To build and run the app, execute
```
cd awsapp
flogo build -e
```

## Running the app
The AWS IoT Device Shadow service requires a very specific setup to make use of SSL certificates. You'll need to download the AWS IoT certificate and private key files and create on the below structure on disk:

```bash
├── <app>                   <-- Your Flogo app 
├── things                  <-- A folder called things 
│   ├── root-CA.pem.crt     <-- The AWS IoT root certificate (you'll have to rename it to 'root-CA.pem.crt')
│   ├── flogo               <-- The name of the thing name (in this case the thing would be called flogo)
│   │   ├── device.pem.crt  <-- The AWS IoT device certificate (you'll have to rename it to 'device.pem.crt')
│   │   ├── device.pem.key  <-- The AWS IoT private key (you'll have to rename it to 'device.pem.key')
```

After you start the app, you can send GET requests to it like `curl --request GET --url http://localhost:9999/awsiot/status --header 'content-type: application/json'`

## More information
If you're looking for a more in-depth overview of how the app is built, check out the [lab](http://tibcosoftware.github.io/flogo/labs/aws-iot/)
