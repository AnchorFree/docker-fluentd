FROM fluent/fluentd:v0.14.15-debian

RUN apt-get update -y \
    && apt-get install ruby-dev build-essential dh-autoreconf libffi6 libffi-dev libsystemd-dev libsystemd0 -y \
    && gem install \
        fluent-plugin-elasticsearch \
    && gem install \
        fluent-plugin-record-reformer \
    && gem install \
        fluent-plugin-rewrite-tag-filter \
    && gem install \
        fluent-plugin-multiprocess \
    && gem install \
        fluent-plugin-multi-format-parser \
    && gem install \
        fluent-plugin-prometheus \
    && gem install \
        fluent-plugin-systemd
