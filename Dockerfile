FROM alpine:latest

ARG CA_PASS

WORKDIR /vpn

COPY pkigen.sh add_client.sh server.conf /vpn/

RUN apk add openvpn easy-rsa

RUN /vpn/pkigen.sh

EXPOSE 1194/udp
