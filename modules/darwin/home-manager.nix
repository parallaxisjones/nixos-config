{ config, pkgs, lib, home-manager, ... }:

let
  user            = "pjones";
  myEmacsLauncher = pkgs.writeScript "emacs-launcher.command" ''
    #!/bin/sh
    emacsclient -c -n &
  '';
  sharedFiles     = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
    ./dock
  ];

  users.users.${user} = {
    name     = "${user}";
    home     = "/Users/${user}";
    isHidden = false;
    # shell    = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks  = pkgs.callPackage ./casks.nix {};
  };

  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        packages                 = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
          sharedFiles
          # additionalFiles

          # Create a placeholder file under ~/.local/share/nvim/lazy so the directory exists
          {
            ".local/share/nvim/lazy/.placeholder".text = "";
          }

          # Create a placeholder file under ~/.local/state/nvim so the directory exists
          {
            ".local/state/nvim/.placeholder".text = "";
          }
        ];
        stateVersion = "23.11";
      };

      programs = {} // import ../shared/home-manager.nix { inherit config pkgs lib; };
      manual.manpages.enable = false;
    };
  };

  local.dock = {
    enable   = true;
    username = user;
    entries  = [];
  };
}
