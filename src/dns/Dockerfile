FROM alpine:latest

ARG DOMAIN
WORKDIR /dns

RUN apk add dnsmasq openvpn

COPY conf_templates/dnsmasq.conf /etc/dnsmasq.conf
COPY scripts/dns_wrapper.sh /dns/dns_wrapper.sh

RUN sed -i "s/__DOMAIN_NAME__/$DOMAIN/" /etc/dnsmasq.conf

CMD ["/dns/dns_wrapper.sh"]
