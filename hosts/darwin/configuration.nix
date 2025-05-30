{ config, pkgs, home-manager, ... }:

let
  # Pull in nix-darwin’s Home Manager engine (provided by the home-manager flake input)
  darwinHM = home-manager.darwinModules.home-manager;
in
{
  # 1) Import the Home Manager engine into nix-darwin
  # 2) Your per-user Home Manager config from the flake
  # 3) Any shared HM definitions
  imports = [
    darwinHM
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
  ];

  # Enable Home Manager
  # programs.home-manager.enable = true;

  # System-wide packages to install in /usr/local
  environment.systemPackages = with pkgs; [
    nodejs
    vim
    neovim
    tmux
    rage
  ];

  # Uncomment to auto-upgrade the nix-daemon, etc.
  # services.nix-daemon.enable = true;
  # services.karabiner-elements.enable = true;

  # Enable experimental flakes support
  nix.settings.experimental-features = "nix-command flakes";

  # Use Zsh as the default shell
  programs.zsh.enable = true;

  # Darwin-specific settings
  system.stateVersion  = 4;
  system.primaryUser   = "pjones";
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # Define the macOS user
  users.users.pjones = {
    # isNormalUser = true;
    home         = "/Users/pjones";
    shell        = pkgs.zsh;
  };

  # macOS defaults for Finder and Dock
  system.defaults = {
    dock = {
      autohide                 = true;
      orientation              = "bottom";
      show-process-indicators  = false;
      show-recents             = false;
      static-only              = true;
    };
    finder = {
      AppleShowAllExtensions          = true;
      ShowPathbar                     = true;
      FXEnableExtensionChangeWarning  = false;
    };
    NSGlobalDomain = {
      AppleKeyboardUIMode      = 3;
      "com.apple.keyboard.fnState" = true;
    };
  };
}
