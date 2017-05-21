# docker-radius-eap-tls

[freeradius](https://github.com/FreeRADIUS/freeradius-server/) with only EAP-TLS enabled.

This may be useful if you want to use WPA2-Enterprise on your WiFi.

# WARNING WARNING WARNING

This probably isn't secure and will most likely rape your dogs and kill your women.

# Configuration

Keys and certificates are read from the volume /etc/raddb/certs.

The following environment variables are used by the Dockerfile:

- CLIENT_ADDRESS, the address of the client
- CLIENT_SECRET, the secret shared with the client
- PRIVATE_CERT, the private certificate
- PRIVATE_KEY, the private key (PEM) located in the volume
- PRIVATE_KEY_PASSWORD, password for the private key
- CA_CERT, the CA file
- DH_FILE, the DH parameters

# See also

[easy-rsa](https://github.com/OpenVPN/easy-rsa/) can quickly generate your certificates and keys.
