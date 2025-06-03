{ config, pkgs, lib, agenix, ... }:

let
  # ────────────────────────────────────────────────────────────────────────────
  # 1) Define each user’s SSH public key (the actual "ssh-ed25519 AAAA…"-style string).
  #
  #    - On macOS you want “pjones” to be able to decrypt the Darwin-specific secrets.
  #    - On NixOS you want “parallaxis” to be able to decrypt the Linux-specific secrets.
  #
  pjonesPublicKey     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAao6hYRda8Dc88DgWHblVFV/HFCcj6kJuDWq7oqt7Aq";
  parallaxisPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAao6hYRda8Dc88DgWHblVFV/HFCcj6kJuDWq7oqt7Aq";

  # ────────────────────────────────────────────────────────────────────────────
  # 2) Declare which platforms we want agenix to produce secrets for.
  #    We build for both:
  #      • x86_64-linux (regular NixOS),
  #      • aarch64-darwin (Apple Silicon macOS) [and we could also list x86_64-darwin if needed].
  #
  systems = [ "x86_64-linux" "aarch64-darwin" ];

in
{
  # ────────────────────────────────────────────────────────────────────────────
  # 3) Tell agenix about all of our encrypted files in “./modules/shared/secrets/”.
  #
  #    Each key here must match exactly the “.age” file name relative to the flake root.
  #
  #    We will decrypt:
  #       • “darwin-syncthing-cert.age”   → only pjones can read it on aarch64-darwin
  #       • “darwin-syncthing-key.age”    → only pjones on aarch64-darwin
  #       • “nixos-syncthing-cert.age”    → only parallaxis on x86_64-linux
  #       • “nixos-syncthing-key.age”     → only parallaxis on x86_64-linux
  #       • “openai-key.age”              → both pjones + parallaxis on both systems
  #       • “github-ssh-key.age”          → only pjones on darwin (for pushing via git over macOS)
  #       • …etc. (add more as needed)
  #
  age = agenix.lib.secrets {
    inherit systems;

    users = {
      pjones = { publicKeys = [ pjonesPublicKey ]; };
      parallaxis = { publicKeys = [ parallaxisPublicKey ]; };
    };

    ageFiles = rec {
      # ─ macOS-only secrets (decryptable by "pjones"):
      # "darwin-syncthing-cert.age".publicKeys   = [ pjones ];
      # "darwin-syncthing-key.age".publicKeys    = [ pjones ];

      # ─ NixOS-only secrets (decryptable by "parallaxis"):
      # "nixos-syncthing-cert.age".publicKeys    = [ parallaxis ];
      # "nixos-syncthing-key.age".publicKeys     = [ parallaxis ];

      # ─ Shared secret, both machines need the same OpenAI key:
      "openai-key.age".publicKeys              = [ pjones parallaxis ];

      # ─ GitHub SSH/SIGNING keys: only macOS (pjones) needs to decrypt them
      # "github-ssh-key.age".publicKeys          = [ pjones parallaxis ];
      # "github-signing-key.age".publicKeys      = [ pjones parallaxis ];
    };
  };
}
