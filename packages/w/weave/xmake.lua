package("weave", function()
	set_homepage("https://github.com/kpskp77/weave")
	set_description(
		"A behaviour orchestration layer between C++ test logic and EDA simulation kernels, built for C++17 and later standards."
	)
	set_license("MIT")

	add_configs("backend", { description = "Backend selection", default = "svdpi", values = { "svdpi", "systemc" } })

	add_urls("https://github.com/kpskp77/weave/archive/refs/tags/v$(version).tar.gz")

	add_versions("1.0.0", "dbe250db3a6ae9d0c468e7287f56e4177350cc5f12c46479ab0c45f72d609e71")

	on_load(function(package)
		local backend = package:config("backend")
		package:add("deps", "simlog", { configs = { shared = true, backend = backend } })
		if backend == "systemc" then
			package:add("deps", "systemc", { configs = { shared = true } })
		else
			package:add("deps", "svdpi")
		end
	end)

	on_install(function(package)
		configs = { backend = package:config("backend") }
		import("package.tools.xmake").install(package, configs)
	end)
end)
