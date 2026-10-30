FROM golang:1.24-bookworm

RUN apt-get update \
    && apt-get install --yes --no-install-recommends fish git expect python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*
# Bats 1.10+ is required for BATS_TEST_TAGS; Debian Bookworm ships 1.8.2.
RUN git clone --depth 1 --branch v1.11.1 https://github.com/bats-core/bats-core /tmp/bats-core \
    && /tmp/bats-core/install.sh /usr/local \
    && git clone --depth 1 --branch v0.3.0 https://github.com/bats-core/bats-support /usr/lib/bats/bats-support \
    && git clone --depth 1 --branch v2.1.0 https://github.com/bats-core/bats-assert /usr/lib/bats/bats-assert \
    && rm -rf /tmp/bats-core
RUN pip3 install --break-system-packages colorful gitpython platformdirs

WORKDIR /agnostic-tests
COPY . .
RUN make checkout build-go

ENTRYPOINT ["make", "test"]
