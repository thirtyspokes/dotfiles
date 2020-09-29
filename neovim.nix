{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # Fuzzy file-finder
      ctrlp

      # Helps get indentation right
      vim-indent-guides

      # Base plugin for most lang packages
      syntastic

      # Git + Vim
      vim-fugitive

      # Utilities for showing/removing whitespace
      vim-better-whitespace

      # Go language features
      vim-go

      # Elixir language features
      vim-elixir

      # Syntax for protobufs
      vim-protobuf

      # Nord theme
      nord-vim
    ];

    extraConfig = ''
      set nocompatible

      syntax enable

      let $NVIM_TUI_ENABLE_TRUE_COLOR=1

      colorscheme nord

      filetype on
      filetype off

      filetype plugin indent on

      set autoindent
      set autoread
      set backspace=2
      set backupcopy=yes
      set clipboard=unnamed
      set directory-=.
      set encoding=utf-8
      set expandtab
      set ignorecase
      set incsearch
      set laststatus=2
      set number
      set ruler
      set scrolloff=3
      set shiftwidth=2
      set showcmd
      set smartcase
      set softtabstop=2
      set tabstop=8
      set wildignore=_build/**,log/**,node_modules/**,target/**,tmp/**,*.rbc
      set wildmenu
      set wildmode=longest,list,full
      set mouse=a

      let mapleader = ','
      noremap <C-h> <C-w>h
      noremap <C-j> <C-w>j
      noremap <C-k> <C-w>k
      noremap <C-l> <C-w>l
      nnoremap <leader>b :CtrlPBuffer<CR>
      nnoremap <leader>t :CtrlP<CR>
      nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
      nnoremap <leader>g :GitGutterToggle<CR>
      cnoremap w!! %!sudo tee > /dev/null %

      let g:ctrlp_match_window = 'order:ttb,max:20'
      let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
      let g:gitgutter_enabled = 0

      if executable('rg')
        let g:ctrlp_user_command = 'rg %s --smart-case --no-require-git --files --color=never --glob ""'
      endif

      autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
      autocmd BufRead,BufNewFile *.md set filetype=markdown
      autocmd BufRead,BufNewFile *.md set spell

      if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
      else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
      endif

      vnoremap p "_dP

      let g:go_fmt_command = "gofumports"

      let g:better_whitespace_enabled=1
      nnoremap <leader><space> :StripWhitespace<CR>
    '';
  };
}
