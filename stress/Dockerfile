FROM alpine:edge
RUN apk add stress --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted && rm -fr /var/lib/apk/*
ENTRYPOINT [ "stress" ]
