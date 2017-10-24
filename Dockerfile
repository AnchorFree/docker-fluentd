FROM fluent/fluentd:v0.14

RUN apk add --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install \
        fluent-plugin-elasticsearch \
        fluent-plugin-record-reformer \
        fluent-plugin-rewrite-tag-filter \
        fluent-plugin-multiprocess \
        fluent-plugin-multi-format-parser \
        redis \
        gcra \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /home/fluent/.gem/ruby/2.3.0/cache/*.gem

COPY ./plugins/* /fluentd/plugins/
