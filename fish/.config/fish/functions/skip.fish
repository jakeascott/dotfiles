# Defined in - @ line 1
function skip --wraps='cd ~/projects/skips-website && ll' --wraps='cd ~/projects/jchesterarmstrong && ll' --description 'alias skip cd ~/projects/jchesterarmstrong && ll'
  cd ~/projects/jchesterarmstrong && ll $argv;
end
