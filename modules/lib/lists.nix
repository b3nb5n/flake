{ ... }: {
  flake.lib.lists = rec {
    commonHead = a: b: let
      isEmpty = (builtins.length a) == 0 || (builtins.length b) == 0;
      head = builtins.head a;
      matchingHead = head == builtins.head b;
      recurse = commonHead (builtins.tail a) (builtins.tail b);
    in if isEmpty || !matchingHead then [] else [ head ] ++ recurse;
  };
}
