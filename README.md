# radius-eap-tls

[FreeRADIUS](https://github.com/FreeRADIUS/freeradius-server/) with only EAP-TLS enabled.

This may be useful if you want to use AES on your WiFi.

# Usage

See [below](#simple-setup) for a quick way to create your [PKI](https://en.wikipedia.org/wiki/Public_key_infrastructure) or [supply your own](#configuration), then run:

```
docker run -d -p 1812:1812/udp --restart=always -v pki:/etc/raddb/certs -e CLIENT_ADDRESS=... -e CLIENT_SECRET=... -e PRIVATE_KEY_PASSWORD=... evansgp/radius-eap-tls
```

# Configuration

Keys and certificates are read from /etc/raddb/certs which is exposed as a volume.

Radius is listening on port 1812 UDP.

The following environment variables are used:

- CLIENT_ADDRESS, where to accept connections from (i.e. your AP) (mandatory)
- CLIENT_SECRET, the password shared with your AP (mandatory)
- PRIVATE_KEY_PASSWORD, password for the private key (mandatory)
- PRIVATE_CERT, the filename of the private cert (default: issued/server.crt)
- PRIVATE_KEY, filename of the private key (default: private/server.key)
- CA_CERT, filename of the CA certificate (default: ca.crt)
- DH_FILE, filename of the DH parameters (default: dh.pem)

# Simple setup

Running the following will create each file not already present in the volume, prompting for input where required and leaving things in the [default](#configuration) locations:
- CA certificate and key
- DH parameters
- Server certificate and key
- Client certificate and key for an entity named `laptop`

```bash
git clone git@github.com:evansgp/docker-radius-eap-tls.git
cd docker-radius-eap-tls
docker build easyrsa -t easyrsa
docker run -it -v pki:/easyrsa/pki easyrsa build-client-full laptop
```

Repeat for as many clients as you need, supplying a unique name each time. Copy the `ca.crt`, `issued/laptop.crt` and `private/laptop.key` to the client (for e.g.). Some devices require their keys in a different format, for example Android OS, which you can export using:

```bash
docker run -it -v pki:/easyrsa/pki easyrsa build-client-full android-phone
docker run -it -v pki:/easyrsa/pki easyrsa export-p12 android-phone
```

Import `private/android-phone.p12` to your device.

Now configure your AP with WPA2 Enterprise, AES, the server IP and client secret.

# See also

[easy-rsa](https://github.com/OpenVPN/easy-rsa/) can quickly generate your certificates and keys.

# WARNING WARNING WARNING

This probably isn't secure and will most likely rape your dogs and kill your women.

Look after your PKI.
