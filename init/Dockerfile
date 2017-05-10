FROM fluent/fluentd:latest-onbuild
MAINTAINER YOUR_NAME <leahnpetersen@gmail.com>
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

USER root
RUN apk --no-cache --update add sudo build-base ruby-dev && \

    sudo -u fluent gem install fluent-plugin-secure-forward && \
    sudo -u fluent gem install fluent-plugin-kafka &&\
    sudo -u fluent gem install fluent-plugin-record-reformer && \
    sudo -u fluent gem install zookeeper && \
    sudo -u fluent gem install fluent-plugin-kubernetes_metadata_filter && \
    sudo apk add procps && \

    rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem && sudo -u fluent gem sources -c && \
    apk del sudo build-base ruby-dev && rm -rf /var/cache/apk/*

EXPOSE 24284

COPY start.sh /
RUN ["chmod", "+x", "/start.sh"]

USER root
CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT


