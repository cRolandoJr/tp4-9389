FROM docker.io/library/alpine:3.22
RUN apk add --no-cache goaccess \
    && addgroup -g 10001 analyzer \
    && adduser -D -H -u 10001 -G analyzer analyzer \
    && mkdir -p /srv/logs /srv/reports \
    && chown analyzer:analyzer /srv/reports
USER analyzer
ENTRYPOINT ["goaccess", "/srv/logs/access.log", "--config-file=/etc/goaccess/goaccess.conf"]
