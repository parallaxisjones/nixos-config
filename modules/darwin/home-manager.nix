{ config, pkgs, lib, home-manager, agenix, secrets, ... }:

let
  user            = "pjones";
  myEmacsLauncher = pkgs.writeScript "emacs-launcher.command" ''
    #!/bin/sh
    emacsclient -c -n &
  '';
  sharedFiles     = import ../shared/files.nix { inherit config pkgs lib; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
    # agenix.homeManagerModules.default
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
          additionalFiles
          # ──────────────────────────────────────────────────────────────────────
          # 1) Ensure ~/.cache/nvim/avante/clipboard exists
          {
            ".cache/nvim/avante/clipboard/.placeholder".text = "";
          }

          # 2) Ensure ~/.local/share/nvim/avante/clipboard exists
          {
            ".local/share/nvim/avante/clipboard/.placeholder".text = "";
          }

          # 3) Ensure ~/.local/state/nvim/avante exists (if Avante ever writes there)
          {
            ".local/state/nvim/avante/.placeholder".text = "";
          }

          # 4) You already want ~/.local/share/nvim/lazy for Lazy.nvim
          {
            ".local/share/nvim/lazy/.placeholder".text = "";
          }

          # 5) And ~/.local/state/nvim (for Lazy’s lockfile)
          {
            ".local/state/nvim/.placeholder".text = "";
          }
        ];
        stateVersion = "23.11";
      };
      imports = [
        agenix.homeManagerModules.default
        # ./secrets.nix 
      ];
      # ─────────────────────────────────────────────────────────────────────────
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
