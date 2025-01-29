# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

WORKDIR /build

# Install golang
RUN apk add --no-cache go git

# Build TeslaBleHttpProxy from source
RUN git clone https://github.com/Lenart12/TeslaBleHttpProxy.git /build/TeslaBleHttpProxy \
    && cd /build/TeslaBleHttpProxy \
    && git checkout fe13af735c230604e7177f7551058db05d32e46a \
    && go build -o /usr/local/bin/TeslaBleHttpProxy

# Build TeslaBle2Mqtt from source
RUN git clone https://github.com/Lenart12/TeslaBle2Mqtt.git /build/TeslaBle2Mqtt \
    && cd /build/TeslaBle2Mqtt \
    && git checkout bb248d5d7d1977fce660856431c50b2d050d0aea \
    && go build -o /usr/local/bin/TeslaBle2Mqtt

# Clean up
RUN rm -rf /build

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]