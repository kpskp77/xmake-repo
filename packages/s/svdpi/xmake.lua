package("svdpi", function()
	set_homepage("https://github.com/kpskp77/svdpi")
	set_description("SystemVerilog DPI-C header file")
	set_license("MIT")

	add_urls("https://github.com/kpskp77/svdpi/archive/refs/tags/v$(version).tar.gz")

	add_versions("1.1.0", "b80b55612f91f1b9a8d3ec02991e548db37d1a96f554485f69bf6567e75743bb")
	add_versions("1.0.0", "7726563f48758309f0ead330dfcf699483e313a585e223d350afd535cc7f2955")

	add_deps("cmake")

	on_install(function(package)
		import("package.tools.cmake").install(package)
	end)
end)
