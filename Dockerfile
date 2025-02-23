
FROM --platform=linux/x86_64 golang:1.19 AS builder

# Install dependencies
# https://www.reddit.com/r/docker/comments/10uya5l/hi_does_anyone_know_why_i_cant_install_the/
# https://github.com/ut-issl/s2e-core/issues/258
RUN apt-get update && apt-get install --fix-missing -y \
    clang llvm libelf-dev gcc-multilib iproute2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN make

# Create runtime container
FROM ubuntu:20.04

# Install runtime dependencies
RUN apt-get update && apt-get install -y iproute2 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/main /main

ENTRYPOINT ["/main"]
