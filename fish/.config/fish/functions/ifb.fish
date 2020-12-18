# Defined in - @ line 1
function ifb --wraps='cd ~/projects/ifb && ll' --description 'alias ifb cd ~/projects/ifb && ll'
  cd ~/projects/ifb && ll $argv;
end
