#!/usr/bin/env bash
set -e
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd $CUR_DIR/../

cargo clean -p exomind
cargo clippy --workspace --tests -- -D clippy::all # deny all warning to return error
