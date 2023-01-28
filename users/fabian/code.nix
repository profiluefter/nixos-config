{ config, ... }:
{
  # TODO: device specific
  home.file."code/cpp".source = config.lib.file.mkOutOfStoreSymlink "/data/sync/code-cpp";
  home.file."code/cs".source = config.lib.file.mkOutOfStoreSymlink "/data/sync/code-cs";
  home.file."code/go".source = config.lib.file.mkOutOfStoreSymlink "/data/sync/code-go";
  home.file."code/java".source = config.lib.file.mkOutOfStoreSymlink "/data/sync/code-java";
  home.file."code/js".source = config.lib.file.mkOutOfStoreSymlink "/data/sync/code-js";
  home.file."code/misc".source = config.lib.file.mkOutOfStoreSymlink "/data/sync/code-misc";
  home.file."code/php".source = config.lib.file.mkOutOfStoreSymlink "/data/sync/code-php";
  home.file."code/python".source = config.lib.file.mkOutOfStoreSymlink "/data/sync/code-python";
  home.file."code/rust".source = config.lib.file.mkOutOfStoreSymlink "/data/sync/code-rust";

  home.file."code/pos20".source = config.lib.file.mkOutOfStoreSymlink "/data/sync/school-pos2020-21";
  home.file."code/pos21".source = config.lib.file.mkOutOfStoreSymlink "/data/sync/school-pos2021-22";

  home.file."school".source = config.lib.file.mkOutOfStoreSymlink "/data/sync/school22-23";

  home.file."Documents/Scans".source = config.lib.file.mkOutOfStoreSymlink "/data/sync/scans";
}
