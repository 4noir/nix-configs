{ lib, config, pkgs, system,  ... }:

{
  options = {
    security.yubikey.enable = lib.mkEnableOption "yubikey";
    security.yubikey.github_username = lib.mkOption {
      type = with lib.types; uniq string;
      description = "github username to fetch public gpg key from";
    };
    security.yubikey.key_hash = lib.mkOption {
      type = with lib.types; uniq string;
      description = "sha256 hash of the public gpg key file";
    };
  };

  config = lib.mkIf config.security.yubikey.enable {
    programs.zsh.initExtra = ''
      gpg-connect-agent /bye
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    '';

    home.packages = with pkgs; [ wget yubikey-manager yubikey-personalization ];
    programs.gpg = {
      enable = true;
      publicKeys =
          [{
          text = builtins.readFile (pkgs.fetchurl {
            url = "https://github.com/${config.security.yubikey.github_username}.gpg"; 
            hash = "${config.security.yubikey.key_hash}";
          });
          trust = 5;
        }];
      settings = {
        personal-cipher-preferences = [ "AES256" "AES192" "AES" ];
        personal-digest-preferences = [ "SHA512" "SHA384" "SHA256" ];
        personal-compress-preferences = [ "ZLIB" "BZIP2" "ZIP" "Uncompressed" ];
        default-preference-list = [
          "SHA512"
          "SHA384"
          "SHA256"
          "AES256"
          "AES192"
          "AES"
          "ZLIB"
          "BZIP2"
          "ZIP"
          "Uncompressed"
        ];
        cert-digest-algo = "SHA512";
        s2k-digest-algo = "SHA512";
        s2k-cipher-algo = "AES256";
        charset = "utf-8";
        fixed-list-mode = true;
        no-comments = true;
        no-emit-version = true;
        no-greeting = true;
        keyid-format = "0xlong";
        list-options = "show-uid-validity";
        verify-options = "show-uid-validity";
        with-fingerprint = true;
        require-cross-certification = true;
        no-symkey-cache = true;
        use-agent = true;
        throw-keyids = true;
      };
    };



    services.gpg-agent =
      if system != "aarch64-darwin" then {
        enable = true;
        enableSshSupport = true;
        enableZshIntegration = true;
        defaultCacheTtl = 60;
        maxCacheTtl = 120;
        pinentryFlavor = "curses";
      } else { };
    home.file =
      if system == "aarch64-darwin" then {
        "gpg-agent.conf" = {
          enable = true;
          target = ".gnupg/gpg-agent.conf";
          text = ''
            # https://github.com/drduh/config/blob/master/gpg-agent.conf
            # https://www.gnupg.org/documentation/manuals/gnupg/Agent-Options.html
            enable-ssh-support
            ttyname $GPG_TTY
            default-cache-ttl 60
            max-cache-ttl 120
            # pinentry-program /Users/shinwoir/.nix-profile/bin/pinentry-curses
            #pinentry-program /usr/bin/pinentry-tty
            #pinentry-program /usr/bin/pinentry-gtk-2
            #pinentry-program /usr/bin/pinentry-x11
            #pinentry-program /usr/bin/pinentry-qt
            #pinentry-program /usr/local/bin/pinentry-curses
            #pinentry-program /usr/local/bin/pinentry-mac
            pinentry-program /opt/homebrew/bin/pinentry-mac
          '';
        };
      } else { };

  };
}
