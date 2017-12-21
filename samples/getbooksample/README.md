# GetBookSample
This sample Flogo application is used to demonstrate some key Flogo constructs:

- Multi trigger support in flows
- Input/Output mappings
- Complex object mapping

## Building the app
To build via the Flogo CLI, simply download the GetBookSample.json to your local machine and create the app structure:

```{r, engine='bash', count_lines}
flogo create -f ~/Downloads/GetBookSample.json
cd GetBookSample
```

You can now build the application or target a specific trigger as the entry point. When targeting a specific trigger, the resulting binary will include only the flow(s) where the trigger is mapped will be included. This is required when building the application to target AWS Lambda as the deployment target.

Otherwise, simply build the application and leverage the HTTP REST trigger as the entry point to your folow:

```{r, engine='bash', count_lines}
flogo build -e
```

The -e switch indicates that the binary should embed the flogo.json.

## Run the application

Now that the application has been built, run the application:

```{r, engine='bash', count_lines}
cd bin
./GetBookSample
```

Test the application by opening your browser or via CURL and getting the following URL: http://localhost:9099/isbn:0747532699

The following result should appear:

```json
{"Description":"Harry Potter is an ordinary boy who lives in a cupboard under the stairs at his Aunt Petunia and Uncle Vernon's house, which he thinks is normal for someone like him who's parents have been killed in a 'car crash'. He is bullied by them and his fat, spoilt cousin Dudley, and lives a very unremarkable life with only the odd hiccup (like his hair growing back overnight!) to cause him much to think about. That is until an owl turns up with a letter addressed to Harry and all hell breaks loose! He is literally rescued by a world where nothing is as it seems and magic lessons are the order of the day. Read and find out how Harry discovers his true heritage at Hogwarts School of Wizardry and Witchcraft, the reason behind his parents mysterious death, who is out to kill him, and how he uncovers the most amazing secret of all time, the fabled Philosopher's Stone! All this and muggles too. Now, what are they?","PublishedDate":"1997","Title":"Harry Potter 1 and the Philosopher's Stone"}
```
