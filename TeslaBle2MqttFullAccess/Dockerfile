# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

WORKDIR /build

# Install golang
RUN apk add --no-cache go git

# Build TeslaBleHttpProxy from source
RUN git clone https://github.com/Lenart12/TeslaBleHttpProxy.git /build/TeslaBleHttpProxy \
    && cd /build/TeslaBleHttpProxy \
    && git checkout 78d8d0dca297a2d635f8b8ce8733a03cc57bf779 \
    && go build -o /usr/local/bin/TeslaBleHttpProxy

# Build TeslaBle2Mqtt from source
RUN git clone https://github.com/Lenart12/TeslaBle2Mqtt.git /build/TeslaBle2Mqtt \
    && cd /build/TeslaBle2Mqtt \
    && git checkout 4c1ee48d57870f9014112e6cd50cabcc9731c1bd \
    && go build -o /usr/local/bin/TeslaBle2Mqtt

    
# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

# Get version from config.yaml and set it in /data/version.txt
COPY config.yaml /build/config.yaml
RUN sed -n 's/version: "\(.*\)"/\1/p' /build/config.yaml > /version.txt

# Clean up
RUN rm -rf /build
    
CMD [ "/run.sh" ]