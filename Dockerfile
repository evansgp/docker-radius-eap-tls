FROM alpine:3.5

RUN apk add --no-cache freeradius openssl

ENV PRIVATE_CERT=issued/server.crt PRIVATE_KEY=private/server.key \
    CA_CERT=ca.crt DH_FILE=dh.pem

COPY radiusd.conf clients.conf /etc/raddb/
COPY eap /etc/raddb/mods-available
COPY site /etc/raddb/sites-available

RUN rm /etc/raddb/sites-enabled/* && \
    rm -rf /etc/raddb/certs && \
    ln -s /etc/raddb/sites-available/site /etc/raddb/sites-enabled/site && \
    mkdir /tmp/radiusd && \
    chown radius:radius /tmp/radiusd

VOLUME /etc/raddb/certs
RUN chgrp -R radius /etc/raddb/

EXPOSE 1812/udp
USER radius

ENTRYPOINT ["/usr/sbin/radiusd"]
CMD ["-X", "-f"]
