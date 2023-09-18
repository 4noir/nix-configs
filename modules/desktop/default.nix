{pkgs, ...}: 
{
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
    src = ./dwm;
    buildInputs = with pkgs; [ xorg.libX11 xorg.libXinerama imlib2 xorg.libXft ];
  };
  users.users.raph.packages = with pkgs; [
    dash
    gnome.gnome-screenshot
    maim
    xclip
  ];
  programs.slock.enable = true;
  
  systemd.user.services.initscript = {
    enable = true;
    script = ''
/home/raph/.wmscripts/bar.sh
    ''; #FIXME
    wantedBy = [ "graphical.target" ];
    partOf = [ "graphical.target" ];
  };
} 
