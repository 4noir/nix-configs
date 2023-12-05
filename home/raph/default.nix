{ config, pkgs, ... }:

{
  imports = [
    ../../modules/desktop/home.nix
    ../shared
    ../optional/vscode.nix
    ../optional/alacritty
    ../optional/neovim
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "raph";
  home.homeDirectory = "/home/raph";

  security.yubikey = {
    enable = true;
    github_username = "4noir";
    key_hash = "sha256-rBX5pTCNO5SZJLyYuNqc0FhjJ1JANkqcu/MHld6YrLo=";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";
  services.autorandr.enable = false;
  programs.autorandr = {
    enable = false;
    profiles.work = {
      fingerprint = {
        eDP-1 = "00ffffffffffff000daef21400000000161c0104a51f117802ee95a3544c99260f505400000001010101010101010101010101010101363680a0703820402e1e240035ad10000018000000fe004e3134304843472d4751320a20000000fe00434d4e0a202020202020202020000000fe004e3134304843472d4751320a2000bb";
	HDMI-2 = "00ffffffffffff0010aca4a04c4d4b323018010380351e78ee7e75a755529c270f5054a54b00714f8180a9c0a940d1c0010101010101023a801871382d40582c45000f282100001e000000ff003954473436344251324b4d4c0a000000fc0044454c4c205532343134480a20000000fd00384c1e5311000a202020202020013002031ff14c9005040302071601141f12132309070765030c00100083010000023a801871382d40582c45000f282100001e011d8018711c1620582c25000f282100009e011d007251d01e206e2855000f282100001e8c0ad08a20e02d10103e96000f282100001800000000000000000000000000000000000000000000000037";
      };
      config = {
        eDP-1 = {
	  enable = true;
	  position = "0x1080";
	  primary = true;
          mode = "1920x1080";
	};
	HDMI-2 = {
	  enable = true;
	  position = "0x0";
          mode = "1920x1080";
	};
      };
    };
    profiles.work_single = {
      fingerprint = {
        laptop = "00ffffffffffff000daef21400000000161c0104a51f117802ee95a3544c99260f505400000001010101010101010101010101010101363680a0703820402e1e240035ad10000018000000fe004e3134304843472d4751320a20000000fe00434d4e0a202020202020202020000000fe004e3134304843472d4751320a2000bb";
      };
      config = {
        laptop = {
	  enable = true;
	  position = "0x0";
	  primary = true;
	};
      };
    };
  };
}
