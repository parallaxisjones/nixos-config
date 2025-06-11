{ pkgs, config, lib, ... }:

let

  cheatsheetPath = ./config/cheat/cheatsheets/system;
  cheatsheetFiles = builtins.readDir cheatsheetPath;
  mkCheatsheet = name: type: lib.nameValuePair ".config/cheat/cheatsheets/system/${name}" {
    source = cheatsheetPath + "/${name}";
  };
  cheatsheets = lib.mapAttrs' mkCheatsheet (lib.filterAttrs (n: v: v == "regular") cheatsheetFiles);

in

{
  ".ssh/id_github.pub" = {
    source = ./config/id_github.pub;
  };

  ".ssh/pgp_github.pub" = {
    source = ./config/pgp_github.pub;
  };

  ".config/nvim" = {
    source = ./config/nvim;
    recursive = true;
  };

  ".config/op-setup.sh" = {
    source = ./config/op-setup.sh;
  };

  ".config/cheat/conf.yml" = {
    source = ./config/cheat_conf.yml;
  };
} // cheatsheets
