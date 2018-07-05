FROM golang:1.10.3

RUN groupadd -g 1000 builder && \
useradd -u 1000 -g 1000 -ms /bin/bash builder && \
echo 'builder ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER builder
WORKDIR /project
