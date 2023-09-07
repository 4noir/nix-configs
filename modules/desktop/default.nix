{pkgs, ...}: 
{
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
    src = ./dwm;
    buildInputs = with pkgs; [ xorg.libX11 xorg.libXinerama imlib2 xorg.libXft ];
  };
  users.users.raph.packages = with pkgs; [
    dash
  ];
  
  systemd.user.services.initscript = {
    script = ''
/home/raph/.wmscripts/run.sh
    ''; #FIXME
    wantedBy = [ "graphical.target" ];
    partOf = [ "graphical.target" ];
  };
} 
