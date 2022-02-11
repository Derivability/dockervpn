FROM alpine:latest

ARG DOMAIN

WORKDIR /vpn

COPY scripts/* /vpn/scripts/
COPY conf_templates/server.conf /vpn/server.conf
COPY ccd/* /vpn/ccd/

RUN apk add openvpn easy-rsa &&\
sed -i 's/rm -rf \"\$EASYRSA_PKI\"/rm -rf \"\$EASYRSA_PKI\/\*\"/' /usr/share/easy-rsa/easyrsa &&\
sed -i "s/__DOMAIN__/$DOMAIN/" /vpn/server.conf &&\
chown nobody:nobody -R /vpn/ccd

EXPOSE 1194/udp

CMD ["openvpn", "server.conf"]
