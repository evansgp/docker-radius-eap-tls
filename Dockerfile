FROM alpine:latest

RUN apk update && \
    apk upgrade && \
    apk add freeradius openssl && \
    rm /var/cache/apk/*

ENV CLIENT_ADDRESS CLIENT_SECRET \
    PRIVATE_CERT PRIVATE_KEY PRIVATE_KEY_PASSWORD \
    CA_CERT DH_FILE

RUN rm /etc/raddb/sites-enabled/* && \
    rm -rf /etc/raddb/certs

COPY radiusd.conf clients.conf /etc/raddb/
COPY eap /etc/raddb/mods-available
COPY site /etc/raddb/sites-available

RUN ln -s /etc/raddb/sites-available/site /etc/raddb/sites-enabled/site && \
    chgrp -R radius /etc/raddb/ && \
    mkdir /tmp/radiusd

EXPOSE 1812/udp
VOLUME /etc/raddb/certs

CMD ["/usr/sbin/radiusd", "-X","-f"]
