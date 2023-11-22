{pkgs, ...}:
{
    programs.neovim.plugins = with pkgs.vimPlugins; [
        # vim-airline
        # vim-airline-themes
        # vim-airline-clock
        lualine-nvim
        kanagawa-nvim
    ];
    programs.neovim.extraConfig = ''
colorscheme kanagawa
" let g:airline_powerline_fonts = 1
" let g:airline_theme='ayu_dark'
" let g:airline#extensions#clock#auto = 1
    '';
    programs.neovim.extraLuaConfig = builtins.readFile ./kanagawa.lua + builtins.readFile ./lualine.lua;
}
