---
layout: page
title: “Environment variables”
category: guide
---

List of environment variables to configure the flogo engine

| Environment name      | Default value             | Info                                  |
| --------------------- |:-------------------------:|-------------------------------------- |
| flogo_log_dtformat    | "2006-01-02 15:04:05.000" | Sets the log date and time format     |
| flogo_log_level       | "INFO"                    | Sets the log level                    |
| flogo_runner_type     | "POOLED"                  | Sets the type of the runner           |
| flogo_runner_workers  | 5                         | Sets the number of workers            |
| flogo_runner_queue    | 50                        | Sets the runner queue size            |
| flogo_config_path     | "flogo.json"              | Sets the path of the config json file |