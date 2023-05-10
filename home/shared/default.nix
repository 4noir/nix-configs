{ config, pkgs, ... }:

{
  imports = [ ./shell ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;


  home.packages = with pkgs; [
    cascadia-cove
    btop
    neovim
  ];

  fonts.fontconfig.enable = true;
}
