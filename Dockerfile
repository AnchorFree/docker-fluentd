FROM fluent/fluentd:v1.0.2-debian

RUN apt-get update -y \
    && apt-get install python-pip -y \
    && pip install envtpl \
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
        fluent-plugin-systemd \
    && gem install \
        fluent-plugin-kubernetes_metadata_filter \
    && gem install \
        fluent-plugin-filter \
    && gem install \
        fluent-plugin-parser \
   && gem install \
        fluent-plugin-record-modifier 
