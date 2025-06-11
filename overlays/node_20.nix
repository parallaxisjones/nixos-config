# overlays/nodejs-20-override.nix
final: prev: rec {
  # Rebind pkgs.nodejs to the nodejs_20 attribute
  nodejs = prev.nodejs_20;

  # Now override nodePackages so it all uses that same nodejs
  nodePackages = prev.nodePackages.override {
    inherit nodejs;
  };
}
