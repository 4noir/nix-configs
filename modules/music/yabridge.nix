{pkgs, conf, ...}:

{
    environment.systemPackages = with pkgs; [
        yabridge
        yabridgectl
        wineWowPackages.staging
        winetricks
    ];
}

