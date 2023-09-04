{ config, pkgs, ... }:

{
  imports = [ 
    ../../hm-modules
    ./shell
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  home.packages = with pkgs; [
    cascadia-code
    btop
    neovim
    bat
  ];

  fonts.fontconfig.enable = true;
}
