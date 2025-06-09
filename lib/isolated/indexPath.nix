let
  index = value: key:
    if builtins.isAttrs value then
      builtins.getAttr key value
    else if builtins.isList value then
      builtins.elemAt value key
    else
      null;
in

path: value:
builtins.foldl' index value path
