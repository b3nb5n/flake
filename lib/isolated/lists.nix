rec {
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
}

