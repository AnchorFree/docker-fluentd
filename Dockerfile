FROM fluent/fluentd:v0.14.25-debian

RUN apt-get update -y \
    && apt-get install ruby-dev build-essential dh-autoreconf libffi6 libffi-dev libsystemd-dev libsystemd0 -y \
    && gem install \
        fluent-plugin-elasticsearch -v 2.4.0 \
    && gem install \
        fluent-plugin-add-uuid \
    && gem install \
        fluent-plugin-record-reformer \
    && gem install \
        fluent-plugin-rewrite-tag-filter -v 2.0.0 \
    && gem install \
        fluent-plugin-multiprocess \
    && gem install \
        fluent-plugin-multi-format-parser \
    && gem install \
        fluent-plugin-prometheus \
    && gem install \
        fluent-plugin-systemd
