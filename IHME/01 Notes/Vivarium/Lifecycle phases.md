``` python
self._lifecycle = self._plugin_manager.get_plugin("lifecycle")
self._lifecycle.add_phase(
    "setup",
    ["setup", "post_setup", "population_creation"]
)
self._lifecycle.add_phase(
    "main_loop",
    ["time_step__prepare", "time_step", "time_step__cleanup", "collect_metrics"],
    loop=True,
)
```
