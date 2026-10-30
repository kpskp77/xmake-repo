# xmake-repo（EDA）

[English](README.md) | **中文**

个人维护的 [xmake](https://xmake.io) 包仓库，主要服务于 **EDA / 硬件仿真** 方向的工具链。

日常用到的 SystemC、DPI-C 头文件之类，接进工程只要一行 `add_requires()`：不用手动找源码、不用每台机器重装一遍，版本固定得住，Linux / macOS / Windows 上编出来是一个样。

## 现有软件包

| 包名 | 版本 | 协议 | 说明 |
| ---- | ---- | ---- | ---- |
| [`systemc`](https://systemc.org/) | 3.0.2、3.0.1、3.0.0、2.3.4、2.3.3、2.3.2 | Apache-2.0 | Accellera 官方的 SystemC 类库，做系统级设计、建模和验证用。静态库、动态库都能编；`SC_CPLUSPLUS` 已经替你加好了（3.x 是 C++17，2.3.x 是 C++11）。 |
| [`svdpi`](https://github.com/kpskp77/svdpi) | 1.0.0 | MIT | SystemVerilog DPI-C 头文件包，写 DPI import/export 的 C/C++ 侧代码时用，和各类仿真器、Verilator 配合都可以。 |

## 快速上手

先把仓库注册进去，全局装一次即可：

```console
$ xrepo add-repo eda git@github.com:kpskp77/xmake-repo.git
```

不想全局加的话，写进工程的 `xmake.lua` 里也一样：

```lua
add_repositories("eda git@github.com:kpskp77/xmake-repo.git")
```

之后按需引入：

```lua
add_requires("systemc 3.0.2", "svdpi 1.0.0")

target("my_model")
    set_kind("binary")
    set_languages("c++17")
    add_packages("systemc", "svdpi")
    add_files("src/*.cpp")
```

```console
$ xmake            # 配置 + 编译，依赖自动拉取并缓存
$ xmake run
```

版本号也可以不写，交给 xmake 挑最新的；想用动态库就加个 configs：

```lua
add_requires("systemc 3.0.2", {configs = {shared = true}})
```

## 环境要求

- xmake >= 2.8
- C++ 编译器：GCC / Clang / MSVC（建议 C++17，SystemC 3.x 需要）
- CMake：包在安装阶段要用它来编

## 协议

本仓库代码采用 MIT 协议，详见 [LICENSE](LICENSE)。各个包本身仍遵循上游项目的协议。
