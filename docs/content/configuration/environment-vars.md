---
title: Environment variables
weight: 3010
pre: "<i class=\"fa fa-cog\" aria-hidden=\"true\"></i> "
---


List of environment variables to configure the flogo engine

| Environment name      | Default value             | Info                                      |
| --------------------- |:-------------------------:|------------------------------------------ |
| FLOGO_LOG_DTFORMAT    | "2006-01-02 15:04:05.000" | Sets the log date and time format         |
| FLOGO_LOG_LEVEL       | "INFO"                    | Sets the log level                        |
| FLOGO_RUNNER_TYPE     | "POOLED"                  | Sets the type of the runner               |
| FLOGO_RUNNER_WORKERS  | 5                         | Sets the number of workers                |
| FLOGO_RUNNER_QUEUE    | 50                        | Sets the runner queue size                |
| FLOGO_CONFIG_PATH     | "flogo.json"              | Sets the path of the config json file     |
| STOP_ENGINE_ON_ERROR  | true                      | Sets whether to stop the engine on error  |