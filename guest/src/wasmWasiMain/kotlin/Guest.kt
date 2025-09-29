@ExperimentalWasmInterop
@WasmExport
fun memtest(size: Int, x: Int, y: Int, z: Int): Int {
    val a = ('a' + (size.hashCode() % 26)).toChar().toString().repeat(size*x)
    val b = ('b' + (size.hashCode() % 26)).toChar().toString().repeat(size*y)
    val c = ('c' + (size.hashCode() % 26)).toChar().toString().repeat(size*z)

    var res = 0;
    res = res xor a[a.length / 2].hashCode() xor a.length;
    res = res xor b[b.length / 2].hashCode() xor b.length;
    res = res xor c[c.length / 2].hashCode() xor c.length;

    return res
}