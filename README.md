# TLS-Sentinel

**TLS-Sentinel** is an eBPF/XDP-based tool for detecting TLS verification failures on network interfaces. It hooks into relevant TLS kernel functions and logs handshake failures.

## Features
- Uses eBPF to detect failed TLS handshakes
- Monitors certificate verification failures
- Outputs failure details in real-time

## Use Docker

docker build -t tls-sentinel .
docker run --privileged -it tls-sentinel
