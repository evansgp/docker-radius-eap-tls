FROM alpine:3.5

RUN apk add --no-cache freeradius openssl

ENV CLIENT_ADDRESS CLIENT_SECRET PRIVATE_KEY_PASSWORD \
    PRIVATE_CERT=servert.crt PRIVATE_KEY=server.key \
    CA_CERT=ca.crt DH_FILE=dh.pem

COPY radiusd.conf clients.conf /etc/raddb/
COPY eap /etc/raddb/mods-available
COPY site /etc/raddb/sites-available

RUN rm /etc/raddb/sites-enabled/* && \
    rm -rf /etc/raddb/certs && \
    ln -s /etc/raddb/sites-available/site /etc/raddb/sites-enabled/site && \
    chgrp -R radius /etc/raddb/ && \
    mkdir /tmp/radiusd

EXPOSE 1812/udp
VOLUME /etc/raddb/certs

USER radius

ENTRYPOINT ["/usr/sbin/radiusd"]
CMD ["-X", "-f"]
