#!/bin/bash
set -e

echo "Removing TLS-Sentinel XDP program..."
ip link set dev eth0 xdp off
echo "XDP program removed."
