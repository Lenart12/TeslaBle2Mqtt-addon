# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

WORKDIR /build

# Install golang, git
RUN apk add --no-cache go git

# Build TeslaBleHttpProxy from source
RUN git clone https://github.com/Lenart12/vehicle-command.git /build/vehicle-command \
    && cd /build/vehicle-command/cmd/test-ble \
    && git checkout aa48216fb0840b6dd3c23cbf719d41fa8dd6d2ac \
    && go build -o /usr/local/bin/test-ble
    
# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

# Clean up
RUN rm -rf /build
    
CMD [ "/run.sh" ]