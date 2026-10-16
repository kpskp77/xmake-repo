package("systemc", function()
    set_homepage("https://systemc.org/")
    set_description("The language for System-level design, modeling and verification")
    set_license("Apache-2.0")

    add_urls("https://github.com/accellera-official/systemc/archive/refs/tags/$(version).tar.gz")

    add_versions("3.0.2", "9b3693ed286aab958b9e5d79bb0ad3bc523bbc46931100553275352038f4a0c4")
    add_versions("3.0.1", "d07765d0d2ffd6c01767880d0c6aaf53cd9487975f898c593ffffd713258fcbb")
    add_versions("3.0.0", "4d0ab814719cfd6b1d195dd4bcb1b9e6edc5881b9a3e44117336a691992bf779")
    add_versions("2.3.4", "bfb309485a8ad35a08ee78827d1647a451ec5455767b25136e74522a6f41e0ea")
    add_versions("2.3.3", "5781b9a351e5afedabc37d145e5f7edec08f3fd5de00ffeb8fa1f3086b1f7b3f")
    add_versions("2.3.2", "a28eeee00189f0e39f51461dcd7dbed7fb38e4e07dbd9e723473000ce6ef73c5")

    add_deps("cmake")

    on_install(function(package)
        local configs = {}
        local version = package:version()

        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:is_debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
        if version:ge("3.0.0") then
            table.insert(configs, "-DCMAKE_CXX_STANDARD=17")
            if package:is_plat("windows") then
                table.insert(configs, "-DCMAKE_CXX_FLAGS=/DSC_CPLUSPLUS=201703L")
            else
                table.insert(configs, "-DCMAKE_CXX_FLAGS=-DSC_CPLUSPLUS=201703L")
            end
        else
            table.insert(configs, "-DCMAKE_CXX_STANDARD=11")
            if package:is_plat("windows") then
                table.insert(configs, "-DCMAKE_CXX_FLAGS=/DSC_CPLUSPLUS=201103L")
            else
                table.insert(configs, "-DCMAKE_CXX_FLAGS=-DSC_CPLUSPLUS=201103L")
            end
        end
        import("package.tools.cmake").install(package, configs)
    end)

    on_load(function(package)
        local version = package:version()
        if version:ge("3.0.0") then
            package:add("defines", "SC_CPLUSPLUS=201703L")
        else
            package:add("defines", "SC_CPLUSPLUS=201103L")
        end
    end)

    on_test(function(package)
        assert(package:check_cxxsnippets({
            test = [[
                #define SC_INCLUDE_DYNAMIC_PROCESSES
                #include <systemc>
                using namespace sc_core;
                int sc_main(int, char *[]) {
                  sc_spawn([] {
                    sc_core::wait(10, SC_NS);
                    std::cout << "Hello World! @" << sc_time_stamp() << std::endl;
                    sc_stop();
                  });
                  sc_start();
                  return 0;
                }
            ]],
        }))
    end)
end)
