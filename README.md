# xmake-repo (EDA)

**English** | [中文](README_zh.md)

A personal [xmake](https://xmake.io) package repository focused on **EDA / hardware simulation** toolchains.

It lets you pull SystemC, DPI-C headers and friends into any xmake project with a single
`add_requires()` — no manual downloads, no per-machine install scripts, and reproducible
versions across Linux, macOS and Windows.

## Packages

| Package | Version(s) | License | Description |
| ------- | ---------- | ------- | ----------- |
| [`systemc`](https://systemc.org/) | 3.0.2, 3.0.1, 3.0.0, 2.3.4, 2.3.3, 2.3.2 | Apache-2.0 | The Accellera SystemC class library for system-level design, modeling and verification. Builds static or shared, automatically sets `SC_CPLUSPLUS` (C++17 for 3.x, C++11 for 2.3.x). |
| [`svdpi`](https://github.com/kpskp77/svdpi) | 1.0.0 | MIT | SystemVerilog DPI-C header package, for writing C/C++ side DPI import/export functions used by simulators and Verilator. |

## Quick start

Register this repository once (globally, or per-project with `add_repositories`):

```console
$ xrepo add-repo eda git@github.com:kpskp77/xmake-repo.git
```

or inside your `xmake.lua`:

```lua
add_repositories("eda git@github.com:kpskp77/xmake-repo.git")
```

Then require the packages you need:

```lua
add_requires("systemc 3.0.2", "svdpi 1.0.0")

target("my_model")
    set_kind("binary")
    set_languages("c++17")
    add_packages("systemc", "svdpi")
    add_files("src/*.cpp")
```

```console
$ xmake            # configure + build, packages are fetched and cached automatically
$ xmake run
```

## Requirements

- xmake >= 2.8
- A C++ compiler: GCC/Clang/MSVC (C++17 recommended for SystemC 3.x)
- CMake (used by the package build scripts)

## License

MIT — see [LICENSE](LICENSE). Individual packages keep their upstream licenses.
