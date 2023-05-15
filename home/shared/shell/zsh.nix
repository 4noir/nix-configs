{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "bira";
    };
    sessionVariables = {
      EDITOR = "vim";
    };
    envExtra = ''
    . "$HOME/.cargo/env"
    '';
  };
}