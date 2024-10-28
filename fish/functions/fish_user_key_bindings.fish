function fish_user_key_bindings
  # fzf
  bind \cf fzf_change_directory

  # vim-like
  bind \cl forward-char

  # prevent iterm2 from closing when typing Ctrl-D (EOF)
  bind \cd delete-char
end

# fzf plugin
if type -q fzf_configure_bindings
    fzf_configure_bindings --directory=\co
end

fzf --fish | source
