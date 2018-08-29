FROM alpine:latest
MAINTAINER Thomas Willems <twillems@willtho.com>

RUN apk add --update \
    avahi \
    samba-common-tools \
    samba-client \
    samba-server \
    supervisor \
    && sed -i 's/#enable-dbus=yes/enable-dbus=no/g' /etc/avahi/avahi-daemon.conf \
    && rm -rf /var/cache/apk/*


COPY setup.sh template_quota /tmp/
COPY smb.conf /etc/samba/smb.conf
COPY avahia.service /etc/avahi/services/timemachine.service
COPY supervisord.conf /etc/supervisord.conf
#RUN /tmp/setup.sh

VOLUME ["/timemachine"]
ENTRYPOINT ["/tmp/setup.sh"]
CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]