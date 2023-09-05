{
  # dwm
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
    src = pkgs.fetchgit {
      url = "https://github.com/4noir/dwm.git";
      rev = "567c62ef4b2e157a2308e9da822c6a7b8ae03d6f";
      hash = "sha256-SJWSQrYKp1L5kQaTZ7gASsviA/ifxEuLE7CVzR+aSjw=";
    };
  };

}
