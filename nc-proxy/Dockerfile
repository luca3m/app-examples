FROM alpine
RUN apk --update --no-cache add netcat-openbsd
ADD docker-entrypoint.sh /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
