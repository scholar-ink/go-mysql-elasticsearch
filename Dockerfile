FROM golang:alpine

MAINTAINER sholar-ink

RUN apk add --no-cache tini mariadb-client

ADD . /go/src/github.com/sholar-ink/go-mysql-elasticsearch

RUN apk add --no-cache mariadb-client
RUN cd /go/src/github.com/sholar-ink/go-mysql-elasticsearch/ && \
    go build -o bin/go-mysql-elasticsearch ./cmd/go-mysql-elasticsearch && \
    cp -f ./bin/go-mysql-elasticsearch /go/bin/go-mysql-elasticsearch

EXPOSE 12800

ENTRYPOINT ["/sbin/tini","--","go-mysql-elasticsearch"]
