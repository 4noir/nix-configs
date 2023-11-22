{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
        auto-pairs
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    extraConfig = ''
      filetype plugin indent on
      set tabstop=4
      set shiftwidth=4
      set scrolloff=4
      set expandtab
      set number
      set relativenumber
      set noshowmode
      set encoding=UTF-8
      set laststatus=3
    '';
    };
    
  imports = [
    ./theme.nix
    ./nerdtree.nix
    ./coc.nix
  ];
}
