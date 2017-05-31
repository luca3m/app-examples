FROM alpine
RUN apk add --no-cache --update g++
ADD stress.cpp /
RUN g++ -o stress -std=c++11 -pthread stress.cpp
FROM alpine
RUN apk add --no-cache --update libstdc++
COPY --from=0 /stress /
ENTRYPOINT [ "/stress" ]

