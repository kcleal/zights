zights
======

Import htslib as a module using the zig package manager.
 
Uses `zig cc` to compile hstlib and makes it available for use with the zig package manager

Note this is a work in progress!

Usage
-----

Let's assume you are building a program called `example`.
To compile and import hstlib, your `build.zig` file could look like:

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

Add this to the dependencies in your `build.zig.zon` file:

```zig
.zights = .{
    .url = "https://github.com/kcleal/zights/archive/refs/tags/v0.0.1a.tar.gz",
    .hash = "1220bdf5b2bc887e2523381ccb95db034651623aae4aae7c680d52215dbe6e52fa58",
},
```


You can then use htslib in zig, for example `main.zig` could contain:

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
