FROM mysql:latest

# get some required executables
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

# get ContainerPilot release
ENV CONTAINERPILOT_VERSION 3.8.0
ENV CONTAINERPILOT=/etc/containerpilot.json5
RUN export checksum=84642c13683ddae6ccb63386e6160e8cb2439c26 \
    && curl -Lsko /tmp/containerpilot.tar.gz \
         "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VERSION}/containerpilot-${CONTAINERPILOT_VERSION}.tar.gz" \
    && echo "${checksum}  /tmp/containerpilot.tar.gz" | sha1sum -c \
    && tar zxf /tmp/containerpilot.tar.gz -C /usr/local/bin \
    && rm /tmp/containerpilot.tar.gz

# copy config files
COPY config/containerpilot.json5 /etc/containerpilot.json5

CMD /usr/local/bin/containerpilot -config /etc/containerpilot.json5