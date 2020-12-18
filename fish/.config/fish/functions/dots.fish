# Defined in - @ line 1
function dots --wraps='cd ~/.dotfiles && ll' --description 'alias dots cd ~/.dotfiles && ll'
  cd ~/.dotfiles && ll $argv;
end
