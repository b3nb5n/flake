{ ... }:
let
  mapRec = fn: obj:
    if (builtins.isList obj) then
      (builtins.map (mapRec fn) obj)
    else if (builtins.isAttrs obj) then
      (builtins.mapAttrs (_: mapRec fn) obj)
    else
      fn obj;
in mapRec
