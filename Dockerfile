FROM ubuntu:14.04

ADD install /tmp/install

RUN apt-get update \
  apt-get install -y \
    haproxy \
    polipo \
    tor \
    ruby \
  && bash /tmp/install/install.sh \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && rm -rf /var/tmp/*

EXPOSE 8123

CMD ["/root/boot.sh"]

