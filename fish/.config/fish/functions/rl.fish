# Defined in - @ line 1
function rl --wraps='cd ~/projects/recipe_lab && ll' --description 'alias rl cd ~/projects/recipe_lab && ll'
  cd ~/projects/recipe_lab && ll $argv;
end
