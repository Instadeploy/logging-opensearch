FROM fluent/fluentd:edge-debian-arm64

USER root

# Install plugins and dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ruby-dev \
    && gem install \
        fluent-plugin-opensearch \
        fluent-plugin-rewrite-tag-filter \
    && apt-get purge -y --auto-remove \
        build-essential \
        ruby-dev \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

# Copy configurations
COPY conf /fluentd/etc