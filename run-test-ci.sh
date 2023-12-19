#!/bin/bash

set -euox pipefail

main() {

  solana config set -u localhost

  home_dir=$(eval echo ~$USER)
  program_id="./target/deploy/example-keypair.json"
  program_so="./target/deploy/example.so"
  keypath="$home_dir/.config/solana/id.json"

  echo "Key balance: $(solana balance $keypath)"

  solana program deploy \
    --program-id $program_id \
    $program_so \
    --keypair $keypath

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
