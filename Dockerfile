FROM golang:1.12

RUN apt-get update && apt-get -y install unzip && apt-get clean

# install protobuf
ENV PB_VER 3.7.0
ENV PB_URL https://github.com/google/protobuf/releases/download/v${PB_VER}/protoc-${PB_VER}-linux-x86_64.zip
RUN mkdir -p /tmp/protoc && \
    curl -L ${PB_URL} > /tmp/protoc/protoc.zip && \
    cd /tmp/protoc && \
    unzip protoc.zip && \
    cp /tmp/protoc/bin/protoc /usr/local/bin && \
    cp -R /tmp/protoc/include/* /usr/local/include && \
    chmod a+x /usr/local/bin/protoc && \
    cd /tmp && \
    rm -r /tmp/protoc

# install protoc-gen-go
RUN go get -u github.com/golang/protobuf/protoc-gen-go

# install protoc-gen-doc
RUN go get -u github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc

ENTRYPOINT ["/usr/local/bin/protoc", "-I/usr/local/include"]
