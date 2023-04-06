# My NixOS configuration

## TODO

* Fix Telegram autostart
* Automate adding new files and folders to the persistent storage
  * Create a script that moves the folder and adds an entry to some CSV file that is read at evaluation time?
* Move global project-specific configuration to individual nix-shell projects
  * e.g. make Android SDK only available in Android projects
* Pull certain Docker images as part of the system build, so they do not have to be persisted
