FROM alpine:3.5

RUN apk add --no-cache --upgrade openssl tar

WORKDIR /easyrsa

RUN wget -qO- https://github.com/OpenVPN/easy-rsa/releases/download/3.0.1/EasyRSA-3.0.1.tgz | tar xvz --strip-components=1

COPY entrypoint.sh .
RUN chmod u+x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
CMD ["help"]
