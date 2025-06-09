let
  listsLib = import ./lists.nix;

  mapLeaves = path: fn: value:
    if builtins.isAttrs value then
      builtins.mapAttrs
        (name: mapLeaves (path ++ [ name ]) fn)
        value
    else if builtins.isList value then
      listsLib.mapIdx
        (idx: mapLeaves (path ++ [ idx ]) fn)
        value
    else
      fn path value;
in

mapLeaves [ ]
