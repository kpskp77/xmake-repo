package("svdpi", function()
    set_homepage("https://github.com/kpskp77/svdpi")
    set_description("SystemVerilog DPI-C header file")
    set_license("MIT")

    add_urls("https://github.com/kpskp77/svdpi/archive/refs/tags/v$(version).tar.gz")

    add_versions("1.0.0", "7726563f48758309f0ead330dfcf699483e313a585e223d350afd535cc7f2955")

    add_deps("cmake")

    on_install(function(package)
        import("package.tools.cmake").install(package)
    end)
end)
