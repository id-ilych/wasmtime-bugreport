#!/bin/bash

WASM=$1
TARGET_DIR="/Users/ilia/dev/singapore/experiments/wasmtime/bugreport01/host/target"

EXPECTED_STDERR="thread 'main' panicked at /Users/ilia/.cargo/registry/src/index.crates.io-"
EXPECTED_STDERR+="1949cf8c6b5b557f/wasmtime-37.0.1/src/runtime/vm/gc/gc_runtime.rs:463:44"
RES=$($TARGET_DIR/release/host 10000 7500 1 1 1 $WASM 2>&1 | grep "$EXPECTED_STDERR")

if [ -z "$RES" ]; then
    echo "1: error not found"
else
    echo "1: $RES"
fi

EXPECTED_STDERR="thread 'main' panicked at /Users/ilia/.cargo/registry/src/index.crates.io-"
EXPECTED_STDERR+="1949cf8c6b5b557f/wasmtime-37.0.1/src/runtime/vm/gc/gc_runtime.rs:466:47"
RES=$($TARGET_DIR/release/host 10000 11000 1 1 1 $WASM 2>&1 | grep "$EXPECTED_STDERR")

if [ -z "$RES" ]; then
    echo "2: error not found"
else
    echo "2: $RES"
fi

# EXPECTED_STDERR="thread 'main' panicked at /Users/ilia/.cargo/registry/src/index.crates.io-"
# EXPECTED_STDERR+="1949cf8c6b5b557f/wasmtime-37.0.1/src/runtime/vm/gc/enabled/drc.rs:596:9"
# RES=$($TARGET_DIR/debug/host 10000 7500 1 1 1 $WASM 2>&1 | grep "$EXPECTED_STDERR")

# if [ -z "$RES" ]; then
#     echo "3: error not found"
# else
#     echo "3: $RES"
# fi

# EXPECTED_STDERR="thread 'main' panicked at /Users/ilia/.cargo/registry/src/index.crates.io-"
# EXPECTED_STDERR+="1949cf8c6b5b557f/wasmtime-37.0.1/src/runtime/vm/gc/enabled/drc.rs:596:9"
# RES=$($TARGET_DIR/debug/host 10000 11000 1 1 1 $WASM 2>&1 | grep "$EXPECTED_STDERR")

# if [ -z "$RES" ]; then
#     echo "4: error not found"
# else
#     echo "4: $RES"
# fi

# EXPECTED_STDERR="zsh: bus error"
$($TARGET_DIR/debug/host 22000 0 1 2 3 $WASM 2>&1 >/dev/null)

# check if it is 128 + SIGBUS(10)
if [ $? -eq 138 ]; then
    echo "6: SIGBUS detected"
else
    echo "6: error not found"
fi

EXPECTED_STDERR="thread 'main' panicked at /Users/ilia/.cargo/registry/src/index.crates.io-"
EXPECTED_STDERR+="1949cf8c6b5b557f/wasmtime-environ-37.0.1/src/types.rs:1160:25"
RES=$($TARGET_DIR/release/host 12025 17812 5 5 5 $WASM 2>&1 | grep "$EXPECTED_STDERR")

if [ -z "$RES" ]; then
    echo "7: error not found"
else
    echo "7: $RES"
fi

EXPECTED_STDERR="thread 'main' panicked at /Users/ilia/.cargo/registry/src/index.crates.io-"
EXPECTED_STDERR+="1949cf8c6b5b557f/wasmtime-37.0.1/src/runtime/vm/gc/enabled/drc.rs:317:14"
RES=$($TARGET_DIR/release/host 15202 17813 2 1 1 $WASM 2>&1 | grep "$EXPECTED_STDERR")

if [ -z "$RES" ]; then
    echo "8: error not found"
else
    echo "8: $RES"
fi