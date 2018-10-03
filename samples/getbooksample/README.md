# Books

Who doesn't like a good book? But what if you really, really need to get some information about a book first? In that case you build a Flogo app that uses the Google APIs to get book information!

## Building this app
### From the Web UI
To load this app into the Flogo Web UI, you can upload the `getbooks.json` file and update the configuration you want.

### From the command line
To get started from the command line, download the `getbooks.json` and update any variables you might want to update. Now, run `flogo create -f getbooks.json booksapp` to create a new Flogo app with the name booksapp.

To build and run the app, execute
```
cd booksapp
flogo build -e
./bin/booksapp
```

## Get some book details
After you start the app, open a new terminal window and execute
```
curl --request GET --url http://localhost:9999/books/0747532699
```

_This will get you information on Harry Potter 1 and the Philosopher's Stone_

## More information
If you're looking for a more in-depth overview of how the app is built, check out the [lab](https://tibcosoftware.github.io/flogo/labs/bookstore/)
