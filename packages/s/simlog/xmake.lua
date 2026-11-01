package("simlog", function()
	set_homepage("https://github.com/kpskp77/simlog")
	set_description("EDA simulation logger based on spdlog")
	set_license("MIT")

	add_configs(
		"backend",
		{ description = "Time source backend selection", default = "svdpi", values = { "svdpi", "systemc" } }
	)

	add_deps("spdlog", { configs = { header_only = false, shared = true } })

	add_urls("https://github.com/kpskp77/simlog/archive/refs/tags/v$(version).tar.gz")

	add_versions("1.0.0", "ff4e0f2d851979b0883cf0a8d37ccce1caa57f1837b6903479284723e5a76220")

	on_load(function(package)
		if package:config("backend") == "systemc" then
			package:add("defines", "SIMLOG_BACKEND_SYSTEMC")
			package:add("deps", "systemc", { configs = { shared = true } })
		else
			package:add("defines", "SIMLOG_BACKEND_SVDPI")
			package:add("deps", "svdpi")
		end
	end)

	on_install(function(package)
		configs = { backend = package:config("backend") }
		import("package.tools.xmake").install(package, configs)
	end)
end)
