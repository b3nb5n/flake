{ ... }: {
  flake.lib.lists = rec {
    mapIdx = f: list:
      builtins.genList (n: f n (builtins.elemAt list n)) (builtins.length list);

    slice = start: count: list:
      let len = builtins.length list;
      in builtins.genList (n: builtins.elemAt list (n + start))
      (if start >= len then
        0
      else if start + count > len then
        len - start
      else
        count);

    flatten = x:
      if builtins.isList x then builtins.concatMap (y: flatten y) x else [ x ];

    contains = list: target: builtins.any (el: el == target) list;

    commonHead = a: b: let
      isEmpty = (builtins.length a) == 0 || (builtins.length b) == 0;
      head = builtins.head a;
      matchingHead = head == builtins.head b;
      recurse = commonHead (builtins.tail a) (builtins.tail b);
    in if isEmpty || !matchingHead then [] else [ head ] ++ recurse;
  };
}
