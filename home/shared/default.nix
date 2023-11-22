{ config, pkgs, ... }:

{
  imports = [ 
    ../../hm-modules
    ./shell
    ./fonts
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  home.packages = with pkgs; [
    btop
    bat
    ffmpeg
  ];
}
