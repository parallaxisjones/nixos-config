# configuration.nix

{ pkgs, ... }: 

{
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages =
    [
      pkgs.nodejs
      #pkgs.rustup 
      pkgs.vim
      pkgs.neovim
      pkgs.tmux
      pkgs.rage
    ];
    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
    services.karabiner-elements.enable = true;
    # nix.package = pkgs.nix;

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # Create /etc/zshrc that loads the nix-darwin environment.
    
    programs.zsh.enable = true;  # default shell on catalina
    # programs.fish.enable = true;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 4;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";
    nixpkgs.config.allowUnfree = true;

    users.users.pjones = {
        name = "pjones";
        home = "/Users/pjones";
        shell = pkgs.zsh;
    };

    system.defaults = {
      dock = {
        autohide = true;
        orientation = "bottom";
        show-process-indicators = false;
        show-recents = false;
        static-only = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        FXEnableExtensionChangeWarning = false;
      };
      NSGlobalDomain = {
        AppleKeyboardUIMode = 3;
        "com.apple.keyboard.fnState" = true;
      };
    };
}

