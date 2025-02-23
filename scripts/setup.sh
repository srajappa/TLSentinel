#!/bin/bash
set -e

echo "Setting up TLS-Sentinel..."
ip link set dev eth0 xdp obj bpf/tls_probe.o
echo "XDP program loaded."
