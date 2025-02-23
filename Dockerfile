
FROM golang:1.19 AS builder

# Install dependencies
RUN apt-get update && apt-get install -y \
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
