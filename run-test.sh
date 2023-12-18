#!/bin/bash
set -euo pipefail

main() {

  # Check if port is available 
  if nc -z 127.0.0.1 8899; then
    echo "Port 8899 already in use"
    exit 1
  fi
  
  # Start localnet
  anchor localnet > anchor-localnet.log 2>&1 &  

  sleep 200
  
  # Run tests  
  cargo test --manifest-path ./programs/example/Cargo.toml

  # Cleanup
  cleanup anchor
}

cleanup() {
  pkill -f anchor 
}

trap 'cleanup' EXIT

main
