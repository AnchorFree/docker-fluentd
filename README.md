# General description

This container provide Logstash container for logging solution. Logstash helps you parse logs from hosts.

### File description

 * bin/run.sh - shell wrapper for Logstash entrypoint. It casts *.tpl config template file
 * bin/tools.sh - tools for error handling in shell scripts
 * config/templates/{filter,input,output}.tpl - Logstash pipeline templates (input, filter, output)
 * config/templates/{filter,input,output}/{filter,input,output}-{project}.tpl - descrides pipeline settings for each team
 * config/jvm.options - JVM options
 * config/logstash-template.json - Logstash index template for Elasticsearch
 * Dockerfile - docker container make file
 * Makefile - helps you build and push docker images to Docker Hub

## Container installation

 1. Clone this repository
 2. Build and push Logstash image

```bash
make all && make prod
```
 3. [packer-elk](https://github.com/AnchorFree/packer-elk) repository helps you with container creation on host
