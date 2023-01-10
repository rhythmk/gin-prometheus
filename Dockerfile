FROM golang:1.18-alpine AS builder

COPY . /app
WORKDIR /app
RUN go env -w GO111MODULE=on \
    &&  go env -w GOPROXY=https://goproxy.io,direct \
    &&  go mod download 
    
RUN go  build -o  app main.go  


FROM alpine:3.17.0 AS runtime
RUN echo "export LANG=en_US.UTF-8" > /etc/profile.d/locale.sh \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update && apk --no-cache add tzdata \
    && cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN mkdir -p /usr/local
WORKDIR /usr/local
COPY --from=builder /app/app /usr/local/app

EXPOSE 4567

ENTRYPOINT ["./app"]