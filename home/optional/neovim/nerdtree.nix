{pkgs, ...}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nerdtree
    vim-devicons
    nerdtree-git-plugin
    vim-nerdtree-tabs
  ];
   programs.neovim.extraConfig = ''
   nnoremap <C-t> :NERDTreeToggle<CR>
   nnoremap <C-f> :NERDTreeFind<CR>
   " Focus NerdTREE
   nnoremap <leader>n :NERDTreeFocus<CR>
   " Start NERDTree automatically
   if argc() == 0
       autocmd VimEnter * NERDTree | wincmd p
   endif
   " Exit Vim if NERDTree is the only window remaining in the only tab.
   autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
   '';
}
