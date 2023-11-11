{ pkgs, config, nixColors, stylix, ... }: let
  darkMode = true;

  colors-lib = nixColors.lib.contrib { inherit pkgs; };

  gtkConfig = {
    gtk-application-prefer-dark-theme = darkMode;
  };
in {
  imports = [
    nixColors.homeManagerModule
    stylix.homeManagerModules.stylix
  ];

  home.packages = with pkgs; [
    dejavu_fonts
    font-awesome
  ];

  colorScheme.colors = {
    base00 = "292d3e"; # Default Background
    base01 = "444267"; # Lighter Background (Used for status bars, line number and folding marks)
    base02 = "5c598b"; # Selection Background
    base03 = "676e95"; # Comments, Invisibles, Line Highlighting
    base04 = "8796b0"; # Dark Foreground (Used for status bars)
    base05 = "959dcb"; # Default Foreground, Caret, Delimiters, Operators
    base06 = "959dcb"; # Light Foreground (Not often used)
    base07 = "ffffff"; # Light Background (Not often used)
    base08 = "6e98e1"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    base09 = "f78c6c"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
    base0A = "e0a557"; # Classes, Markup Bold, Search Text Background
    base0B = "78c06e"; # Strings, Inherited Class, Markup Code, Diff Inserted
    base0C = "83b7e5"; # Support, Regular Expressions, Escape Characters, Markup Quotes
    base0D = "82aaff"; # Functions, Methods, Attribute IDs, Headings
    base0E = "c792ea"; # Keywords, Storage, Selector, Markup Italic, Diff Changed
    base0F = "ff5370"; # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
  };

  # colorScheme = colors-lib.colorSchemeFromPicture {
  #   path = config.home.file.wallpaper.source;
  #   kind = if darkMode then "dark" else "light";
  # };

  stylix = {
    autoEnable = false;
    image = config.home.file.wallpaper.source;
    polarity = "dark";
    base16Scheme = config.colorScheme.colors;
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;

    gtk3.extraConfig = gtkConfig;
    gtk4.extraConfig = gtkConfig;
  };
}