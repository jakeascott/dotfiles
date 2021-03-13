# Defined in - @ line 1
function gits --wraps='ssh git' --description 'alias gits ssh git'
  ssh git $argv;
end
