# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

WORKDIR /build

# Install golang, git and nginx, remove default nginx site
RUN apk add --no-cache go git nginx && \
    mkdir -p /run/nginx && \
    rm -f /etc/nginx/http.d/default.conf

# Build TeslaBleHttpProxy [BlueZ] from source
RUN git clone https://github.com/Lenart12/TeslaBleHttpProxy.git /build/TeslaBleHttpProxy-BlueZ \
    && cd /build/TeslaBleHttpProxy-BlueZ \
    && git checkout dd527720bd0221f28dbc19e98e11c499e5836f06 \
    && go build -o /usr/local/bin/TeslaBleHttpProxy-BlueZ

# Build TeslaBleHttpProxy from source
RUN git clone https://github.com/Lenart12/TeslaBleHttpProxy.git /build/TeslaBleHttpProxy \
    && cd /build/TeslaBleHttpProxy \
    && git checkout 1d2c37e9444ffb81b24c773131f11f448371aba1 \
    && go build -o /usr/local/bin/TeslaBleHttpProxy
    
# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

# Clean up
RUN rm -rf /build
    
CMD [ "/run.sh" ]