zights
======

This is [htslib v1.19.1](https://github.com/samtools/htslib) packaged for the [zig](https://ziglang.org) build system (v0.12.0-dev).
 
Uses `zig cc` to compile hstlib as a static library, no Makefile or configure is needed.

System requirements are libraries `bz2, lzma, curl`


Usage
-----

Use htslib in zig by using `cImport` and including the relevant header files:

```zig
const hts = @cImport({
    @cInclude("hts.h");
    @cInclude("sam.h");
});

pub fn main() void {
    const f: *hts.htsFile = hts.hts_open("a.bam", "r").?;
    _ = f;
}
```

Add this snippet to your `build.zig` file:

```zig
const zights = b.dependency("zights", .{
    .target = target,
});
your_build.addIncludePath(zights.path("htslib/htslib"));
your_build.addIncludePath(zights.path("htslib/cram"));
your_build.linkLibrary(zights.artifact("hts"));
```

Also, don't forget to add zights to the dependencies in your `build.zig.zon` file:

```shell
zig fetch --save https://github.com/kcleal/zights/archive/refs/tags/v0.0.1.tar.gz
```
