# Defined in - @ line 1
function blog --wraps='cd ~/projects/blog && ll' --description 'alias blog cd ~/projects/blog && ll'
  cd ~/projects/blog && ll $argv;
end
