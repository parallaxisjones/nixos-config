{ config, pkgs, lib, ... }:

let
  # build a little CLI script that picks & sets a random wallpaper
  randomWallpaper = pkgs.writeShellScriptBin "random-wallpaper" ''
    #!/usr/bin/env bash
    WALLPAPER_DIR="$HOME/Pictures/wallpapers"
    selection=$(
      find "$WALLPAPER_DIR" \
        -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) \
      | shuf -n1
    )
    selection=$(realpath "$selection")
    gsettings set org.gnome.desktop.background picture-uri \
      "file://$selection"
    gsettings set org.gnome.desktop.background picture-options "zoom"
  '';
in {
  # ensure the tools we need are in $PATH
  home.packages = with pkgs; [
    findutils    # for `find`
    coreutils    # for `realpath`
    gsettings-desktop-schemas  # for the gsettings binary & schemas
  ];

  # enable user-level systemd units
  services.systemd.user.enable = true;

  # define a oneshot service that runs our script
  services.systemd.user.services.random-wallpaper = {
    description = "Pick a random GNOME wallpaper";
    after       = [ "graphical-session.target" ];
    wantedBy    = [ "graphical-session.target" ];
    serviceConfig = {
      Type      = "oneshot";
      ExecStart = "${randomWallpaper}";
    };
  };

  # define a timer to fire it every hour
  services.systemd.user.timers.random-wallpaper = {
    description = "Rotate GNOME wallpaper hourly";
    wantedBy    = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;  # run once after reboot if you missed a tick
    };
  };
}
