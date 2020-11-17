# Defined in - @ line 1
function ll --wraps='ls -goh' --description 'alias ll ls -goh'
  ls -goh $argv;
end
