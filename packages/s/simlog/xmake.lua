package("simlog", function()
	set_homepage("https://github.com/kpskp77/simlog")
	set_description("EDA simulation logger based on spdlog")
	set_license("MIT")

	add_configs(
		"backend",
		{ description = "Time source backend selection", default = "svdpi", values = { "svdpi", "systemc" } }
	)

	add_deps("spdlog", { configs = { header_only = false, shared = true } })
	add_deps("systemc", { configs = { shared = true } })
	add_deps("svdpi")

	add_urls("https://github.com/kpskp77/simlog/archive/refs/tags/v$(version).tar.gz")

	add_versions("1.0.0", "10bc5f470de66ddb1f1ba60e6ee2faf843ce37aefccce73fce905a866685a623")

	on_install(function(package)
		configs = { backend = package:config("backend") }
		import("package.tools.xmake").install(package, configs)
	end)
end)
