{ config, pkgs, lib, agenix, ... }:

let
  # 1) Point to your actual .pub files on each machine:
  pjonesPublicKey     = builtins.readFile "/Users/pjones/.ssh/parallaxis.pub";
  parallaxisPublicKey = builtins.readFile "/home/parallaxis/.ssh/parallaxis.pub";

  # 2) List the platforms for which we want secrets:
  systems = [ "x86_64-linux" "aarch64-darwin" ];
in

# 3) Wrap the argument to agenix.lib.secrets in `rec { … }` so that
#    “pjones” and “parallaxis” (the user‐labels) are in scope
age = agenix.lib.secrets (rec {
  inherit systems;

  users = {
    # macOS (“pjones”) can decrypt macOS-only secrets
    pjones = { publicKeys = [ pjonesPublicKey ]; };

    # NixOS (“parallaxis”) can decrypt Linux-only secrets
    parallaxis = { publicKeys = [ parallaxisPublicKey ]; };
  };

  ageFiles = {
    # openai-key.age should be decrypted by *both* labels
    "openai-key.age".publicKeys = [ pjones parallaxis ];
  };
});
