{pkgs, ...}:
{
  imports = [
    ./rofi
    ./picom.nix
  ];
  home.packages = with pkgs; [
    feh
    acpi
  ];
  
  home.file.dwm_resources = {
    enable = true;
    source = ./resources;
    target = ".dwm_resources";
    recursive = true;
  };
}
