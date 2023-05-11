{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
    [ vim
      gnupg
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          vscodevim.vim
          jdinhlife.gruvbox
          pkief.material-product-icons
          jnoortheen.nix-ide
          dbaeumer.vscode-eslint
        ] ++ vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "vscode-jest";
            publisher = "Orta";
            version = "5.2.3";
            sha256 = "sha256-cPHwBO7dI44BZJwTPtLR7bfdBcLjaEcyLVvl2Qq+BgE=";
          }
        ];
      })
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    brews = [
      "yubikey-personalization"
      "hopenpgp-tools"
      "ykman"
      "pinentry-mac"
      "wget"
    ];
  };
}
