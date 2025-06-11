{ pkgs, ... }:

let
  myPython = pkgs.python3.withPackages (ps: with ps; [
    slpp
    pip
    rich
    virtualenv
    black
  ]);
in

with pkgs; [
  # General packages for development and system management
  act
  alacritty
  aspell
  aspellDicts.en
  bash-completion
  bat
  btop
  coreutils
  difftastic
  du-dust
  gcc
  git-filter-repo
  killall
  neofetch
  openssh
  pandoc
  sqlite
  wget
  zip
  uv
  rust-analyzer
  rustfmt
  libiconv

  # BEAM
  gleam
  elixir
  erlang
  zig
  # Encryption and security tools
  _1password-cli
  age
  age-plugin-yubikey
  gnupg
  libfido2
  pkg-config
  # Cloud-related tools and SDKs
  flyctl
  google-cloud-sdk
  go
  gopls
  ngrok
  ssm-session-manager-plugin
  terraform
  terraform-ls
  tflint
  neovim
  zellij
  zsh
  # Media-related packages
  emacs-all-the-icons-fonts
  imagemagick
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  glow
  hack-font
  jpegoptim
  meslo-lgs-nf
  noto-fonts
  noto-fonts-emoji
  pngquant
  cheat
  cargo
  # Node.js development tools
  fzf
  nodePackages.live-server
  nodePackages.nodemon
  nodePackages.prettier
  nodePackages.npm
  nodejs

  # Source code management, Git, GitHub tools
  gh

  tig
  # Text and terminal utilities
  htop
  hunspell
  iftop
  jetbrains-mono
  jetbrains.phpstorm
  jq
  ripgrep
  slack
  tree
  tmux
  unrar
  unzip
  zsh-powerlevel10k
  eza
  myPython
  lua-language-server
]
