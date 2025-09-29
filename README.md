# How to reproduce

```
# Re-build and copy guest.wasm if necessary
(cd guest && make wasm publish)

# causes "`Option::unwrap()` on a `None` value" panic in
# wasmtime-37.0.1/src/runtime/vm/gc/gc_runtime.rs:463:44
(cd host && RUST_BACKTRACE=1 cargo run --release 10000 7500 1 1 1)

# causes "range start index 6553700 out of range for slice of length 524288" panic in
# wasmtime-37.0.1/src/runtime/vm/gc/gc_runtime.rs:466:47
(cd host && RUST_BACKTRACE=1 cargo run --release 10000 11000 1 1 1)

# causes self.is_in_over_approximated_stack_roots() assertion failure in
# wasmtime-37.0.1/src/runtime/vm/gc/enabled/drc.rs:596:9
(cd host && RUST_BACKTRACE=1 cargo run 10000 7500 1 1 1)

# causes self.is_in_over_approximated_stack_roots() assertion failure in
# wasmtime-37.0.1/src/runtime/vm/gc/enabled/drc.rs:596:9
(cd host && RUST_BACKTRACE=1 cargo run 10000 11000 1 1 1)

# hangs on loop iteration i=5
(cd host && RUST_BACKTRACE=1 cargo run --release 10000 7500 3 2 1)

# zsh: bus error  ( cd host && RUST_BACKTRACE=1 cargo run --release 22000 0 1 2 3; )
(cd host && RUST_BACKTRACE=1 cargo run --release 22000 0 1 2 3)

# causes "`Option::unwrap()` on a `None` value" panic in
# wasmtime-environ-37.0.1/src/types.rs:1160:25
(cd host && RUST_BACKTRACE=1 cargo run --release 12025 17812 5 5 5)

# causes "should have inserted trace info for every GC type allocated in this heap" panic in
# wasmtime-37.0.1/src/runtime/vm/gc/enabled/drc.rs:317:14
(cd host && RUST_BACKTRACE=1 cargo run --release 15202 17813 2 1 1)
```

On top of these, I also observed following panic, though currently I cannot reproduce the exact setup I used:
```
thread 'main' panicked at /Users/ilia/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/wasmtime-environ-37.0.1/src/gc.rs:469:18:
invalid `VMGcKind`: 0b000000000000000000000000000000
stack backtrace:
   0: __rustc::rust_begin_unwind
   1: core::panicking::panic_fmt
   2: wasmtime::runtime::vm::gc::enabled::drc::DrcHeap::dec_ref_and_maybe_dealloc
   3: <wasmtime::runtime::vm::gc::enabled::drc::DrcCollection as wasmtime::runtime::vm::gc::gc_runtime::GarbageCollection>::collect_increment
   4: wasmtime::runtime::store::gc::<impl wasmtime::runtime::store::StoreOpaque>::gc::{{closure}}
   5: wasmtime::runtime::vm::libcalls::gc_alloc_raw
   6: <core::result::Result<T,E> as wasmtime::runtime::vm::traphandlers::HostResult>::maybe_catch_unwind
   7: wasmtime::runtime::vm::libcalls::raw::gc_alloc_raw
   8: <unknown>
```
NOTE: this panic happened after few successful iterations of the loop repeating the same actions, so it wasn't some totally broken code or impossible values;

`cargo 1.90.0 (840b83a10 2025-07-30)`
`rustc 1.90.0 (1159e78c4 2025-09-14)`
