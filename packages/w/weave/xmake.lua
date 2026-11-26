-- Experimental package: weave is not stable yet and its upstream tags are not
-- reliable (they have been deleted/re-created), so this package intentionally
-- pins no version or tag and always builds the upstream default branch.
package("weave", function()
	set_homepage("https://github.com/kpskp77/weave")
	set_description(
		"A behaviour orchestration layer between C++ test logic and EDA simulation kernels, built for C++17 and later standards."
	)
	set_license("MIT")

	add_configs("backend", { description = "Backend selection", default = "svdpi", values = { "svdpi", "systemc" } })

	add_urls("https://github.com/kpskp77/weave.git")

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
		local configs = { backend = package:config("backend") }
		import("package.tools.xmake").install(package, configs)
	end)
end)
