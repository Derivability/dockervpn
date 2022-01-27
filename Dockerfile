FROM alpine:latest

ARG CA_PASS

WORKDIR /vpn

COPY pkigen.sh add_client.sh server.conf /vpn/

RUN apk add openvpn easy-rsa &&\
/vpn/pkigen.sh 

#RUN mkdir -p /dev/net &&\
#mknod /dev/net/tun c 10 200 &&\
#chmod 600 /dev/net/tun

EXPOSE 1194/udp

CMD ["openvpn", "server.conf"]
