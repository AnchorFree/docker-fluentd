FROM fluent/fluentd:v1.11.5-debian-1.0

# Use root account to use apt
USER root

RUN buildDeps="sudo make gcc g++ libc-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps \
 && sudo gem install fluent-plugin-rewrite-tag-filter -v 2.3.0 \
 && sudo gem install fluent-plugin-systemd -v 1.0.2 \
 && sudo gem install fluent-plugin-multi-format-parser -v 1.0.0 \
 && sudo gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem
