import inspect
import os
import pkgutil
from pydoc import classname

# pylint: disable=R1710


class Plugin(object):
    """Base class that each plugin must inherit from.

    Within this class you must define the methods
    that all of your plugins must implement.
    """

    def __init__(self):
        self.description = "UNKNOWN"

    def connect(self):
        raise NotImplementedError

    def execute(self, sql):
        raise NotImplementedError

    def commit(self):
        raise NotImplementedError

    def close(self):
        raise NotImplementedError

    def add_schema_history_table(self):
        raise NotImplementedError

    def add_schema_history_table_entry(self):
        raise NotImplementedError

    def update_schema_history_table_entry(self, data, index_done):
        raise NotImplementedError

    def get_schema_history_table_data(self):
        raise NotImplementedError

    def add_database_lock(self):
        raise NotImplementedError

    def remove_database_lock(self):
        raise NotImplementedError

    def clean_all_tables(self):
        raise NotImplementedError


class DatabasePlugin(object):
    """Upon creation, this class will read the plugins package for modules.

    that contain a class definition that is inheriting from the Plugin class
    """

    def __init__(self, plugin_package):
        """Initiate the reading of all available plugins.

        When an instance of the PluginCollection object is created.
        """
        self.plugin = Plugin()
        self.load_plugin(plugin_package)
        """
        self.reload_plugins()
        for plugin in self.plugins:
            if plugin.__name__ == plugin_package:
                self.plugin = plugin
            break
        else:
            raise ValueError(f"{plugin_package} not found")
        """

    def connect(self):
        self.plugin.connect()

    def execute(self, sql: str):
        self.plugin.execute(sql)

    def commit(self):
        self.plugin.commit()

    def close(self):
        self.plugin.close()

    def add_schema_history_table(self):
        self.plugin.add_schema_history_table()

    def add_schema_history_table_entry(self, data):
        self.plugin.add_schema_history_table_entry(data)

    def update_schema_history_table_entry(self, data, index_done):
        self.plugin.update_schema_history_table_entry(data, index_done)

    def get_schema_history_table_data(self):
        return self.plugin.get_schema_history_table_data()

    def add_database_lock(self):
        self.plugin.add_database_lock()

    def remove_database_lock(self):
        raise NotImplementedError

    def load_plugin(self, plugin_package):
        imported_package = __import__("plugins", fromlist=["blah"])

        for _, pluginname, ispkg in pkgutil.iter_modules(
            imported_package.__path__, imported_package.__name__ + "."
        ):
            if f"plugins.{plugin_package}" == pluginname:
                if not ispkg:
                    plugin_module = __import__(pluginname, fromlist=["blah"])
                    clsmembers = inspect.getmembers(plugin_module, inspect.isclass)
                    for (_, clsmember) in clsmembers:
                        if issubclass(clsmember, Plugin) & (clsmember is not Plugin):
                            self.plugin = clsmember()
                break
        else:
            raise ValueError(f"Plugin {plugin_package} not found.")

    def clean_all_tables(self):
        self.plugin.clean_all_tables()


'''
    def reload_plugins(self):
        """Reset the list of all plugins.

        Initiate the walk over the main provided plugin package to load all available plugins
        """
        self.plugins = []
        self.seen_paths = []
        # print()
        # print(f"Looking for plugins under package {self.plugin_package}")
        self.walk_package("plugins")

    def walk_package(self, package):
        """Recursively walk the supplied package to retrieve all plugins."""
        imported_package = __import__(package, fromlist=["blah"])

        for _, pluginname, ispkg in pkgutil.iter_modules(
            imported_package.__path__, imported_package.__name__ + "."
        ):
            if not ispkg:
                plugin_module = __import__(pluginname, fromlist=["blah"])
                clsmembers = inspect.getmembers(plugin_module, inspect.isclass)
                for (_, clsmember) in clsmembers:
                    # Only add classes that are a sub class of Plugin, but NOT Plugin itself
                    if issubclass(clsmember, Plugin) & (clsmember is not Plugin):
                        # print(f"    {c.__module__}.{c.__name__}")
                        self.plugins.append(clsmember())

        # Now that we have looked at all the modules in the current package, start looking
        # recursively for additional modules in sub packages
        all_current_paths = []
        if isinstance(imported_package.__path__, str):
            all_current_paths.append(imported_package.__path__)
        else:
            all_current_paths.extend([x for x in imported_package.__path__])

        for pkg_path in all_current_paths:
            if pkg_path not in self.seen_paths:
                self.seen_paths.append(pkg_path)

                # Get all sub directory of the current package path directory
                child_pkgs = [
                    p
                    for p in os.listdir(pkg_path)
                    if os.path.isdir(os.path.join(pkg_path, p))
                ]

                # For each sub directory, apply the walk_package method recursively
                for child_pkg in child_pkgs:
                    self.walk_package(package + "." + child_pkg)
'''
