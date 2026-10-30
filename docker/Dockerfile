FROM golang:1.24-bookworm

RUN apt-get update \
    && apt-get install --yes --no-install-recommends fish git expect python3 python3-pip bats bats-assert bats-support \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install --break-system-packages colorful gitpython platformdirs

WORKDIR /agnostic-tests
COPY . .
RUN make checkout build-go

ENTRYPOINT ["make", "test"]
