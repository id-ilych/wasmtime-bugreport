use std::error::Error;
use wasmtime::*;

fn main() -> Result<(), Box<dyn Error>> {
    let arg_a = std::env::args().nth(1).unwrap().parse()?;
    let arg_b = std::env::args().nth(2).unwrap().parse()?;
    let arg_x = std::env::args().nth(3).unwrap().parse()?;
    let arg_y = std::env::args().nth(4).unwrap().parse()?;
    let arg_z = std::env::args().nth(5).unwrap().parse()?;

    let engine = Engine::new(Config::default()
        .gc_support(true)
        .wasm_gc(true)
        .wasm_exceptions(true)
        .wasm_reference_types(true)
        .wasm_function_references(true)
        .allocation_strategy(PoolingAllocationConfig::new()
            .max_memory_size(1_000_000)
            .to_owned()
        )
    )?;

    let module = Module::from_file(&engine, "guest.wasm")?;
    let mut linker = Linker::new(&engine);
    linker.func_wrap("wasi_snapshot_preview1", "random_get", |_: i32, _: i32| -> i32 { return 5 })?; // Errno::Io

    let instantiate = || -> Result<(Store<()>, TypedFunc<(i32, i32, i32, i32), i32>)> {
        let mut store = Store::new(&engine, ());
        let instance = linker.instantiate(&mut store, &module)?;

        let initialize = instance.get_typed_func::<(), ()>(&mut store, "_initialize")?;
        initialize.call(&mut store, ())?;

        let func = instance.get_typed_func(&mut store, "memtest")?;

        Ok((store, func))
    };

    let (mut store_a, func_a) = instantiate()?;
    let (mut store_b, func_b) = instantiate()?;

    for i in 0..100 {
        println!("{}", i);
        if arg_a > 0 {
            let _:i32 = func_a.call(&mut store_a, (arg_a, arg_x, arg_y, arg_z))?;
        }
        if arg_b > 0 {
            let _: i32 = func_b.call(&mut store_b, (arg_b, arg_x, arg_y, arg_z))?;
        }
    }

    Ok(())
}
