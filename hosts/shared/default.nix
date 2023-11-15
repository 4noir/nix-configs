{config, pkgs, ...}: 
{
    nixpkgs.config.allowUnfree = true;
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
    services.xserver = {
      layout = "us,us";
      xkbVariant = ",intl";
      xkbOptions = "grp:alt_shift_toggle";
    };

}

