FROM alpine:latest

ARG CA_PASS

WORKDIR /vpn

COPY scripts/* /vpn/scripts/
COPY conf_templates/server.conf /vpn/server.conf

RUN apk add openvpn easy-rsa &&\
/vpn/scripts/pkigen.sh 

EXPOSE 1194/udp

CMD ["openvpn", "server.conf"]
