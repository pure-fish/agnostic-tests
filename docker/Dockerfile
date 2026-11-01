FROM golang:1.27-alpine

# Alpine's bats package also installs bats-support and bats-assert in /usr/lib/bats.
RUN apk add --no-cache bash bats expect fish git make python3 py3-pip
RUN pip3 install --break-system-packages colorful gitpython platformdirs

WORKDIR /agnostic-tests
COPY . .
RUN make checkout build-go

# Run as a regular user: as root, Fish adds `root@host` to the prompt.
RUN adduser -D nemo && chown -R nemo /agnostic-tests
USER nemo
ENV BATS_LIB_PATH=/usr/lib/bats

ENTRYPOINT ["make", "test"]
