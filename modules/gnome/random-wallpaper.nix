{ config, pkgs, lib, ... }:

let
  # Build a little CLI tool that picks & sets a random GNOME wallpaper.
  randomWallpaper = pkgs.writeShellScriptBin "random-wallpaper" ''
    #!/usr/bin/env bash
    WALLPAPER_DIR="$HOME/Pictures/wallpapers"
    # pick one at random
    selection=$(
      find "$WALLPAPER_DIR" \
        -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) \
      | shuf -n1
    )
    selection=$(realpath "$selection")
    # tell GNOME to use it
    gsettings set org.gnome.desktop.background picture-uri \
      "file://$selection"
    gsettings set org.gnome.desktop.background picture-options "zoom"
  '';
in
{
  # Make the script and its helpers available to all users
  environment.systemPackages = [
    randomWallpaper
    pkgs.findutils            # for `find`
    pkgs.coreutils            # for `realpath`, `shuf`
    pkgs.gsettings-desktop-schemas  # GNOME gsettings schemas
  ];

  # Systemd USER service: run the script once on demand
  systemd.user.services.random-wallpaper = {
    description = "Pick a random GNOME wallpaper";
    after       = [ "graphical-session.target" ];
    wantedBy    = [ "graphical-session.target" ];
    serviceConfig = {
      Type      = "oneshot";
      ExecStart = "${randomWallpaper}";
    };
  };

  # Systemd USER timer: fire that service every hour
  systemd.user.timers.random-wallpaper = {
    description = "Rotate GNOME wallpaper hourly";
    wantedBy    = [ "timers.target" ];
    timerConfig = {
      # OnUnitActiveSec = "1min";
      # Persistent      = true;  # if the machine was off, run at next login
      OnCalendar = "hourly";
      Persistent = true;  # if the machine was off/missed a beat, run at next boot
    };
  };
}
