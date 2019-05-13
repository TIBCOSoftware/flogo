---
title: Environment variables
weight: 3010
pre: "<i class=\"fas fa-cog\" aria-hidden=\"true\"></i> "
---


List of environment variables to configure the flogo engine

| Environment name            | Default value             | Info                                      |
| --------------------------- |:-------------------------:|------------------------------------------ |
| FLOGO_LOG_DTFORMAT          | "2006-01-02 15:04:05.000" | Sets the log date and time format         |
| FLOGO_LOG_LEVEL             | "INFO"                    | Sets the log level                        |
| FLOGO_RUNNER_TYPE           | "POOLED"                  | Sets the type of the runner               |
| FLOGO_RUNNER_WORKERS        | 5                         | Sets the number of workers                |
| FLOGO_RUNNER_QUEUE          | 50                        | Sets the runner queue size                |
| FLOGO_CONFIG_PATH           | "flogo.json"              | Sets the path of the config json file     |
| FLOGO_ENGINE_STOP_ON_ERROR  | true                      | Sets whether to stop the engine on error  |
| FLOGO_APP_PROP_RESOLVERS | None | The property resolver to use at runtime. Refer to the documentation for [application properties](https://tibcosoftware.github.io/flogo/development/flows/property-bag/) |
| FLOGO_SCHEMA_SUPPORT |  | |
| FLOGO_SCHEMA_VALIDATION | None | |