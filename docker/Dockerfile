FROM golang:1.27-alpine

RUN apk add --no-cache bash bats expect fish git make python3 py3-pip
RUN git clone --depth 1 --branch v0.3.0 https://github.com/bats-core/bats-support /usr/lib/bats/bats-support \
    && git clone --depth 1 --branch v2.1.0 https://github.com/bats-core/bats-assert /usr/lib/bats/bats-assert
RUN pip3 install --break-system-packages colorful gitpython platformdirs

WORKDIR /agnostic-tests
COPY . .
RUN make checkout build-go

# Run as a regular user: as root, Fish adds `root@host` to the prompt.
RUN adduser -D nemo && chown -R nemo /agnostic-tests
USER nemo
ENV BATS_LIB_PATH=/usr/lib/bats

ENTRYPOINT ["make", "test"]
