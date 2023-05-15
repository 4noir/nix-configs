{ lib, config, pkgs, system, ... }:

{
  options = {
    security.yubikey.enable = lib.mkEnableOption "yubikey";
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
          text = ''-----BEGIN PGP PUBLIC KEY BLOCK-----

mDMEZAohcxYJKwYBBAHaRw8BAQdAu+n/gKfKbjWBiWJ6ZJEyDgQ57wH3yxLYg/ex
khTKahC0JlJhcGhhZWwgTGVyb3kgPHJhcGhhZWwubGVyb3lAZXBpdGEuZnI+iJEE
ExYKADkCGwEECwkIBwQVCgkIBRYCAwEAAh4BAheAFiEEKeHlmz4xJc3bNQtgNu6L
BPS4zWUFAmQKIfECGQEACgkQNu6LBPS4zWUhIgEAuaUxiwlv+3/iCmmE5Zi/LmCF
wjU+ptDFaxSHm4K9GMsBAKYS5IqPvUjCV2ZD8giZMTkpuG710q/Ms5PQAAQW/f4E
tCVSYXBoYWVsIExlcm95IDxyLndhbmdsZXJveUBnbWFpbC5jb20+iI4EExYKADYW
IQQp4eWbPjElzds1C2A27osE9LjNZQUCZAohswIbAQQLCQgHBBUKCQgFFgIDAQAC
HgECF4AACgkQNu6LBPS4zWUcFQD/cfiCOsPzap7bA4dqs7LZGxOQnhn6Cj+aVsXV
lYlVGysBALaT9ba8uiFZdwBXzLk2finJjWtthCyvqGqbvdlcYNcOuDMEZAoh/xYJ
KwYBBAHaRw8BAQdAz+LnvK2qvJAxLwyI2mcLfUf4PcJ6iEOMpGirClt20SSI9QQY
FgoAJhYhBCnh5Zs+MSXN2zULYDbuiwT0uM1lBQJkCiH/AhsCBQkB4TOAAIEJEDbu
iwT0uM1ldiAEGRYKAB0WIQSL06RMXwXYeuS8A6tH6DmkJULuIwUCZAoh/wAKCRBH
6DmkJULuI4aZAPoCIonqKm04uAAt0k66Vqf+FSqog4or9ANHCnutSxpuUgD9EvMV
9yed9G6pGunDF62PNaawpE1pxUWJ2esoxvPPcAZd2wD+KAp86gFSHDLx8qUC9btn
Y2qlRAvuLZqD8lZw8AsForcA/3a93fTBLenagMSdb2Q1HmqS8+rrt8jzkprquzH4
tvIKuDgEZAoiERIKKwYBBAGXVQEFAQEHQDHPAdZJs5VpVLmicYGpcFp/T5MZGoIm
UMxrSi01sylBAwEIB4h+BBgWCgAmFiEEKeHlmz4xJc3bNQtgNu6LBPS4zWUFAmQK
IhECGwwFCQHhM4AACgkQNu6LBPS4zWXvTAEAu0sL+RP8RavtLDC7L4AbSTRcfZac
4vFJftTrqsEWkUEA/1FiKE5WKEaX6qQyst5yKHEGS7EB2thvd8mQL6SjzzYPuDME
ZAoiHxYJKwYBBAHaRw8BAQdAhUB6lII1KDSl3pGLcFda5KdM8AMGxClgM1IPsho+
nhaIfgQYFgoAJhYhBCnh5Zs+MSXN2zULYDbuiwT0uM1lBQJkCiIfAhsgBQkB4TOA
AAoJEDbuiwT0uM1lRc4A+QGh6rkAktxFo6qjjFmb9RLCuVP5eHF2FNhkPts5zwsU
AQDCBFBUMQbPgqXZKp8P9dAas3FSy/dqo9KR6XFhEE5sBg==
=k78o
-----END PGP PUBLIC KEY BLOCK-----'';
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
