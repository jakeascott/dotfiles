# Defined in - @ line 1
function gits --wraps='ssh git@hub' --description 'alias gits ssh git@hub'
  ssh git@hub $argv;
end
