#!/usr/bin/env sh

set -e
set -u

[ ! -t 0 ] && echo "Some commands may be interactive ('docker run -it easyrsa $@')..." && exit

# in lieue of './easyrsa init-pki` since pki/ is (probably) a mount and easyrsa will try to delete it
[ ! -d pki/private ] && mkdir pki/private
[ ! -d pki/reqs ] && mkdir pki/reqs

[ ! -f pki/dh.pem ] && ./easyrsa gen-dh
[ ! -f pki/ca.crt ] && ./easyrsa build-ca
[ ! -f pki/private/server.key ] && ./easyrsa build-server-full server

./easyrsa $@

chown -R radius:radius pki
