# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

WORKDIR /build

# Install golang, git and nginx, remove default nginx site
RUN apk add --no-cache go git nginx && \
    mkdir -p /run/nginx && \
    rm -f /etc/nginx/http.d/default.conf

# Build TeslaBleHttpProxy from source
RUN git clone https://github.com/Lenart12/TeslaBleHttpProxy.git /build/TeslaBleHttpProxy \
    && cd /build/TeslaBleHttpProxy \
    && git checkout fdf944bdc4de6e375505a556c787d88da7291d16 \
    && go build -o /usr/local/bin/TeslaBleHttpProxy

# Build TeslaBle2Mqtt from source
RUN git clone https://github.com/Lenart12/TeslaBle2Mqtt.git /build/TeslaBle2Mqtt \
    && cd /build/TeslaBle2Mqtt \
    && git checkout acc602fb7dbc2c158ed2651dc9960af77a3ad86c \
    && go build -o /usr/local/bin/TeslaBle2Mqtt

    
# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

# Clean up
RUN rm -rf /build
    
CMD [ "/run.sh" ]