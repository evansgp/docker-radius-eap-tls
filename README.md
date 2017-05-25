# docker-radius-eap-tls

[freeradius](https://github.com/FreeRADIUS/freeradius-server/) with only EAP-TLS enabled.

This may be useful if you want to use WPA2-Enterprise on your WiFi.

# Usage (simple, from scratch, with defaults)

Create a client keypair; plus a CA, DH parameters and server keypair if they don't already exist:

```bash
docker build easyrsa -t easyrsa
docker run -it -v /your/pki/store:/easyrsa/pki easyrsa build-client-full client
```

Repeat for as many clients as you need. You may also need to export for a particular device (e.g. android wants the CA, cert and private key in one file):

```bash
docker run -it -v /your/pki/store:/easyrsa/pki easyrsa build-client-full android-phone
docker run -it -v /your/pki/store:/easyrsa/pki easyrsa export-p12 android-phone
```

Start the freeRADIUS server:

```
docker run -d -v /your/pki/store:/etc/raddb/certs -e CLIENT_ADDRESS=... -e CLIENT_SECRET=... -e PRIVATE_KEY_PASSWORD=... evansgp/radius-eap-tls
```

Now configure your wireless AP with the server IP and client secret.

# Usage

Keys and certificates are read from the volume /etc/raddb/certs.

The following environment variables are used:

- CLIENT_ADDRESS, where to accept connections from (i.e. your WiFi AP) (mandatory)
- CLIENT_SECRET, the password shared with your AP (mandatory)
- PRIVATE_KEY_PASSWORD, password for the private key (mandatory)
- PRIVATE_CERT, the filename of the private cert (default: server.crt)
- PRIVATE_KEY, filename of the private key (default: server.key)
- CA_CERT, filename of the CA certificate (default: ca.crt)
- DH_FILE, filename of the DH parameters (default: dh.pem)

# See also

[easy-rsa](https://github.com/OpenVPN/easy-rsa/) can quickly generate your certificates and keys.

# WARNING WARNING WARNING

This probably isn't secure and will most likely rape your dogs and kill your women.
