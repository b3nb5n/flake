str:

let
  parts = builtins.split "[[:space:]]+" str;
  contentParts = builtins.filter (part: builtins.isString part && part != "") parts;
  concat = builtins.concatStringsSep " ";
in

concat contentParts
