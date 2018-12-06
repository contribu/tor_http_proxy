FROM ubuntu:14.04

# https://www.torproject.org/docs/debian.html.en
RUN apt-get update \
  && apt-get install -y \
    apt-transport-https \
    haproxy \
    polipo \
    tor \
    ruby \
  && echo deb https://deb.torproject.org/torproject.org trusty main >> /etc/apt/sources.list \
  && echo deb-src https://deb.torproject.org/torproject.org trusty main >> /etc/apt/sources.list \
  && gpg --keyserver hkp://pool.sks-keyservers.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 \
  && gpg --keyserver hkp://pool.sks-keyservers.net --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add - \
  && apt update \
  && apt install -y \
    deb.torproject.org-keyring \
    tor \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && rm -rf /var/tmp/*

ADD install /tmp/install

RUN bash /tmp/install/install.sh \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && rm -rf /var/tmp/*

EXPOSE 8123

CMD ["/root/boot.sh"]

