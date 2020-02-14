FROM nginx:stable

# get some required executables
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bc \
        curl \
        unzip \
    && rm -rf /var/lib/apt/lists/*

# get consul-template release
RUN curl --retry 7 -Lsko /tmp/consul-template.zip "https://releases.hashicorp.com/consul-template/0.24.1/consul-template_0.24.1_linux_amd64.zip" \
    && echo "3556e9d7b2a4f5f964d7282b8b226a1aee713627505b00c1f81c35fab78757a2 /tmp/consul-template.zip" | sha256sum -c \
    && unzip /tmp/consul-template.zip -d /usr/local/bin \
    && rm /tmp/consul-template.zip


# get ContainerPilot release
ENV CONTAINERPILOT_VERSION 3.8.0
ENV CONTAINERPILOT=/etc/containerpilot.json5
RUN export checksum=84642c13683ddae6ccb63386e6160e8cb2439c26 \
    && curl -Lsko /tmp/containerpilot.tar.gz \
         "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VERSION}/containerpilot-${CONTAINERPILOT_VERSION}.tar.gz" \
    && echo "${checksum}  /tmp/containerpilot.tar.gz" | sha1sum -c \
    && tar zxf /tmp/containerpilot.tar.gz -C /usr/local/bin \
    && rm /tmp/containerpilot.tar.gz

# copy config files and scripts
COPY config/containerpilot.json5 /etc/containerpilot.json5
COPY config/nginx.conf.ctmpl /etc/nginx/
COPY scripts/ /usr/bin/

RUN chmod +x /usr/bin/setup.sh /usr/bin/reload.sh /usr/bin/sensor.sh

CMD /usr/local/bin/containerpilot -config /etc/containerpilot.json5
