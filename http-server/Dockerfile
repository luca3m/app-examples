FROM golang:alpine AS build
ADD main.go /http-server/
WORKDIR /http-server
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' . 
FROM scratch
EXPOSE 8080
COPY --from=build /http-server /
ENTRYPOINT [ "/http-server" ]
