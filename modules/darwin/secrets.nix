{ config, pkgs, agenix, secrets, ... }:

let
  user = "pjones";
in {
  programs.agenix = {
    enable = true;
    identityPaths = [ "/Users/${user}/.ssh/parallaxis" ];
    secrets = {
      "openai-key" = {
        symlink = true;
        path    = "/Users/${user}/.config/nvim/openai_key.txt";
        file    = "${secrets}/openai-key.age";
        mode    = "600";
        owner   = "${user}";
        group   = "staff";
      };
    };
  };
}
