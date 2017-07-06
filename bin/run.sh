#!/bin/bash

DIR=$(dirname $(readlink -f $0))
. ${DIR}/tools.sh

info "$(date) Start container setup"

# fluentd config dir
FLUENTD_CONF_DIR=/fluentd/etc

if [[ $(curl --write-out %{http_code} --silent --output /dev/null "${ELASTIC_HOST}:9200/_template/fluentd") -eq 404 ]]; then
  curl -XPUT "${ELASTIC_HOST}:9200/_template/fluentd" -d@/fluentd-template.json
fi

# fluentd cast config from template
cd ${FLUENTD_CONF_DIR}

envtpl -o fluentd.conf fluentd.tpl || error "Failed to cast template"

rm -f ${FLUENTD_CONF_DIR}/*.tpl

uid=${FLUENT_UID:-1000}

# check if a old fluent user exists and delete it
cat /etc/passwd | grep fluent
if [ $? -eq 0 ]; then
    deluser fluent
fi

# (re)add the fluent user with $FLUENT_UID
adduser -D -g '' -u ${uid} -h /home/fluent fluent

# chown home and data folder
chown -R fluent /home/fluent
chown -R fluent /fluentd

fluentd -c ${FLUENTD_CONF_DIR}/fluentd.conf -p /fluentd/plugins $FLUENTD_OPT || error "Failed to run fluentd service"
