FROM alpine AS build
RUN apk add --update --no-cache alpine-sdk
ADD pause.c /
RUN gcc -o pause pause.c
FROM alpine
COPY --from=build /pause /
ENTRYPOINT [ "/pause" ]
