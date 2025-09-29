.SILENT:wasm
.PHONY:wasm
wasm:
	./gradlew compileProductionExecutableKotlinWasmWasiOptimize # discovered by ./gradlew wasmWasiNodeProductionRun --task-graph
	mkdir -p build/wasm
	cp ./build/compileSync/wasmWasi/main/productionExecutable/optimized/guest.wasm ./build/wasm/
	echo
	echo "Built file:"
	ls -l ./build/wasm/guest.wasm

.SILENT:wasm-dev
.PHONY:wasm-dev
wasm-dev:
	./gradlew compileDevelopmentExecutableKotlinWasmWasi # discovered by ./gradlew wasmWasiNodeDevelopmentRun --task-graph
	mkdir -p build/wasm
	cp ./build/compileSync/wasmWasi/main/developmentExecutable/kotlin/guest.wasm ./build/wasm/guest.dev.wasm
	echo
	echo "Built file:"
	ls -l ./build/wasm/guest.dev.wasm

.SILENT:publish
.PHONY:publish
publish:
	cp ./build/wasm/guest.wasm ../host
	echo "Copied file:"
	ls -l ../host/guest.wasm

.SILENT:publish-dev
.PHONY:publish-dev
publish-dev:
	cp ./build/wasm/guest.dev.wasm ../host
	echo "Copied file:"
	ls -l ../host/guest.dev.wasm

.SILENT:wat
.PHONY:wat
wat:
	mkdir -p build/wat
	wasm-dis ./build/wasm/guest.wasm -o ./build/wat/guest.wat

.SILENT:wat-dev
.PHONY:wat-dev
wat-dev:
	wasm-dis ./build/wasm/guest.dev.wasm -o ./build/wat/guest.dev.wat
