{ pkgs, const, usrLib, config, ... }: let
  extensions = (import (pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "nix-vscode-extensions";
    rev = "master";
    sha256 = "esWkfkEM5P78BKtVIf5qbgcD3L4CdXpkkWv+LhPr6PE=";
  })).extensions.${const.system.arch-os}.vscode-marketplace;
in {
  home.sessionVariables = {
    EDITOR = "vscode";
    SPAWNEDITOR = "code";
  };
  
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with extensions; [
      jnoortheen.nix-ide
      naumovs.color-highlight
      miguelsolorio.fluent-icons
      pkief.material-icon-theme
      eamodio.gitlens
      rust-lang.rust-analyzer
      mtxr.sqltools
      vadimcn.vscode-lldb
      wallabyjs.console-ninja
      tamasfe.even-better-toml
      github.copilot
      golang.go
      ms-vscode.hexeditor
      vincaslt.highlight-matching-tag
      yoavbls.pretty-ts-errors
      simonsiefke.svg-preview
      albert.tabout
      tauri-apps.tauri-vscode
      meganrogge.template-string-converter
      uctakeoff.vscode-counter
      antiantisepticeye.vscode-color-picker
      redhat.vscode-yaml
      eww-yuck.yuck
      # remember to invalidate the extensions repo hash
    ];
    keybindings = [];
    languageSnippets = {};
    userSettings = let
      isDarkTheme = usrLib.theme.isDarkTheme config.theme;
      highlightAlpha = 0.8;
    in with config.theme.color // usrLib.color; {
      "window.menuBarVisibility" = "toggle";
      "workbench.productIconTheme" = "fluent-icons";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.fontFamily" = config.theme.font.mono.name;
      "editor.quickSuggestions" = {
        other = true;
        comments = false;
        strings = false;
      };
      "editor.suggestSelection" = "first";
      "editor.suggestInsertMode" = "replace";
      "editor.tabSize" = 2;
      "editor.cursorSurroundingLines" = 8;
      "editor.linkedEditing" = true;
      "editor.minimap.enabled" = false;
      "explorer.confirmDragAndDrop" = false;
      "explorer.confirmDelete" = false;
      "terminal.integrated.fontFamily" = config.theme.font.mono.name;
      "terminal.integrated.cursorBlinking" = true;
      "terminal.integrated.cursorStyle" = "line";
      "terminal.integrated.enableMultiLinePasteWarning" = false;
      "terminal.integrated.env.linux" = {};
      "telemetry.telemetryLevel" = "off";
      "git.enableSmartCommit" = true;
      "git.openRepositoryInParentFolders" = "always";
      "editor.tokenColorCustomizations" = {
        comments = hex gray.default;
        functions = hex blue.default;
        keywords = hex cyan.light;
        numbers = hex orange.default;
        strings = hex green.default;
        types = hex yellow.default;
        variables = hex white.dark;
      };
      # https://code.visualstudio.com/api/references/theme-color
      "workbench.colorCustomizations" = {
        focusBorder = hex accent.default;
        foreground = hex (builtins.elemAt fg 0);
        disabledForeground = hex (builtins.elemAt fg 2);
        "widget.border" = hex (builtins.elemAt fg 2);
        "widget.shadow" = hex (builtins.elemAt bg 0);
        "selection.background" = hex (if isDarkTheme then accent.dark else accent.light);
        descriptionForeground = hex (builtins.elemAt fg 2);
        "icon.foreground" = hex (builtins.elemAt fg 0);

        "textBlockQuote.background" = hex (builtins.elemAt bg 1);
        "textCodeBlock.background" = hex (builtins.elemAt bg 1);
        "textLink.foreground" = hex accent.default;
        "textLink.activeForeground" = hex accent.light;

        "button.background" = hex accent.default; 
        "button.border" = hex accent.default; 
        "button.hoverBackground" = hex accent.light;
        "button.foreground" = hex (builtins.elemAt bg 0);
        "button.secondaryForeground" = hex (builtins.elemAt fg 0);
        "button.secondaryBackground" = hex (builtins.elemAt bg 3);
        "button.secondaryHoverBackground" = hex (builtins.elemAt bg 2);

        "checkbox.background" = hex accent.default;
        "checkbox.border" = hex accent.default;
        "checkbox.foreground" = hex (builtins.elemAt bg 0);
        "checkbox.selectBackground" = hex accent.default;
        "checkbox.selectBorder" = hex accent.default;

        "dropdown.background" = hex (builtins.elemAt bg 0);
        "dropdown.listBackground" = hex (builtins.elemAt bg 0);
        "dropdown.border" = hex (builtins.elemAt bg 0);
        "dropdown.foreground" = hex (builtins.elemAt fg 0);

        "input.background" = hex (builtins.elemAt bg 1);
        "input.border" = hex (builtins.elemAt bg 2);
        "input.foreground" = hex (builtins.elemAt fg 0);
        "input.placeholderForeground" = hex (builtins.elemAt fg 3);
        "inputOption.activeBackground" = hex (builtins.elemAt bg 0);
        "inputOption.activeBorder" = hex accent.default;
        "inputOption.activeForeground" = hex (builtins.elemAt fg 0);
        "inputOption.hoverBackground" = hex (builtins.elemAt bg 0);
        "inputValidation.errorBackground" = hex (builtins.elemAt bg 0);
        "inputValidation.errorForeground" = hex (builtins.elemAt fg 0);
        "inputValidation.errorBorder" = hex red.default;
        "inputValidation.infoBackground" = hex (builtins.elemAt bg 0);
        "inputValidation.infoForeground" = hex (builtins.elemAt fg 0);
        "inputValidation.infoBorder" = hex blue.default;
        "inputValidation.warningBackground" = hex (builtins.elemAt bg 0);
        "inputValidation.warningForeground" = hex (builtins.elemAt bg 0);
        "inputValidation.warningBorder" = hex yellow.default;

        "scrollbar.shadow" = hex (builtins.elemAt bg 0);
        "scrollbarSlider.background" =  hexA (builtins.elemAt bg 3) highlightAlpha;
        "scrollbarSlider.hoverBackground" = hex gray.default;
        "scrollbarSlider.activeBackground" = hex gray.light;

        "badge.foreground" = hex (builtins.elemAt fg 0);
        "badge.background" = hex (builtins.elemAt bg 0);

        "progressBar.background" = hex accent.default;

        "list.activeSelectionBackground" = hex accent.default;
        "list.activeSelectionForeground" = hex (builtins.elemAt bg 0);
        "list.activeSelectionIconForeground" = hex (builtins.elemAt fg 0);
        "list.dropBackground" = hex (builtins.elemAt bg 1);
        "list.focusBackground" = hex (builtins.elemAt bg 0);
        "list.focusForeground" = hex (builtins.elemAt fg 0);
        "list.focusHighlightForeground" = hex (builtins.elemAt fg 0);
        "list.focusOutline" = hex accent.default;
        "list.focusAndSelectionOutline" = hex accent.default;
        "list.highlightForeground" = hex (builtins.elemAt fg 0);
        "list.hoverBackground" = hex (builtins.elemAt bg 1);
        "list.hoverForeground" = hex (builtins.elemAt fg 0);
        "list.inactiveSelectionBackground" = hex (builtins.elemAt bg 1);
        "list.inactiveSelectionForeground" = hex (builtins.elemAt fg 0);
        "list.inactiveSelectionIconForeground" = hex (builtins.elemAt fg 0);
        "list.inactiveFocusBackground" = hex (builtins.elemAt bg 1);
        "list.inactiveFocusOutline" = hex (builtins.elemAt bg 1);
        "list.invalidItemForeground" = hex orange.default;
        "list.errorForeground" = hex red.default;
        "list.warningForeground" = hex yellow.default;
        "listFilterWidget.background" = hex (builtins.elemAt bg 0);
        "listFilterWidget.outline" = hex (builtins.elemAt bg 1);
        "listFilterWidget.noMatchesOutline" = hex red.default;
        "listFilterWidget.shadow" = hex (builtins.elemAt bg 0);
        "list.filterMatchBackground" = hex (builtins.elemAt bg 1);
        "list.filterMatchBorder" = hex (builtins.elemAt bg 1);
        "list.deemphasizedForeground" = hex (builtins.elemAt fg 2);
        "tree.indentGuidesStroke" = hex (builtins.elemAt fg 3);
        "tree.inactiveIndentGuidesStroke" = hex (builtins.elemAt fg 2);
        "tree.tableColumnsBorder" = hex (builtins.elemAt fg 3);
        "tree.tableOddRowsBackground" = hex (builtins.elemAt fg 2);

        "activityBar.background" = hex (builtins.elemAt bg 0); # Activity Bar background color.
        "activityBar.dropBorder" = hex (builtins.elemAt fg 0); # Drag and drop feedback color for the activity bar items. The activity bar is showing on the far left or right and allows to switch between views of the side bar.
        "activityBar.foreground" = hex accent.default; # Activity Bar foreground color (for example used for the icons).
        "activityBar.inactiveForeground" = hex (builtins.elemAt fg 2); # Activity Bar item foreground color when it is inactive.
        "activityBar.border" = hex (builtins.elemAt bg 1); # Activity Bar border color with the Side Bar.
        "activityBarBadge.background" = hex accent.default; # Activity notification badge background color.
        "activityBarBadge.foreground" = hex (builtins.elemAt bg 0); # Activity notification badge foreground color.
        "activityBar.activeBorder" = hex (builtins.elemAt bg 0); # Activity Bar active indicator border color.
        "activityBar.activeBackground" = hex (builtins.elemAt bg 0); # Activity Bar optional background color for the active element.
        "activityBar.activeFocusBorder" = hex (builtins.elemAt bg 0); # Activity bar focus border color for the active item.
        
        "sideBar.background" = hex (builtins.elemAt bg 0);
        "sideBar.foreground" = hex (builtins.elemAt fg 0);
        "sideBar.border" = hex (builtins.elemAt bg 2);
        "sideBar.dropBackground" = hex (builtins.elemAt bg 1);
        "sideBarTitle.foreground" = hex (builtins.elemAt fg 0);
        "sideBarSectionHeader.background" = hex (builtins.elemAt bg 0);
        "sideBarSectionHeader.foreground" = hex (builtins.elemAt fg 0);
        "sideBarSectionHeader.border" = hex (builtins.elemAt bg 2);

        "editorGroup.border" = hex (builtins.elemAt bg 2);
        "editorGroup.dropBackground" = hex (builtins.elemAt bg 2);
        "editorGroupHeader.tabsBackground" = hex (builtins.elemAt bg 0);
        "editorGroupHeader.tabsBorder" = hex (builtins.elemAt bg 0);
        
        "editorGroupHeader.border" = hex (builtins.elemAt bg 0); # Border color between editor group header and editor (below breadcrumbs if enabled).
        "editorGroup.emptyBackground" = hex (builtins.elemAt bg 0); # Background color of an empty editor group.
        "editorGroup.focusedEmptyBorder" = hex (builtins.elemAt bg 1); # Border color of an empty editor group that is focused.
        "editorGroup.dropIntoPromptForeground" = hex (builtins.elemAt fg 1); # Foreground color of text shown over editors when dragging files. This text informs the user that they can hold shift to drop into the editor.
        "editorGroup.dropIntoPromptBackground" = hex (builtins.elemAt bg 1); # Background color of text shown over editors when dragging files. This text informs the user that they can hold shift to drop into the editor.
        "editorGroup.dropIntoPromptBorder" = hex (builtins.elemAt bg 1); # Border color of text shown over editors when dragging files. This text informs the user that they can hold shift to drop into the editor.
        "tab.activeBackground" = hex (builtins.elemAt bg 0); # Active Tab background color in an active group.
        "tab.unfocusedActiveBackground" = hex (builtins.elemAt bg 1); # Active Tab background color in an inactive editor group.
        "tab.activeForeground" = hex (builtins.elemAt fg 0); # Active Tab foreground color in an active group.
        "tab.border" = hex (builtins.elemAt bg 1); # Border to separate Tabs from each other.
        "tab.activeBorder" = hex accent.default; # Bottom border for the active tab.
        "tab.unfocusedActiveBorder" = hex accent.default; # Bottom border for the active tab in an inactive editor group.
        "tab.activeBorderTop" = "#00000000"; # Top border for the active tab.
        "tab.unfocusedActiveBorderTop" = "#00000000"; # Top border for the active tab in an inactive editor group
        "tab.lastPinnedBorder" = hex (builtins.elemAt bg 1); # Border on the right of the last pinned editor to separate from unpinned editors.
        "tab.inactiveBackground" = hex (builtins.elemAt bg 0); # Inactive Tab background color.
        "tab.unfocusedInactiveBackground" = hex (builtins.elemAt bg 0); # Inactive Tab background color in an unfocused group
        "tab.inactiveForeground" = hex (builtins.elemAt fg 1); # Inactive Tab foreground color in an active group.
        "tab.unfocusedActiveForeground" = hex (builtins.elemAt fg 1); # Active tab foreground color in an inactive editor group.
        "tab.unfocusedInactiveForeground" = hex (builtins.elemAt fg 2); # Inactive tab foreground color in an inactive editor group.
        "tab.hoverBackground" = hex (builtins.elemAt bg 0); # Tab background color when hovering
        "tab.unfocusedHoverBackground" = hex (builtins.elemAt bg 1); # Tab background color in an unfocused group when hovering
        "tab.hoverForeground" = hex (builtins.elemAt fg 0); # Tab foreground color when hovering
        "tab.unfocusedHoverForeground" = hex (builtins.elemAt fg 0); # Tab foreground color in an unfocused group when hovering
        "tab.hoverBorder" = hex accent.default; # Border to highlight tabs when hovering
        "tab.unfocusedHoverBorder" = hex (builtins.elemAt bg 0); # Border to highlight tabs in an unfocused group when hovering
        "tab.activeModifiedBorder" = hex (builtins.elemAt bg 0); # Border on the top of modified (dirty) active tabs in an active group.
        "tab.inactiveModifiedBorder" = hex (builtins.elemAt bg 0); # Border on the top of modified (dirty) inactive tabs in an active group.
        "tab.unfocusedActiveModifiedBorder" = hex (builtins.elemAt bg 0); # Border on the top of modified (dirty) active tabs in an unfocused group.
        "tab.unfocusedInactiveModifiedBorder" = hex (builtins.elemAt bg 0); # Border on the top of modified (dirty) inactive tabs in an unfocused group.
        "editorPane.background" = hex (builtins.elemAt bg 0); # Background color of the editor pane visible on the left and right side of the centered editor layout.
        "sideBySideEditor.horizontalBorder" = hex (builtins.elemAt bg 0); # Color to separate two editors from each other when shown side by side in an editor group from top to bottom.
        "sideBySideEditor.verticalBorder" = hex (builtins.elemAt bg 0); # Color to separate two editors from each other when shown side by side in an editor group from left to right.

        "editor.background" = hex (builtins.elemAt bg 1); # Editor background color.
        "editor.foreground" = hex (builtins.elemAt fg 0); # Editor default foreground color.
        "editorLineNumber.foreground" = hex (builtins.elemAt bg 3); # Color of editor line numbers.
        "editorLineNumber.activeForeground" = hex (builtins.elemAt fg 3); # Color of the active editor line number.
        "editorCursor.background" = hex (builtins.elemAt fg 0); # The background color of the editor cursor. Allows customizing the color of a character overlapped by a block cursor.
        "editorCursor.foreground" = hex (builtins.elemAt fg 0); # Color of the editor cursor.
        "editor.selectionBackground" = hexA accent.default highlightAlpha; # Color of the editor selection.
        "editor.inactiveSelectionBackground" = hexA gray.default highlightAlpha; # Color of the selection in an inactive editor. The color must not be opaque so as not to hide underlying decorations.
        "editor.selectionForeground" = hex (builtins.elemAt bg 0); # Color of the selected text for high contrast.
        # "editor.selectionHighlightBackground" = hex (builtins.elemAt bg 3); # Color for regions with the same content as the selection. The color must not be opaque so as not to hide underlying decorations.
        # "editor.wordHighlightBackground" = ; # Background color of a symbol during read-access, for example when reading a variable. The color must not be opaque so as not to hide underlying decorations.
        # "editor.wordHighlightBorder" = ; # Border color of a symbol during read-access, for example when reading a variable.
        # "editor.wordHighlightStrongBackground" = ; # Background color of a symbol during write-access, for example when writing to a variable. The color must not be opaque so as not to hide underlying decorations.
        # "editor.wordHighlightStrongBorder" = ; # Border color of a symbol during write-access, for example when writing to a variable.
        # "editor.wordHighlightTextBackground" = ; # Background color of a textual occurrence for a symbol. The color must not be opaque so as not to hide underlying decorations.
        # "editor.wordHighlightTextBorder" = ; # Border color of a textual occurrence for a symbol.
        "editor.findMatchBackground" = hexA accent.default highlightAlpha; # Color of the current search match.
        "editor.findMatchHighlightBackground" = hexA gray.default highlightAlpha; # Color of the other search matches. The color must not be opaque so as not to hide underlying decorations.
        "editor.findRangeHighlightBackground" = hex (builtins.elemAt bg 3); # Color the range limiting the search (Enable 'Find in Selection' in the find widget). The color must not be opaque so as not to hide underlying decorations.
        # "editor.findMatchBorder" = ; # Border color of the current search match.
        # "editor.findMatchHighlightBorder" = ; # Border color of the other search matches.
        # "editor.findRangeHighlightBorder" = ; # Border color the range limiting the search (Enable 'Find in Selection' in the find widget).
        "search.resultsInfoForeground" = hex (builtins.elemAt fg 1); # Color of the text in the search viewlet's completion message. For example, this color is used in the text that says "{x} results in {y} files".
        "searchEditor.findMatchBackground" = hexA accent.default highlightAlpha; # Color of the editor's results.
        # "searchEditor.findMatchBorder" = ; # Border color of the editor's results.
        # "searchEditor.textInputBorder" = ; # Search editor text input box border.
        "editor.hoverHighlightBackground" = hexA (builtins.elemAt bg 3) highlightAlpha; # Highlight below the word for which a hover is shown. The color must not be opaque so as not to hide underlying decorations.
        "editor.lineHighlightBackground" = "#00000000"; # Background color for the highlight of line at the cursor position.
        "editor.lineHighlightBorder" = "#00000000"; # Background color for the border around the line at the cursor position.
        # "editorUnicodeHighlight.border" = ; # Border color used to highlight unicode characters.
        # "editorUnicodeHighlight.background" = ; # Background color used to highlight unicode characters.
        "editorLink.activeForeground" = hex accent.default; # Color of active links.
        # "editor.rangeHighlightBackground" = ; # Background color of highlighted ranges, used by Quick Open, Symbol in File and Find features. The color must not be opaque so as not to hide underlying decorations.
        # "editor.rangeHighlightBorder" = ; # Background color of the border around highlighted ranges.
        # "editor.symbolHighlightBackground" = ; # Background color of highlighted symbol. The color must not be opaque so as not to hide underlying decorations.
        # "editor.symbolHighlightBorder" = ; # Background color of the border around highlighted symbols.
        # "editorWhitespace.foreground" = ; # Color of whitespace characters in the editor.
        "editorIndentGuide.background1" = hex gray.default; # Color of the editor indentation guides.
        # "editorIndentGuide.background1" = ; # Color of the editor indentation guides (1).
        # "editorIndentGuide.background2" = ; # Color of the editor indentation guides (2).
        # "editorIndentGuide.background3" = ; # Color of the editor indentation guides (3).
        # "editorIndentGuide.background4" = ; # Color of the editor indentation guides (4).
        # "editorIndentGuide.background5" = ; # Color of the editor indentation guides (5).
        # "editorIndentGuide.background6" = ; # Color of the editor indentation guides (6).
        "editorIndentGuide.activeBackground1" = hex (builtins.elemAt fg 1); # Color of the active editor indentation guide.
        # "editorIndentGuide.activeBackground1" = ; # Color of the active editor indentation guides (1).
        # "editorIndentGuide.activeBackground2" = ; # Color of the active editor indentation guides (2).
        # "editorIndentGuide.activeBackground3" = ; # Color of the active editor indentation guides (3).
        # "editorIndentGuide.activeBackground4" = ; # Color of the active editor indentation guides (4).
        # "editorIndentGuide.activeBackground5" = ; # Color of the active editor indentation guides (5).
        # "editorIndentGuide.activeBackground6" = ; # Color of the active editor indentation guides (6).
        "editorInlayHint.background" = "#00000000"; # Background color of inline hints.
        "editorInlayHint.foreground" = hex (builtins.elemAt bg 3); # Foreground color of inline hints.
        # "editorInlayHint.typeForeground" = ; # Foreground color of inline hints for types
        # "editorInlayHint.typeBackground" = ; # Background color of inline hints for types
        # "editorInlayHint.parameterForeground" = ; # Foreground color of inline hints for parameters
        # "editorInlayHint.parameterBackground" = ; # Background color of inline hints for parameters
        # "editorRuler.foreground" = ; # Color of the editor rulers.
        # "editor.linkedEditingBackground" = ; # Background color when the editor is in linked editing mode.
        # "editorCodeLens.foreground" = ; # Foreground color of an editor CodeLens.
        "editorLightBulb.foreground" = hex yellow.default; # The color used for the lightbulb actions icon.
        "editorLightBulbAutoFix.foreground" = hex yellow.default;# The color used for the lightbulb auto fix actions icon.
        "editorBracketMatch.background" = "#00000000"; # Background color behind matching brackets.
        "editorBracketMatch.border" = "#00000000"; # Color for matching brackets boxes.
        "editorBracketHighlight.foreground1" = hex yellow.light; # Foreground color of brackets (1). Requires enabling bracket pair colorization.
        "editorBracketHighlight.foreground2" = hex pink.light; # Foreground color of brackets (2). Requires enabling bracket pair colorization.
        "editorBracketHighlight.foreground3" = hex cyan.light; # Foreground color of brackets (3). Requires enabling bracket pair colorization.
        "editorBracketHighlight.foreground4" = hex orange.light; # Foreground color of brackets (4). Requires enabling bracket pair colorization.
        "editorBracketHighlight.foreground5" = hex green.light; # Foreground color of brackets (5). Requires enabling bracket pair colorization.
        "editorBracketHighlight.foreground6" = hex purple.light; # Foreground color of brackets (6). Requires enabling bracket pair colorization.
        "editorBracketHighlight.unexpectedBracket" = hex red.default; #foreground: Foreground color of unexpected brackets.
        # "editorBracketPairGuide.activeBackground1" = ; # Background color of active bracket pair guides (1). Requires enabling bracket pair guides.
        # "editorBracketPairGuide.activeBackground2" = ; # Background color of active bracket pair guides (2). Requires enabling bracket pair guides.
        # "editorBracketPairGuide.activeBackground3" = ; # Background color of active bracket pair guides (3). Requires enabling bracket pair guides.
        # "editorBracketPairGuide.activeBackground4" = ; # Background color of active bracket pair guides (4). Requires enabling bracket pair guides.
        # "editorBracketPairGuide.activeBackground5" = ; # Background color of active bracket pair guides (5). Requires enabling bracket pair guides.
        # "editorBracketPairGuide.activeBackground6" = ; # Background color of active bracket pair guides (6). Requires enabling bracket pair guides.
        # "editorBracketPairGuide.background1" = ; # Background color of inactive bracket pair guides (1). Requires enabling bracket pair guides.
        # "editorBracketPairGuide.background2" = ; # Background color of inactive bracket pair guides (2). Requires enabling bracket pair guides.
        # "editorBracketPairGuide.background3" = ; # Background color of inactive bracket pair guides (3). Requires enabling bracket pair guides.
        # "editorBracketPairGuide.background4" = ; # Background color of inactive bracket pair guides (4). Requires enabling bracket pair guides.
        # "editorBracketPairGuide.background5" = ; # Background color of inactive bracket pair guides (5). Requires enabling bracket pair guides.
        # "editorBracketPairGuide.background6" = ; # Background color of inactive bracket pair guides (6). Requires enabling bracket pair guides.
        # "editor.foldBackground" = ; # Background color for folded ranges. The color must not be opaque so as not to hide underlying decorations.
        # "editorOverviewRuler.background" = ; # Background color of the editor overview ruler. Only used when the minimap is enabled and placed on the right side of the editor.
        # "editorOverviewRuler.border" = ; # Color of the overview ruler border.
        "editorOverviewRuler.findMatchForeground" = hex accent.light; # Overview ruler marker color for find matches. The color must not be opaque so as not to hide underlying decorations.
        # "editorOverviewRuler.rangeHighlightForeground" = ; # Overview ruler marker color for highlighted ranges, like by the Quick Open, Symbol in File and Find features. The color must not be opaque so as not to hide underlying decorations.
        "editorOverviewRuler.selectionHighlightForeground" = hex gray.default; # Overview ruler marker color for selection highlights. The color must not be opaque so as not to hide underlying decorations.
        "editorOverviewRuler.wordHighlightForeground" = hex gray.light; # Overview ruler marker color for symbol highlights. The color must not be opaque so as not to hide underlying decorations.
        # "editorOverviewRuler.wordHighlightStrongForeground" = ; # Overview ruler marker color for write-access symbol highlights. The color must not be opaque so as not to hide underlying decorations.
        # "editorOverviewRuler.wordHighlightTextForeground" = ; # Overview ruler marker color of a textual occurrence for a symbol. The color must not be opaque so as not to hide underlying decorations.
        "editorOverviewRuler.modifiedForeground" = hex blue.light; # Overview ruler marker color for modified content.
        "editorOverviewRuler.addedForeground" = hex green.light; # Overview ruler marker color for added content.
        "editorOverviewRuler.deletedForeground" = hex red.light; # Overview ruler marker color for deleted content.
        "editorOverviewRuler.errorForeground" = hex red.default; # Overview ruler marker color for errors.
        "editorOverviewRuler.warningForeground" = hex yellow.default; # Overview ruler marker color for warnings.
        "editorOverviewRuler.infoForeground" = hex blue.default; # Overview ruler marker color for infos.
        "editorOverviewRuler.bracketMatchForeground" = hex gray.light; # Overview ruler marker color for matching brackets.
        "editorError.foreground" = hex red.default; # Foreground color of error squiggles in the editor.
        # "editorError.border" = ; # Border color of error boxes in the editor.
        # "editorError.background" = ; # Background color of error text in the editor. The color must not be opaque so as not to hide underlying decorations.
        "editorWarning.foreground" = hex yellow.default; # Foreground color of warning squiggles in the editor.
        # "editorWarning.border" = ; # Border color of warning boxes in the editor.
        # "editorWarning.background" = ; # Background color of warning text in the editor. The color must not be opaque so as not to hide underlying decorations.
        "editorInfo.foreground" = hex blue.default; # Foreground color of info squiggles in the editor.
        # "editorInfo.border" = ; # Border color of info boxes in the editor.
        # "editorInfo.background" = ; # Background color of info text in the editor. The color must not be opaque so as not to hide underlying decorations.
        "editorHint.foreground" = hex green.default; # Foreground color of hints in the editor.
        # "editorHint.border" = ; # Border color of hint boxes in the editor.
        "problemsErrorIcon.foreground" = hex red.default; # The color used for the problems error icon.
        "problemsWarningIcon.foreground" = hex yellow.default; # The color used for the problems warning icon.
        "problemsInfoIcon.foreground" = hex blue.default; # The color used for the problems info icon.
        # "editorUnnecessaryCode.border" = ; # Border color of unnecessary (unused) source code in the editor.
        # "editorUnnecessaryCode.opacity" = ; # Opacity of unnecessary (unused) source code in the editor. For example, "#000000c0" will render the code with 75% opacity. For high contrast themes, use the "editorUnnecessaryCode.border" theme color to underline unnecessary code instead of fading it out.
        # "editorGutter.background" = hex (builtins.elemAt bg 0); # Background color of the editor gutter. The gutter contains the glyph margins and the line numbers.
        "editorGutter.modifiedBackground" = hex blue.default; # Editor gutter background color for lines that are modified.
        "editorGutter.addedBackground" = hex green.default; # Editor gutter background color for lines that are added.
        "editorGutter.deletedBackground" = hex red.default; # Editor gutter background color for lines that are deleted.
        # "editorGutter.commentRangeForeground" = ; # Editor gutter decoration color for commenting ranges.
        # "editorGutter.commentGlyphForeground" = ; # Editor gutter decoration color for commenting glyphs.
        # "editorGutter.commentUnresolvedGlyphForeground" = ; # Editor gutter decoration color for commenting glyphs for unresolved comment threads.
        # "editorGutter.foldingControlForeground" = hex (builtins.elemAt fg 1); # Color of the folding control in the editor gutter.
        # "editorCommentsWidget.resolvedBorder" = ; # Color of borders and arrow for resolved comments.
        # "editorCommentsWidget.unresolvedBorder" = ; # Color of borders and arrow for unresolved comments.
        # "editorCommentsWidget.rangeBackground" = ; # Color of background for comment ranges.
        # "editorCommentsWidget.rangeActiveBackground" = ; # Color of background for currently selected or hovered comment range.


        "diffEditor.insertedTextBackground" = hexA green.light highlightAlpha; # Background color for text that got inserted. The color must not be opaque so as not to hide underlying decorations.
        # "diffEditor.insertedTextBorder" = ; # Outline color for the text that got inserted.
        "diffEditor.removedTextBackground" = hexA red.light highlightAlpha; # Background color for text that got removed. The color must not be opaque so as not to hide underlying decorations.
        # "diffEditor.removedTextBorder" = ; # Outline color for text that got removed.
        "diffEditor.border" = hex (builtins.elemAt bg 0); # Border color between the two text editors.
        "diffEditor.diagonalFill" = hex (builtins.elemAt bg 0); # Color of the diff editor's diagonal fill. The diagonal fill is used in side-by-side diff views.
        "diffEditor.insertedLineBackground" = hexA green.light highlightAlpha; # Background color for lines that got inserted. The color must not be opaque so as not to hide underlying decorations.
        "diffEditor.removedLineBackground" = hexA red.light highlightAlpha; # Background color for lines that got removed. The color must not be opaque so as not to hide underlying decorations.
        "diffEditorGutter.insertedLineBackground" = hex green.default; # Background color for the margin where lines got inserted.
        "diffEditorGutter.removedLineBackground" = hex red.default; # Background color for the margin where lines got removed.
        # "diffEditorOverview.insertedForeground" = ; # Diff overview ruler foreground for inserted content.
        # "diffEditorOverview.removedForeground" = ; # Diff overview ruler foreground for removed content.
        # "diffEditor.unchangedRegionBackground" = ; # The color of unchanged blocks in diff editor.
        # "diffEditor.unchangedRegionForeground" = ; # The foreground color of unchanged blocks in the diff editor.
        # "diffEditor.unchangedCodeBackground" = ; # The background color of unchanged code in the diff editor.
        # "diffEditor.move.border" = ; # The border color for text that got moved in the diff editor.
        # "diffEditor.moveActive.border" = ; # The active border color for text that got moved in the diff editor.

        "editorWidget.foreground" = hex (builtins.elemAt fg 0); # Foreground color of editor widgets, such as find/replace.
        "editorWidget.background" = hex (builtins.elemAt bg 0); # Background color of editor widgets, such as Find/Replace.
        "editorWidget.border" = "#00000000"; # Border color of the editor widget unless the widget does not contain a border or defines its own border color.
        "editorWidget.resizeBorder" = hex (builtins.elemAt bg 2); # Border color of the resize bar of editor widgets. The color is only used if the widget chooses to have a resize border and if the color is not overridden by a widget.
        "editorSuggestWidget.background" = hex (builtins.elemAt bg 0); # Background color of the suggestion widget.
        "editorSuggestWidget.border" = "#00000000"; # Border color of the suggestion widget.
        "editorSuggestWidget.foreground" = hex (builtins.elemAt fg 0); # Foreground color of the suggestion widget.
        "editorSuggestWidget.focusHighlightForeground" = hex (builtins.elemAt fg 0); # Color of the match highlights in the suggest widget when an item is focused.
        "editorSuggestWidget.highlightForeground" = hex (builtins.elemAt fg 1); # Color of the match highlights in the suggestion widget.
        "editorSuggestWidget.selectedBackground" = hex accent.default; # Background color of the selected entry in the suggestion widget.
        "editorSuggestWidget.selectedForeground" = hex (builtins.elemAt fg 0); # Foreground color of the selected entry in the suggest widget.
        "editorSuggestWidget.selectedIconForeground" = hex (builtins.elemAt bg 0); # Icon foreground color of the selected entry in the suggest widget.
        # "editorSuggestWidgetStatus.foreground" = ; # Foreground color of the suggest widget status.
        # "editorHoverWidget.foreground" = ; # Foreground color of the editor hover.
        # "editorHoverWidget.background" = ; # Background color of the editor hover.
        # "editorHoverWidget.border" = ; # Border color of the editor hover.
        # "editorHoverWidget.highlightForeground" = ; # Foreground color of the active item in the parameter hint.
        # "editorHoverWidget.statusBarBackground" = ; # Background color of the editor hover status bar.
        # "editorGhostText.border" = ; # Border color of the ghost text shown by inline completion providers and the suggest preview.
        # "editorGhostText.background" = ; # Background color of the ghost text in the editor.
        # "editorGhostText.foreground" = ; # Foreground color of the ghost text shown by inline completion providers and the suggest preview.
        # "editorStickyScroll.background" = ; # Editor sticky scroll background color.
        # "editorStickyScrollHover.background" = ; # Editor sticky scroll on hover background color.
        # "debugExceptionWidget.background" = ; # Exception widget background color.
        # "debugExceptionWidget.border" = ; # Exception widget border color.
        # "editorMarkerNavigation.background" = ; # Editor marker navigation widget background.
        # "editorMarkerNavigationError.background" = ; # Editor marker navigation widget error color.
        # "editorMarkerNavigationWarning.background" = ; # Editor marker navigation widget warning color.
        # "editorMarkerNavigationInfo.background" = ; # Editor marker navigation widget info color.
        # "editorMarkerNavigationError.headerBackground" = ; # Editor marker navigation widget error heading background.
        # "editorMarkerNavigationWarning.headerBackground" = ; # Editor marker navigation widget warning heading background.
        # "editorMarkerNavigationInfo.headerBackground" = ; # Editor marker navigation widget info heading background.

        # "peekView.border" = ; # Color of the peek view borders and arrow.
        # "peekViewEditor.background" = ; # Background color of the peek view editor.
        # "peekViewEditorGutter.background" = ; # Background color of the gutter in the peek view editor.
        # "peekViewEditor.matchHighlightBackground" = ; # Match highlight color in the peek view editor.
        # "peekViewEditor.matchHighlightBorder" = ; # Match highlight border color in the peek view editor. peekViewEditorStickyScroll.background: Background color of sticky scroll in the peek view editor.
        # "peekViewResult.background" = ; # Background color of the peek view result list.
        # "peekViewResult.fileForeground" = ; # Foreground color for file nodes in the peek view result list.
        # "peekViewResult.lineForeground" = ; # Foreground color for line nodes in the peek view result list.
        # "peekViewResult.matchHighlightBackground" = ; # Match highlight color in the peek view result list.
        # "peekViewResult.selectionBackground" = ; # Background color of the selected entry in the peek view result list.
        # "peekViewResult.selectionForeground" = ; # Foreground color of the selected entry in the peek view result list.
        # "peekViewTitle.background" = ; # Background color of the peek view title area.
        # "peekViewTitleDescription.foreground" = ; # Color of the peek view title info.
        # "peekViewTitleLabel.foreground" = ; # Color of the peek view title.
        # "peekViewEditorStickyScroll.background" = ; # Background color of sticky scroll in the peek view editor.

        # "merge.currentHeaderBackground" = ; # Current header background in inline merge conflicts. The color must not be opaque so as not to hide underlying decorations.
        # "merge.currentContentBackground" = ; # Current content background in inline merge conflicts. The color must not be opaque so as not to hide underlying decorations.
        # "merge.incomingHeaderBackground" = ; # Incoming header background in inline merge conflicts. The color must not be opaque so as not to hide underlying decorations.
        # "merge.incomingContentBackground" = ; # Incoming content background in inline merge conflicts. The color must not be opaque so as not to hide underlying decorations.
        # "merge.border" = ; # Border color on headers and the splitter in inline merge conflicts.
        # "merge.commonContentBackground" = ; # Common ancestor content background in inline merge-conflicts. The color must not be opaque so as not to hide underlying decorations.
        # "merge.commonHeaderBackground" = ; # Common ancestor header background in inline merge-conflicts. The color must not be opaque so as not to hide underlying decorations.
        # "editorOverviewRuler.currentContentForeground" = ; # Current overview ruler foreground for inline merge conflicts.
        # "editorOverviewRuler.incomingContentForeground" = ; # Incoming overview ruler foreground for inline merge conflicts.
        # "editorOverviewRuler.commonContentForeground" = ; # Common ancestor overview ruler foreground for inline merge conflicts.
        # "editorOverviewRuler.commentForeground" = ; # Editor overview ruler decoration color for resolved comments. This color should be opaque.
        # "editorOverviewRuler.commentUnresolvedForeground" = ; # Editor overview ruler decoration color for unresolved comments. This color should be opaque.
        # "mergeEditor.change.background" = ; # The background color for changes.
        # "mergeEditor.change.word.background" = ; # The background color for word changes.
        # "mergeEditor.conflict.unhandledUnfocused.border" = ; # The border color of unhandled unfocused conflicts.
        # "mergeEditor.conflict.unhandledFocused.border" = ; # The border color of unhandled focused conflicts.
        # "mergeEditor.conflict.handledUnfocused.border" = ; # The border color of handled unfocused conflicts.
        # "mergeEditor.conflict.handledFocused.border" = ; # The border color of handled focused conflicts.
        # "mergeEditor.conflict.handled.minimapOverViewRuler" = ; # The foreground color for changes in input 1.
        # "mergeEditor.conflict.unhandled.minimapOverViewRuler" = ; # The foreground color for changes in input 1.
        # "mergeEditor.conflictingLines.background" = ; # The background of the "Conflicting Lines" text.
        # "mergeEditor.changeBase.background" = ; # The background color for changes in base.
        # "mergeEditor.changeBase.word.background" = ; # The background color for word changes in base.
        # "mergeEditor.conflict.input1.background" = ; # The background color of decorations in input 1.
        # "mergeEditor.conflict.input2.background" = ; # The background color of decorations in input 2.

        "panel.background" = hex (builtins.elemAt bg 0); # Panel background color.
        "panel.border" = hex (builtins.elemAt bg 2); # Panel border color to separate the panel from the editor.
        "panel.dropBorder" = hex (builtins.elemAt fg 1); # Drag and drop feedback color for the panel titles. Panels are shown below the editor area and contain views like output and integrated terminal.
        "panelTitle.activeBorder" = hex accent.default; # Border color for the active panel title.
        "panelTitle.activeForeground" = hex (builtins.elemAt fg 0); # Title color for the active panel.
        "panelTitle.inactiveForeground" = hex (builtins.elemAt fg 1); # Title color for the inactive panel.
        "panelInput.border" = hex (builtins.elemAt bg 1); # Input box border for inputs in the panel.
        "panelSection.border" = hex (builtins.elemAt bg 1); # Panel section border color used when multiple views are stacked horizontally in the panel. Panels are shown below the editor area and contain views like output and integrated terminal.
        "panelSection.dropBackground" = hex (builtins.elemAt bg 1); # Drag and drop feedback color for the panel sections. The color should have transparency so that the panel sections can still shine through. Panels are shown below the editor area and contain views like output and integrated terminal.
        "panelSectionHeader.background" = hex (builtins.elemAt bg 0); # Panel section header background color. Panels are shown below the editor area and contain views like output and integrated terminal.
        "panelSectionHeader.foreground" = hex (builtins.elemAt fg 0); # Panel section header foreground color. Panels are shown below the editor area and contain views like output and integrated terminal.
        "panelSectionHeader.border" = hex (builtins.elemAt bg 1); # Panel section header border color used when multiple views are stacked vertically in the panel. Panels are shown below the editor area and contain views like output and integrated terminal.
      
        "statusBar.background" = hex (builtins.elemAt bg 0); # Standard Status Bar background color.
        "statusBar.foreground" = hex (builtins.elemAt fg 0); # Status Bar foreground color.
        "statusBar.border" = "#00000000"; # Status Bar border color separating the Status Bar and editor.
        "statusBar.debuggingBackground" = hex pink.default; # Status Bar background color when a program is being debugged.
        "statusBar.debuggingForeground" = hex (builtins.elemAt bg 0); # Status Bar foreground color when a program is being debugged.
        "statusBar.debuggingBorder" = "#00000000"; # Status Bar border color separating the Status Bar and editor when a program is being debugged.
        "statusBar.noFolderForeground" = hex (builtins.elemAt fg 0); # Status Bar foreground color when no folder is opened.
        "statusBar.noFolderBackground" = hex (builtins.elemAt bg 0); # Status Bar background color when no folder is opened.
        "statusBar.noFolderBorder" = hex (builtins.elemAt bg 1); # Status Bar border color separating the Status Bar and editor when no folder is opened.
        "statusBarItem.activeBackground" = hex (builtins.elemAt bg 2); # Status Bar item background color when clicking.
        "statusBarItem.hoverForeground" = hex (builtins.elemAt fg 0); # Status bar item foreground color when hovering. The status bar is shown in the bottom of the window.
        "statusBarItem.hoverBackground" = hex (builtins.elemAt bg 2); # Status Bar item background color when hovering.
        "statusBarItem.prominentForeground" = hex (builtins.elemAt fg 0); # Status Bar prominent items foreground color.
        "statusBarItem.prominentBackground" = hex (builtins.elemAt bg 0); # Status Bar prominent items background color.
        "statusBarItem.prominentHoverForeground" = hex (builtins.elemAt fg 0); # Status bar prominent items foreground color when hovering. Prominent items stand out from other status bar entries to indicate importance. The status bar is shown in the bottom of the window.
        "statusBarItem.prominentHoverBackground" = hex (builtins.elemAt bg 2); # Status Bar prominent items background color when hovering.
        "statusBarItem.remoteBackground" = hex accent.default; # Background color for the remote indicator on the status bar.
        "statusBarItem.remoteForeground" = hex (builtins.elemAt bg 0); # Foreground color for the remote indicator on the status bar.
        "statusBarItem.remoteHoverBackground" = hex accent.light; # Background color for the remote indicator on the status bar when hovering.
        "statusBarItem.remoteHoverForeground" = hex (builtins.elemAt bg 0); # Foreground color for the remote indicator on the status bar when hovering.
        "statusBarItem.errorBackground" = hex red.default; # Status bar error items background color. Error items stand out from other status bar entries to indicate error conditions.
        "statusBarItem.errorForeground" = hex (builtins.elemAt bg 0); # Status bar error items foreground color. Error items stand out from other status bar entries to indicate error conditions.
        "statusBarItem.errorHoverBackground" = hex red.light; # Status bar error items background color when hovering. Error items stand out from other status bar entries to indicate error conditions. The status bar is shown in the bottom of the window.
        "statusBarItem.errorHoverForeground" = hex (builtins.elemAt bg 0); # Status bar error items foreground color when hovering. Error items stand out from other status bar entries to indicate error conditions. The status bar is shown in the bottom of the window.
        "statusBarItem.warningBackground" = hex yellow.default; # Status bar warning items background color. Warning items stand out from other status bar entries to indicate warning conditions. The status bar is shown in the bottom of the window.
        "statusBarItem.warningForeground" = hex (builtins.elemAt bg 0); # Status bar warning items foreground color. Warning items stand out from other status bar entries to indicate warning conditions. The status bar is shown in the bottom of the window.
        "statusBarItem.warningHoverBackground" = hex yellow.light; # Status bar warning items background color when hovering. Warning items stand out from other status bar entries to indicate warning conditions. The status bar is shown in the bottom of the window.
        "statusBarItem.warningHoverForeground" = hex (builtins.elemAt bg 0); # Status bar warning items foreground color when hovering. Warning items stand out from other status bar entries to indicate warning conditions. The status bar is shown in the bottom of the window.
        "statusBarItem.compactHoverBackground" = hex (builtins.elemAt bg 2); # Status bar item background color when hovering an item that contains two hovers. The status bar is shown in the bottom of the window.
        "statusBarItem.focusBorder" = hex accent.default; # Status bar item border color when focused on keyboard navigation. The status bar is shown in the bottom of the window.
        "statusBar.focusBorder" = hex accent.default; # Status bar border color when focused on keyboard navigation. The status bar is shown in the bottom of the window.
        "statusBarItem.offlineBackground" = hex gray.default; # Status bar item background color when the workbench is offline.
        "statusBarItem.offlineForeground" = hex (builtins.elemAt fg 0); # Status bar item foreground color when the workbench is offline.
        "statusBarItem.offlineHoverForeground" = hex (builtins.elemAt fg 0); # Status bar item foreground hover color when the workbench is offline.
        "statusBarItem.offlineHoverBackground" = hex gray.light; # Status bar item background hover color when the workbench is offline.
      
        # "titleBar.activeBackground" = ; # Title Bar background when the window is active.
        # "titleBar.activeForeground" = ; # Title Bar foreground when the window is active.
        # "titleBar.inactiveBackground" = ; # Title Bar background when the window is inactive.
        # "titleBar.inactiveForeground" = ; # Title Bar foreground when the window is inactive.
        # "titleBar.border" = ; # Title bar border color
        
        # "menubar.selectionForeground" = ; # Foreground color of the selected menu item in the menubar.
        # "menubar.selectionBackground" = ; # Background color of the selected menu item in the menubar.
        # "menubar.selectionBorder" = ; # Border color of the selected menu item in the menubar.
        "menu.foreground" = hex (builtins.elemAt fg 0); # Foreground color of menu items.
        "menu.background" = hex (builtins.elemAt bg 0); # Background color of menu items.
        "menu.selectionForeground" =  hex (builtins.elemAt fg 0); # Foreground color of the selected menu item in menus.
        "menu.selectionBackground" = hex accent.default; # Background color of the selected menu item in menus.
        "menu.selectionBorder" = "#00000000"; # Border color of the selected menu item in menus.
        "menu.separatorBackground" =  hex (builtins.elemAt bg 1); # Color of a separator menu item in menus.
        "menu.border" =  hex (builtins.elemAt bg 1); # Border color of menus.

        "commandCenter.foreground" = hex (builtins.elemAt fg 0); # Foreground color of the Command Center.
        "commandCenter.activeForeground" = hex (builtins.elemAt fg 0); # Active foreground color of the Command Center.
        "commandCenter.background" = hex (builtins.elemAt bg 0); # Background color of the Command Center.
        "commandCenter.activeBackground" = hex accent.default; # Active background color of the Command Center.
        "commandCenter.border" = hex (builtins.elemAt bg 2); # Border color of the Command Center.
        "commandCenter.inactiveForeground" = hex (builtins.elemAt fg 1); # Foreground color of the Command Center when the window is inactive.
        "commandCenter.inactiveBorder" = hex (builtins.elemAt bg 2); # Border color of the Command Center when the window is inactive.
        "commandCenter.activeBorder" = hex (builtins.elemAt bg 2); # Active border color of the Command Center.
        "commandCenter.debuggingBackground" = hex (builtins.elemAt bg 2); # Command Center background color when a program is being debugged
              
        "notificationCenter.border" = hex (builtins.elemAt bg 2); # Notification Center border color.
        "notificationCenterHeader.foreground" = hex (builtins.elemAt fg 0); # Notification Center header foreground color.
        "notificationCenterHeader.background" = hex (builtins.elemAt bg 0); # Notification Center header background color.
        "notificationToast.border" = hex (builtins.elemAt bg 2); # Notification toast border color.
        "notifications.foreground" = hex (builtins.elemAt fg 0); # Notification foreground color.
        "notifications.background" = hex (builtins.elemAt bg 0); # Notification background color.
        "notifications.border" = hex (builtins.elemAt bg 2); # Notification border color separating from other notifications in the Notification Center.
        "notificationLink.foreground" = hex accent.default; # Notification links foreground color.
        "notificationsErrorIcon.foreground" = hex red.default; # The color used for the notification error icon.
        "notificationsWarningIcon.foreground" = hex yellow.default;# The color used for the notification warning icon.
        "notificationsInfoIcon.foreground" = hex blue.default; # The color used for the notification info icon.

        "terminal.background" = hex (builtins.elemAt bg 0); # The background of the Integrated Terminal's viewport.
        "terminal.border" = hex (builtins.elemAt bg 2); # The color of the border that separates split panes within the terminal. This defaults to panel.border.
        "terminal.foreground" = hex (builtins.elemAt fg 0); # The default foreground color of the Integrated Terminal.
        "terminal.ansiBlack" = hex black.default; # 'Black' ANSI color in the terminal.
        "terminal.ansiBlue" = hex blue.default; # 'Blue' ANSI color in the terminal.
        "terminal.ansiBrightBlack" = hex black.light; # 'BrightBlack' ANSI color in the terminal.
        "terminal.ansiBrightBlue" = hex blue.light; # 'BrightBlue' ANSI color in the terminal.
        "terminal.ansiBrightCyan" = hex cyan.light; # 'BrightCyan' ANSI color in the terminal.
        "terminal.ansiBrightGreen" = hex green.light; # 'BrightGreen' ANSI color in the terminal.
        "terminal.ansiBrightMagenta" = hex pink.light; # 'BrightMagenta' ANSI color in the terminal.
        "terminal.ansiBrightRed" = hex red.light; # 'BrightRed' ANSI color in the terminal.
        "terminal.ansiBrightWhite" = hex white.light; # 'BrightWhite' ANSI color in the terminal.
        "terminal.ansiBrightYellow" = hex yellow.light; # 'BrightYellow' ANSI color in the terminal.
        "terminal.ansiCyan" = hex cyan.default; # 'Cyan' ANSI color in the terminal.
        "terminal.ansiGreen" = hex green.default; # 'Green' ANSI color in the terminal.
        "terminal.ansiMagenta" = hex pink.default; # 'Magenta' ANSI color in the terminal.
        "terminal.ansiRed" = hex red.default; # 'Red' ANSI color in the terminal.
        "terminal.ansiWhite" = hex white.default; # 'White' ANSI color in the terminal.
        "terminal.ansiYellow" = hex yellow.default; # 'Yellow' ANSI color in the terminal.
        "terminal.selectionBackground" = hex accent.default; # The selection background color of the terminal.
        # "terminal.selectionForeground" = ; # The selection foreground color of the terminal. When this is null the selection foreground will be retained and have the minimum contrast ratio feature applied.
        "terminal.inactiveSelectionBackground" = hexA (builtins.elemAt bg 2) highlightAlpha; # The selection background color of the terminal when it does not have focus.
        "terminal.findMatchBackground" = hexA accent.default highlightAlpha; # Color of the current search match in the terminal. The color must not be opaque so as not to hide underlying terminal content.
        "terminal.findMatchBorder" = "#00000000"; # Border color of the current search match in the terminal.
        "terminal.findMatchHighlightBackground" = hexA (builtins.elemAt bg 2) highlightAlpha; # Color of the other search matches in the terminal. The color must not be opaque so as not to hide underlying terminal content.
        "terminal.findMatchHighlightBorder" = "#00000000"; # Border color of the other search matches in the terminal.
        "terminal.hoverHighlightBackground" = hexA (builtins.elemAt bg 2) highlightAlpha; # Color of the highlight when hovering a link in the terminal.
        # "terminalCursor.background" = ; # The background color of the terminal cursor. Allows customizing the color of a character overlapped by a block cursor.
        "terminalCursor.foreground" = hex (builtins.elemAt fg 0); # The foreground color of the terminal cursor.
        # "terminal.dropBackground" = ; # The background color when dragging on top of terminals. The color should have transparency so that the terminal contents can still shine through.
        "terminal.tab.activeBorder" = hex accent.default; # Border on the side of the terminal tab in the panel. This defaults to tab.activeBorder.
        "terminalCommandDecoration.defaultBackground" = hex gray.default; # The default terminal command decoration background color.
        "terminalCommandDecoration.successBackground" = hex green.default; # The terminal command decoration background color for successful commands.
        "terminalCommandDecoration.errorBackground" = hex red.default; # The terminal command decoration background color for error commands.
        # "terminalOverviewRuler.cursorForeground" = ; # The overview ruler cursor color.
        # "terminalOverviewRuler.findMatchForeground" = ; # Overview ruler marker color for find matches in the terminal.

        # "debugToolBar.background" = ; # Debug toolbar background color.
        # "debugToolBar.border" = ; # Debug toolbar border color.
        # "editor.stackFrameHighlightBackground" = ; # Background color of the top stack frame highlight in the editor.
        # "editor.focusedStackFrameHighlightBackground" = ; # Background color of the focused stack frame highlight in the editor.
        # "editor.inlineValuesForeground" = ; # Color for the debug inline value text.
        # "editor.inlineValuesBackground" = ; # Color for the debug inline value background.
        # "debugView.exceptionLabelForeground" = ; # Foreground color for a label shown in the CALL STACK view when the debugger breaks on an exception.
        # "debugView.exceptionLabelBackground" = ; # Background color for a label shown in the CALL STACK view when the debugger breaks on an exception.
        # "debugView.stateLabelForeground" = ; # Foreground color for a label in the CALL STACK view showing the current session's or thread's state.
        # "debugView.stateLabelBackground" = ; # Background color for a label in the CALL STACK view showing the current session's or thread's state.
        # "debugView.valueChangedHighlight" = ; # Color used to highlight value changes in the debug views (such as in the Variables view).
        # "debugTokenExpression.name" = ; # Foreground color for the token names shown in debug views (such as in the Variables or Watch view).
        # "debugTokenExpression.value" = ; # Foreground color for the token values shown in debug views.
        # "debugTokenExpression.string" = ; # Foreground color for strings in debug views.
        # "debugTokenExpression.boolean" = ; # Foreground color for booleans in debug views.
        # "debugTokenExpression.number" = ; # Foreground color for numbers in debug views.
        # "debugTokenExpression.error" = ; # Foreground color for expression errors in debug views.
      
        # "testing.iconFailed" = ; # Color for the 'failed' icon in the test explorer.
        # "testing.iconErrored" = ; # Color for the 'Errored' icon in the test explorer.
        # "testing.iconPassed" = ; # Color for the 'passed' icon in the test explorer.
        # "testing.runAction" = ; # Color for 'run' icons in the editor.
        # "testing.iconQueued" = ; # Color for the 'Queued' icon in the test explorer.
        # "testing.iconUnset" = ; # Color for the 'Unset' icon in the test explorer.
        # "testing.iconSkipped" = ; # Color for the 'Skipped' icon in the test explorer.
        # "testing.peekBorder" = ; # Color of the peek view borders and arrow.
        # "testing.peekHeaderBackground" = ; # Color of the peek view borders and arrow.
        # "testing.message.error.decorationForeground" = ; # Text color of test error messages shown inline in the editor.
        # "testing.message.error.lineBackground" = ; # Margin color beside error messages shown inline in the editor.
        # "testing.message.info.decorationForeground" = ; # Text color of test info messages shown inline in the editor.
        # "testing.message.info.lineBackground" = ; # Margin color beside info messages shown inline in the editor.
      
        # "welcomePage.background" = ; # Background color for the Welcome page.
        # "welcomePage.progress.background" = ; # Foreground color for the Welcome page progress bars.
        # "welcomePage.progress.foreground" = ; # Background color for the Welcome page progress bars.
        # "welcomePage.tileBackground" = ; # Background color for the tiles on the Welcome page.
        # "welcomePage.tileHoverBackground" = ; # Hover background color for the tiles on the Welcome page.
        # "welcomePage.tileBorder" = ; # Border color for the tiles on the Welcome page.
        # "walkThrough.embeddedEditorBackground" = ; # Background color for the embedded editors on the Interactive Playground.
        # "walkthrough.stepTitle.foreground" = ; # Foreground color of the heading of each walkthrough step.

        "gitDecoration.addedResourceForeground" = hex green.light; # Color for added Git resources. Used for file labels and the SCM viewlet.
        "gitDecoration.modifiedResourceForeground" = hex blue.default; # Color for modified Git resources. Used for file labels and the SCM viewlet.
        "gitDecoration.deletedResourceForeground" = hex red.default; # Color for deleted Git resources. Used for file labels and the SCM viewlet.
        "gitDecoration.renamedResourceForeground" = hex cyan.default; # Color for renamed or copied Git resources. Used for file labels and the SCM viewlet.
        "gitDecoration.stageModifiedResourceForeground" = hex blue.light; # Color for staged modifications git decorations. Used for file labels and the SCM viewlet.
        "gitDecoration.stageDeletedResourceForeground" = hex red.light; # Color for staged deletions git decorations. Used for file labels and the SCM viewlet.
        "gitDecoration.untrackedResourceForeground" = hex green.default; # Color for untracked Git resources. Used for file labels and the SCM viewlet.
        "gitDecoration.ignoredResourceForeground" = hex gray.default; # Color for ignored Git resources. Used for file labels and the SCM viewlet.
        "gitDecoration.conflictingResourceForeground" = hex red.default; # Color for conflicting Git resources. Used for file labels and the SCM viewlet.
        "gitDecoration.submoduleResourceForeground" = hex (builtins.elemAt fg 0); # Color for submodule resources

        # "settings.headerForeground" = ; # The foreground color for a section header or active title.
        # "settings.modifiedItemIndicator" = ; # The line that indicates a modified setting.
        # "settings.dropdownBackground" = ; # Dropdown background.
        # "settings.dropdownForeground" = ; # Dropdown foreground.
        # "settings.dropdownBorder" = ; # Dropdown border.
        # "settings.dropdownListBorder" = ; # Dropdown list border.
        # "settings.checkboxBackground" = ; # Checkbox background.
        # "settings.checkboxForeground" = ; # Checkbox foreground.
        # "settings.checkboxBorder" = ; # Checkbox border.
        # "settings.rowHoverBackground" = ; # The background color of a settings row when hovered.
        # "settings.textInputBackground" = ; # Text input box background.
        # "settings.textInputForeground" = ; # Text input box foreground.
        # "settings.textInputBorder" = ; # Text input box border.
        # "settings.numberInputBackground" = ; # Number input box background.
        # "settings.numberInputForeground" = ; # Number input box foreground.
        # "settings.numberInputBorder" = ; # Number input box border.
        # "settings.focusedRowBackground" = ; # Background color of a focused setting row.
        # "settings.focusedRowBorder" = ; # The color of the row's top and bottom border when the row is focused.
        # "settings.headerBorder" = ; # The color of the header container border.
        # "settings.sashBorder" = ; # The color of the Settings editor splitview sash border.
        # "settings.settingsHeaderHoverForeground" = ; # The foreground color for a section header or hovered title.
  
        "breadcrumb.foreground" = hex (builtins.elemAt fg 1); # Color of breadcrumb items.
        "breadcrumb.background" = hex (builtins.elemAt bg 0); # Background color of breadcrumb items.
        "breadcrumb.focusForeground" = hex (builtins.elemAt fg 0); # Color of focused breadcrumb items.
        "breadcrumb.activeSelectionForeground" = hex (builtins.elemAt fg 0); # Color of selected breadcrumb items.
        "breadcrumbPicker.background" = hex (builtins.elemAt bg 0); # Background color of breadcrumb item picker

        # "editor.snippetTabstopHighlightBackground" = ; # Highlight background color of a snippet tabstop.
        # "editor.snippetTabstopHighlightBorder" = ; # Highlight border color of a snippet tabstop.
        # "editor.snippetFinalTabstopHighlightBackground" = ; # Highlight background color of the final tabstop of a snippet.
        # "editor.snippetFinalTabstopHighlightBorder" = ; # Highlight border color of the final tabstop of a snippet.

        # "symbolIcon.arrayForeground" = ; # The foreground color for array symbols.
        # "symbolIcon.booleanForeground" = ; # The foreground color for boolean symbols.
        # "symbolIcon.classForeground" = ; # The foreground color for class symbols.
        # "symbolIcon.colorForeground" = ; # The foreground color for color symbols.
        # "symbolIcon.constantForeground" = ; # The foreground color for constant symbols.
        # "symbolIcon.constructorForeground" = ; # The foreground color for constructor symbols.
        # "symbolIcon.enumeratorForeground" = ; # The foreground color for enumerator symbols.
        # "symbolIcon.enumeratorMemberForeground" = ; # The foreground color for enumerator member symbols.
        # "symbolIcon.eventForeground" = ; # The foreground color for event symbols.
        # "symbolIcon.fieldForeground" = ; # The foreground color for field symbols.
        # "symbolIcon.fileForeground" = ; # The foreground color for file symbols.
        # "symbolIcon.folderForeground" = ; # The foreground color for folder symbols.
        # "symbolIcon.functionForeground" = ; # The foreground color for function symbols.
        # "symbolIcon.interfaceForeground" = ; # The foreground color for interface symbols.
        # "symbolIcon.keyForeground" = ; # The foreground color for key symbols.
        # "symbolIcon.keywordForeground" = ; # The foreground color for keyword symbols.
        # "symbolIcon.methodForeground" = ; # The foreground color for method symbols.
        # "symbolIcon.moduleForeground" = ; # The foreground color for module symbols.
        # "symbolIcon.namespaceForeground" = ; # The foreground color for namespace symbols.
        # "symbolIcon.nullForeground" = ; # The foreground color for null symbols.
        # "symbolIcon.numberForeground" = ; # The foreground color for number symbols.
        # "symbolIcon.objectForeground" = ; # The foreground color for object symbols.
        # "symbolIcon.operatorForeground" = ; # The foreground color for operator symbols.
        # "symbolIcon.packageForeground" = ; # The foreground color for package symbols.
        # "symbolIcon.propertyForeground" = ; # The foreground color for property symbols.
        # "symbolIcon.referenceForeground" = ; # The foreground color for reference symbols.
        # "symbolIcon.snippetForeground" = ; # The foreground color for snippet symbols.
        # "symbolIcon.stringForeground" = ; # The foreground color for string symbols.
        # "symbolIcon.structForeground" = ; # The foreground color for struct symbols.
        # "symbolIcon.textForeground" = ; # The foreground color for text symbols.
        # "symbolIcon.typeParameterForeground" = ; # The foreground color for type parameter symbols.
        # "symbolIcon.unitForeground" = ; # The foreground color for unit symbols.
        # "symbolIcon.variableForeground" = ; # The foreground color for variable symbols.

        # "debugIcon.breakpointForeground" = ; # Icon color for breakpoints.
        # "debugIcon.breakpointDisabledForeground" = ; # Icon color for disabled breakpoints.
        # "debugIcon.breakpointUnverifiedForeground" = ; # Icon color for unverified breakpoints.
        # "debugIcon.breakpointCurrentStackframeForeground" = ; # Icon color for the current breakpoint stack frame.
        # "debugIcon.breakpointStackframeForeground" = ; # Icon color for all breakpoint stack frames.
        # "debugIcon.startForeground" = ; # Debug toolbar icon for start debugging.
        # "debugIcon.pauseForeground" = ; # Debug toolbar icon for pause.
        # "debugIcon.stopForeground" = ; # Debug toolbar icon for stop.
        # "debugIcon.disconnectForeground" = ; # Debug toolbar icon for disconnect.
        # "debugIcon.restartForeground" = ; # Debug toolbar icon for restart.
        # "debugIcon.stepOverForeground" = ; # Debug toolbar icon for step over.
        # "debugIcon.stepIntoForeground" = ; # Debug toolbar icon for step into.
        # "debugIcon.stepOutForeground" = ; # Debug toolbar icon for step over.
        # "debugIcon.continueForeground" = ; # Debug toolbar icon for continue.
        # "debugIcon.stepBackForeground" = ; # Debug toolbar icon for step back.
        # "debugConsole.infoForeground" = ; # Foreground color for info messages in debug REPL console.
        # "debugConsole.warningForeground" = ; # Foreground color for warning messages in debug REPL console.
        # "debugConsole.errorForeground" = ; # Foreground color for error messages in debug REPL console.
        # "debugConsole.sourceForeground" = ; # Foreground color for source filenames in debug REPL console.
        # "debugConsoleInputIcon.foreground" = ; # Foreground color for debug console input marker icon.

        "charts.foreground" = hex (builtins.elemAt fg 0); # Contrast color for text in charts.
        "charts.lines" = hex (builtins.elemAt fg 0); # Color for lines in charts.
        "charts.red" = hex red.default; # Color for red elements in charts.
        "charts.blue" = hex blue.default; # Color for blue elements in charts.
        "charts.yellow" = hex yellow.default; # Color for yellow elements in charts.
        "charts.orange" = hex orange.default; # Color for orange elements in charts.
        "charts.green" = hex green.default; # Color for green elements in charts.
        "charts.purple" = hex purple.default; # Color for purple elements in charts
      };
    };
  };
}