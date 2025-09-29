# Purpose

This project is a WASM module ("guest") to use for wasmtime testing/evaluation.

## How to build

```
make wasm publish
```

It would build a production (optimized) WASM and copy it top the `../wasmtime_host` directory.

Check `Makefile` for other options (those prefixed with `-dev` are for unoptimized WASM, mostly for debugging).