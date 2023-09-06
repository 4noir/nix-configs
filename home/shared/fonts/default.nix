{pkgs, ...}:
{
  home.packages = with pkgs; [
    cascadia-code
    iosevka
    # nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; }
  ];
  fonts.fontconfig.enable = true;
    
}
