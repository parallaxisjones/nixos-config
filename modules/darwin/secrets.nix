{ config, pkgs, secrets, ... }:

let user = "pjones"; in
{
  age = { 
    identityPaths = [ 
      "/Users/${user}/.ssh/parallaxis"
    ];

    secrets = {
      "openai-key" = {
        symlink = true;   # “after decrypt, symlink into the target path”
        path    = "/Users/${user}/.config/nvim/openai_key.txt";
        file    = "${secrets}/openai-key.age";   # <— the “openai-key.age” inside your secrets repo
        mode    = "600";
        owner   = "${user}";
        # group   = "staff";
      };
      # "syncthing-cert" = {
      #   symlink = true;
      #   path = "/Users/${user}/Library/Application Support/Syncthing/cert.pem";
      #   file =  "${secrets}/darwin-syncthing-cert.age";
      #   mode = "644";
      #   owner = "${user}";
      #   group = "staff";
      # };
      #
      # "syncthing-key" = {
      #   symlink = true;
      #   path = "/Users/${user}/Library/Application Support/Syncthing/key.pem";
      #   file =  "${secrets}/darwin-syncthing-key.age";
      #   mode = "600";
      #   owner = "${user}";
      #   group = "staff";
      # };

      # "github-ssh-key" = {
      #   symlink = true;
      #   path = "/Users/${user}/.ssh/id_github";
      #   file =  "${secrets}/github-ssh-key.age";
      #   mode = "600";
      #   owner = "${user}";
      #   group = "staff";
      # };
      #
      # "github-signing-key" = {
      #   symlink = false;
      #   path = "/Users/${user}/.ssh/pgp_github.key";
      #   file =  "${secrets}/github-signing-key.age";
      #   mode = "600";
      #   owner = "${user}";
      # };
    };
  };
}
