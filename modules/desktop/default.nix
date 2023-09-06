{pkgs, ...}: 
{
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
    src = pkgs.fetchFromGitHub {
      owner = "4noir";
      repo = "dwm";
      rev = "20bd2ad6817639d57b1892bcb9117652280c1bac";
      hash = "sha256-O5LPiZB+mSMKD+Gk1p4AMuj6Imxdw0TJsAqLhMT0aDc=";
    };
  };
  users.users.raph.packages = with pkgs; [
    imlib2
    dash
  ];
} 
