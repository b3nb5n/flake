# https://vt100.net/docs/vt510-rm/DECSCUSR

function _vi-mode-set-cursor-shape-for-keymap() {
  local cursor_steady_block=2
  local cursor_blink_beam=5
  local _shape=$cursor_steady_block

  case "${1:-main}" in
    main)    _shape=$cursor_blink_beam ;;
    viins)   _shape=$cursor_blink_beam ;;
    isearch) _shape=$cursor_blink_beam ;;
    command) _shape=$cursor_blink_beam ;;
    vicmd)   _shape=$cursor_steady_block ;;
    visual)  _shape=$cursor_steady_block ;;
    viopp)   _shape=$cursor_steady_block ;;
    *)       _shape=$cursor_steady_block ;;
  esac

  printf $'\e[%d q' "${_shape}"
}

function _visual-mode {
  _vi-mode-set-cursor-shape-for-keymap "visual"
  zle .visual-mode
}

function zle-keymap-select() {
  zle reset-prompt
  zle -R
  
  _vi-mode-set-cursor-shape-for-keymap "$KEYMAP"
}

function zle-line-init() {
  zle reset-prompt
  zle -R
 
  _vi-mode-set-cursor-shape-for-keymap "main"
}

function zle-line-finish() {
  _vi-mode-set-cursor-shape-for-keymap "default"
}

zle -N visual-mode _visual-mode
zle -N zle-keymap-select
zle -N zle-line-init
zle -N zle-line-finish

bindkey -v
export KEYTIMEOUT=1

# allow deleteting past start in append mode
bindkey -M viins "^?" backward-delete-char 
