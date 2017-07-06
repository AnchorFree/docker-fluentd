FROM fluent/fluentd:v0.14

RUN apk add --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install \
        fluent-plugin-elasticsearch \
 && sudo gem install \
        fluent-plugin-record-reformer \
 && sudo gem install \
        fluent-plugin-rewrite-tag-filter \
 && sudo gem install \
        fluent-plugin-multiprocess \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /home/fluent/.gem/ruby/2.3.0/cache/*.gem
