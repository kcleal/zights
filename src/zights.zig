// const std = @import("std");

pub const hts = @cImport({@cInclude("hts.h");});
pub const hfile = @cImport({@cInclude("hfile.h");});
pub const sam = @cImport({@cInclude("sam.h");});

// pub const zights = struct {
//     const hts = @cImport({
//         @cInclude("hts.h");
//         @cInclude("hfile.h");
//         @cInclude("sam.h");
//     });

// };
