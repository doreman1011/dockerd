# Use Ubuntu as the base image
FROM ubuntu:22.04

# Install dependencies
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    git cmake g++ libjson-c-dev libwebsockets-dev libssl-dev \
    zlib1g-dev bash curl wget build-essential

# Clone and build ttyd from source
RUN git clone https://github.com/tsl0922/ttyd.git && \
    cd ttyd && mkdir build && cd build && \
    cmake .. && make && make install

# Clean up to reduce image size
RUN apt clean && rm -rf /var/lib/apt/lists/* /ttyd

# Set environment variables
ENV SHELL=/bin/bash \
    PORT=7681 \
    DEBUG=2

# Expose the port
EXPOSE ${PORT}

# Start ttyd in debug mode using bash
CMD ["ttyd", "-d", "2", "-p", "7681", "bash"]
