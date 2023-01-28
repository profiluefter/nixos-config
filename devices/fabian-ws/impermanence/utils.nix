{ pkgs, ... }:
{
  home-manager.users.fabian.home.packages = [ pkgs.inotify-tools ];
  home-manager.users.fabian.programs.bash.shellAliases = {
    fs-diff = "bash ${./fs-diff.sh}";
    fs-watch = "inotifywait -m -e modify -r";
  };

  # fs-watch -e create -e delete @.cache . | grep --invert-match --ignore-case --extended-regexp  "discord|wayland-session.log|firefox" | uniq > kdesettings.log
}
