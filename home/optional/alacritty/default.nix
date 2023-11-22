{
  imports = [ ./theme_kanagawa.nix ];
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      font = {
        size = 11;
      };
      window = {
        padding = {
          x = 8;
          y = 8;
        };
      };
      shell = {
        program = "zsh";
      };
    };
  };
}
