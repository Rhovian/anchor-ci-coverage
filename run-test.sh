#!/bin/bash

set -euox pipefail

# Your program 
my_program_pid="GeqRnyZsQ3iShsMD11sB6rD9KtPCNHJ2y2hN5H4kdNoN"
my_program_so="target/deploy/example.so"

main() {

  home_dir=$(eval echo ~$USER)
  keypath="$home_dir/.config/solana/id.json"

  # Start validator 
  solana-test-validator -r --bpf-program $my_program_pid $my_program_so > test-validator.log &
  sleep 60

  solana --url localhost airdrop 10 $(solana-keygen pubkey $keypath)
  sleep 60
  # Run your program tests
  cargo test --manifest-path ./programs/example/Cargo.toml

  # Cleanup 
  cleanup
}

cleanup() {
  pkill -P $$ || true
  wait || true
}

trap_add() {
  trap_add_cmd=$1; shift || fatal "${FUNCNAME} usage error"
  for trap_add_name in "$@"; do
      trap -- "$(
          extract_trap_cmd() { printf '%s\n' "${3:-}"; }
          eval "extract_trap_cmd $(trap -p "${trap_add_name}")"
          printf '%s\n' "${trap_add_cmd}"
      )" "${trap_add_name}" \
          || fatal "unable to add to trap ${trap_add_name}"
  done
}

trap_add 'cleanup' EXIT

main
