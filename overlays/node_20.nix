# overlays/nodejs-20-override.nix
final: prev: {
  # Make `pkgs.nodejs` actually be Node 20
  nodejs = prev.nodejs_20;

  # And also rewire nodePackages to that same Node 20
  nodePackages = prev.nodePackages.override {
    inherit nodejs;
  };
}
