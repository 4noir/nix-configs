{ lib, config, pkgs, ... }:

{
  imports = [
    ../shared/default.nix
    ../shared/optional/programs/vscode.nix
    ../shared/optional/programs/alacritty.nix
    ../../hm-modules/yubikey.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "shinwoir";
  home.homeDirectory = lib.mkForce "/Users/shinwoir/";
  security.yubikey.enable = true;

  home.packages = with pkgs; [
    ansible
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";
}