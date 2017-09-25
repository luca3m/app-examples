FROM alpine AS build
RUN apk add --update --no-cache alpine-sdk
ADD gettimeofday.c /
RUN gcc gettimeofday.c -static -o gettimeofday
RUN strip gettimeofday
FROM scratch
STOPSIGNAL 9
COPY --from=build /gettimeofday /
ENTRYPOINT [ "/gettimeofday" ]
