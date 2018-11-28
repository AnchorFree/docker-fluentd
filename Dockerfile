FROM fluent/fluentd:v1.3.1-debian-onbuild

RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev libffi-dev libsystemd-dev python-setuptools python-pip" \
    && apt-get update \
    && apt-get install -y --no-install-recommends $buildDeps libsystemd0 libffi6 \
    && pip install wheel \
    && pip install envtpl \
    && gem install fluent-plugin-elasticsearch -v 2.12.2 \
    && gem install fluent-plugin-add-uuid \
    && gem install fluent-plugin-record-reformer \
    && gem install fluent-plugin-rewrite-tag-filter -v 2.1.1 \
    && gem install fluent-plugin-multiprocess \
    && gem install fluent-plugin-multi-format-parser \
    && gem install fluent-plugin-prometheus \
    && gem install fluent-plugin-systemd \
    && gem install fluent-plugin-kubernetes_metadata_filter \
    && gem install fluent-plugin-filter \
    && gem install fluent-plugin-parser \
    && gem install fluent-plugin-record-modifier  \
    && sudo gem sources --clear-all \
    && SUDO_FORCE_REMOVE=yes apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps \
    && rm -rf /var/lib/apt/lists/* /home/fluent/.gem/ruby/2.3.0/cache/*.gem
