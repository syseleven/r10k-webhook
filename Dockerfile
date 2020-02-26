ARG        R10K_IMAGE=puppet/r10k:3.3.3

# webhook build taken from https://github.com/almir/docker-webhook/blob/e7ac3784dcdb8f2be5a92ef156abb53af6297592/Dockerfile
FROM       golang:alpine3.10 AS build
WORKDIR    /go/src/github.com/adnanh/webhook
ENV        WEBHOOK_VERSION 2.6.11
RUN        apk add --update -t build-deps curl libc-dev gcc libgcc
RUN        curl -L --silent -o webhook.tar.gz https://github.com/adnanh/webhook/archive/${WEBHOOK_VERSION}.tar.gz && \
           tar -xzf webhook.tar.gz --strip 1 &&  \
           go get -d && \
           go build -o /usr/local/bin/webhook && \
           apk del --purge build-deps && \
           rm -rf /var/cache/apk/* && \
           rm -rf /go

FROM       $R10K_IMAGE
USER       root
COPY       --from=build /usr/local/bin/webhook /usr/local/bin/webhook
COPY       hooks.json /etc/webhook/hooks.json
COPY       scripts/control /usr/local/bin/r10k-control
COPY       scripts/hieradata /usr/local/bin/r10k-hieradata
COPY       scripts/20-deploy.sh /docker-entrypoint.d/20-deploy.sh
COPY       scripts/docker-entrypoint.sh /docker-entrypoint.sh
RUN        mkdir /var/cache/r10k && \
           chown -R puppet: /var/cache/r10k

USER       puppet
VOLUME     "/etc/webhook" "/etc/puppetlabs/r10k" "/etc/puppetlabs/code"
EXPOSE     9000
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD        ["-template", "-hooks", "/etc/webhook/hooks.json", "-verbose"]
