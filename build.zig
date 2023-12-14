const std = @import("std");
const CrossTarget = std.zig.CrossTarget;
const OsTag = std.Target.Os.Tag;

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{ .whitelist = &[_]CrossTarget{
        CrossTarget{ .cpu_arch = .x86_64, .os_tag = OsTag.windows, .abi = .msvc },
        CrossTarget{ .cpu_arch = .x86_64, .os_tag = OsTag.macos, .abi = .macabi },
        CrossTarget{ .cpu_arch = .aarch64, .os_tag = OsTag.macos, .abi = .macabi },
        CrossTarget{ .cpu_arch = .x86_64, .os_tag = OsTag.linux, .abi = .gnu },
    } });
    const tgt_os_tag = (std.zig.system.NativeTargetInfo.detect(target) catch @panic("Could not determine target!")).target.os.tag;

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    const xplm_min_version = b.option(u16, "XPLM_MIN", "Minimum version of XPLM to require. Must be at least 210.") orelse @panic("Please set an XPLM minimum version!");
    if (xplm_min_version < 210) {
        @panic("Invalid XPLM version. Version must be at least 210.");
    }

    const translate_c_step = b.addTranslateC(.{ .source_file = .{ .path = "src/include_all_headers.h" }, .target = target, .optimize = optimize });
    translate_c_step.addIncludeDir("src/XPlaneSDK/CHeaders/XPLM");
    translate_c_step.addIncludeDir("src/XPlaneSDK/CHeaders/Widgets");

    var xplm_min_str_buf: [5]u8 = undefined;
    const xplm_min_string = std.fmt.bufPrint(&xplm_min_str_buf, "{}", .{xplm_min_version}) catch unreachable;
    translate_c_step.defineCMacro("XPLM_MIN", xplm_min_string);

    translate_c_step.defineCMacro("APL", if (tgt_os_tag == OsTag.macos) "1" else "0");
    translate_c_step.defineCMacro("IBM", if (tgt_os_tag == OsTag.windows) "1" else "0");
    translate_c_step.defineCMacro("LIN", if (tgt_os_tag == OsTag.linux) "1" else "0");

    const printer_step = b.step("translated_c_file", "print the location of translated C file");
    printer_step.makeFn = print_translated_loc;
    printer_step.dependOn(&translate_c_step.step);

    const lib = b.addStaticLibrary(.{
        .name = "xplm",
        // In this case the main source file is merely a path, however, in more
        // complicated build scripts, this could be a generated file.
        .root_source_file = .{ .path = "src/root.zig" },
        .target = target,
        .optimize = optimize,
    });

    switch (tgt_os_tag) {
        .linux => {
            // No stubs for Linux.
        },
        .macos => {
            lib.addFrameworkPath(.{ .path = "src/XPlaneSDK/Libraries/Mac" });
            lib.linkFrameworkNeeded("XPLM");
            lib.linkFrameworkNeeded("XPWidgets");
        },
        .windows => {
            lib.addLibraryPath(.{ .path = "src/XPlaneSDK/Libraries/Win" });
            lib.linkSystemLibrary2("XPLM_64", .{ .needed = true });
            lib.linkSystemLibrary2("XPWidgets_64", .{ .needed = true });
        },
        else => unreachable,
    }

    const options = b.addOptions();
    options.addOption(u16, "xplm_min", xplm_min_version);
    lib.addOptions("config", options);

    // This declares intent for the library to be installed into the standard
    // location when the user invokes the "install" step (the default step when
    // running `zig build`).
    b.installArtifact(lib);

    // Creates a step for unit testing. This only builds the test executable
    // but does not run it.
    const lib_unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/root.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    // Similar to creating the run step earlier, this exposes a `test` step to
    // the `zig build --help` menu, providing a way for the user to request
    // running the unit tests.
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
}

fn print_translated_loc(self: *std.build.Step, progress: *std.Progress.Node) !void {
    _ = progress;
    const tr_c_s = self.dependencies.items[0].cast(std.build.Step.TranslateC) orelse @panic("first dependency was not TranslateC!");
    std.debug.print("translated file: {?s}", .{tr_c_s.output_file.getPath()});
}
