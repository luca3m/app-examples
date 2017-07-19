FROM alpine
RUN apk add --update --no-cache htop
ADD htoprc /root/.config/
ENTRYPOINT [ "htop" ]
