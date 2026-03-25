{ ... }: {
  flake.lib.path = rec {
    nameSegments = path:
      let
        baseName = builtins.baseNameOf path;
        segmentMatches = builtins.split "[.]" baseName;
        matchFilter = match:
          (builtins.isString match) && ((builtins.stringLength match) > 0);
      in builtins.filter matchFilter segmentMatches;

    name = path: builtins.head (nameSegments path);

    ext = path:
      let segments = builtins.tail (nameSegments path);
      in builtins.concatStringsSep "." segments;

    segments = path:
      let
        base = builtins.baseNameOf path;
        dir = builtins.dirOf path;
        isRoot = base == "";
      in if isRoot then [ ] else (segments dir) ++ [ base ];

    relative = src: dst:
      let
        commonHead = a: b:
          let
            isEmpty = (builtins.length a) == 0 || (builtins.length b) == 0;
            head = builtins.head a;
            matchingHead = head == builtins.head b;
            recurse = commonHead (builtins.tail a) (builtins.tail b);
          in if isEmpty || !matchingHead then [ ] else [ head ] ++ recurse;

        srcSegments = segments src;
        dstSegments = segments dst;

        commonParent = commonHead srcSegments dstSegments;
        commonLen = builtins.length commonParent;

        upLen = (builtins.length srcSegments) - commonLen;
        upSegments = builtins.genList (_idx: "..") upLen;

        downLen = (builtins.length dstSegments) - commonLen;
        downSegment = idx: builtins.elemAt dstSegments (commonLen + idx);
        downSegments = builtins.genList downSegment downLen;

        relativeSegments = upSegments ++ downSegments;
      in builtins.concatStringsSep "/" relativeSegments;
  };
}
