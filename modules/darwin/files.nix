{ user, config, pkgs, ... }:

let
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_dataHome   = "${config.users.users.${user}.home}/.local/share";
  xdg_stateHome  = "${config.users.users.${user}.home}/.local/state";

  home = config.users.users.${user}.home;
  mcpServers = import ../shared/mcp-servers.nix { inherit home; };
in
{
  # Other file definitions can go here...
  "${xdg_configHome}/mcphub/servers.json".text = builtins.toJSON { mcpServers = mcpServers; };
}
