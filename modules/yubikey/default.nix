{lib, config, pkgs, ...}:
{
  options = {
    security.yubikey.enable = lib.mkEnableOption "yubikey";
  };

  config = lib.mkIf config.security.yubikey.enable {
    environment.systemPackages = with pkgs; [yubikey-manager yubikey-personalization];
    programs.gnupg.agent.enable = true;
    programs.gnupg.agent.enableSSHSupport = lib.mkOverride 1000 true;
  };
}
