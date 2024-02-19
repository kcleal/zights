zights
======

Import htslib as a module using the zig package manager (v0.12.0-dev).
 
Uses `zig cc` to compile hstlib and makes it available for use with the zig package manager.

No make or configure is needed. System requirements include libraries:

    z, m, bz2, lzma, curl, pthread


Usage
-----

Use htslib in zig by importing as a c-library. For example `main.zig` could contain:

```zig
const hts = @cImport({
    @cInclude("hts.h");
    @cInclude("sam.h");
});


pub fn main() void {
    const f: *hts.htsFile = hts.hts_open("blah.bam", "r").?;
    _ = f;
}
```


Let's assume the above program is called `example`. Your `build.zig` is simply:

```zig
pub fn build(b: *std.Build) void {

    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "example",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const zights = b.dependency("zights", .{
        .target = target,
    });

    exe.addIncludePath(zights.path("htslib/htslib"));
    exe.addIncludePath(zights.path("htslib/cram"));
    exe.linkLibrary(zights.artifact("hts"));

    b.installArtifact(exe);
}
```

Also, don't forget to add this to the dependencies in your `build.zig.zon` file:

```zig
.zights = .{
    .url = "https://github.com/kcleal/zights/archive/refs/tags/v0.0.1.tar.gz",
    .hash = "1220f83de9a732d5aa6868df0c5a7ad0b9c49ff34d89e582033401aa218623eeb50a",
},
```
