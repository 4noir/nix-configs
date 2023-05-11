{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "bira";
    };
    sessionVariables = {
      EDITOR = "nvim";
    };
    envExtra = ''
    . "$HOME/.cargo/env"
    '';
  };
}