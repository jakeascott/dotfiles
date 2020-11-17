# Defined in - @ line 1
function upgrade --wraps='sudo dnf upgrade -y' --description 'alias upgrade sudo dnf upgrade -y'
  sudo dnf upgrade -y $argv;
end
