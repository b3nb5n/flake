{ lib, ... }: let
  inherit (lib) mkOption types;

  colorType = types.submodule {
    options = {
      r = mkOption { type = types.ints.u8; };
      g = mkOption { type = types.ints.u8; };
      b = mkOption { type = types.ints.u8; };
    };
  };

  colorOption = mkOption {
    type = colorType;
  };

  shadesOption = mkOption {
    type = types.submodule {
      options = {
        dark = colorOption;
        default = colorOption;
        light = colorOption;
      };
    };
  };

  fontOption = mkOption {
    type = types.submodule {
      options = {
        name = mkOption { type = types.str; };
        pkg = mkOption { type = types.package; };
      };
    };
  };
in mkOption {
  type = types.submodule {
    options = {
      color = mkOption {
        type = types.submodule {
          options = {
            bg = mkOption { type = types.listOf colorType; };
            fg = mkOption { type = types.listOf colorType; };

            accent = shadesOption;
            red = shadesOption;
            orange = shadesOption;
            yellow = shadesOption;
            green = shadesOption;
            cyan = shadesOption;
            blue = shadesOption;
            purple = shadesOption;
            pink = shadesOption;
            black = shadesOption;
            gray = shadesOption;
            white = shadesOption;
          };
        };
      };

      font = mkOption {
        type = types.submodule {
          options = {
            default = fontOption;
            serif = fontOption;
            sans = fontOption;
            mono = fontOption;
            emoji = fontOption;
          };
        };
      };

      gap = mkOption {
        type = types.submodule {
          options = {
            xs = mkOption { type = types.int; };
            sm = mkOption { type = types.int; };
            md = mkOption { type = types.int; };
            lg = mkOption { type = types.int; };
            xl = mkOption { type = types.int; };
          };
        };
      };

      radius = mkOption {
        type = types.submodule {
          options = {
            xs = mkOption { type = types.int; };
            sm = mkOption { type = types.int; };
            md = mkOption { type = types.int; };
            lg = mkOption { type = types.int; };
            xl = mkOption { type = types.int; };
            full = mkOption { type = types.int; };
          };
        };
      }; 
    };    
  };
}