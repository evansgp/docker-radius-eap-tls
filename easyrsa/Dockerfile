FROM alpine:3.6

RUN apk add --no-cache --upgrade openssl tar && \
    addgroup -g 101 radius && \
    adduser -u 100 -D -G radius radius

WORKDIR /easyrsa
COPY entrypoint.sh .
RUN wget -qO- https://github.com/OpenVPN/easy-rsa/releases/download/3.0.1/EasyRSA-3.0.1.tgz | tar xvz --strip-components=1 && \
    chmod u+x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
CMD ["help"]
