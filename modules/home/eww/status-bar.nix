{ pkgs, ... }: {
  xdg.configFile = {
    ewwYuck.text = /* yuck */ ''
      	  (defwindow status-bar
      		:monitor 0
      		:stacking "fg"
      		:exclusive true
      		:focusable false
      		:geometry (geometry
      		  :anchor "center left"
      		  :x "0px"
      		  :height "133%" ;; todo: change to 100 https://github.com/elkowar/eww/issues/1110
      		  :width "24px"
      		)

      		(status-bar
      		  :orientation "v"
      		)
      	  )

      	  (defwidget status-bar [orientation]
      		(centerbox
      		  :class "status-bar ''${orientation}"
      		  :orientation orientation

      		  (status-layout
      			:orientation orientation
      			:side "start"

      			(status-system :orientation orientation)
      			(status-workspaces :orientation orientation)
      			(status-tmp-workspaces :orientation orientation)
      		  )

      		  (status-clock
      			:orientation orientation
      		  )

      		  (status-layout
      			:orientation orientation
      			:side "end"

      			(status-audio :orientation orientation)
      			(status-wireless :orientation orientation)
      		  )
      		)
      	  )

      	  (defwidget status-layout [orientation side]
      		(box
      		  :class "status-layout ''${side} ''${orientation}"
      		  :orientation orientation
      		  :valign {orientation == "v" ? side : "center"}
      		  :halign {orientation == "h" ? side : "center"}
      		  :space-evenly false
      		  :spacing 12

      		  (children)
      		)
      	  )

      	  (defwidget status-system [orientation]
      		(button
      		  :class "status-group"
      		  :width 42 
      		  :height 42
      		  :onclick "''${EWW_CMD} open menu-system"

      		  (image 
      			:path "''${EWW_CONFIG_DIR}/icons/status/system-active.svg"
      			:image-width 24
      			:image-height 24
      		  )
      		)
      	  )

      	  (defvar status-el-gap 6)
      	  (defwidget status-group [orientation]
      		(box
      		  :class "status-group ''${orientation}"
      		  :orientation orientation
      		  :space-evenly false
      		  :spacing status-el-gap

      		  (children)
      		)
      	  )

      	  (defvar status-el-size 18)
      	  (defwidget status-icon [name type ?visible]
      		(image
      		  :path "''${EWW_CONFIG_DIR}/icons/''${type}/''${name}.svg"
      		  :image-width status-el-size
      		  :image-height status-el-size
      		  :visible {visible == false ? false : true}
      		)
      	  )

          (deflisten listener-workspaces
            :initial "[]"
            "${pkgs.hyprland-workspaces}/bin/hyprland-workspaces ALL"
          )

      	  (defwidget status-workspaces [orientation]
      		(status-group
      		  :orientation orientation

      		  (box
      			:orientation orientation
      			:spacing status-el-gap

      			(for workspace in {jq(
      			  listener-workspaces,
      			  'map(select(.name | test("^[a-z]+$"))) | sort_by(.id)'
      			)}
      			  (status-workspace
      				:name {workspace.name}
      				:active {workspace.active}
      				:tmp false
      			  )
      			)
      		  )
      		)
      	  )

      	  (defwidget status-tmp-workspaces [orientation]
      		(status-group
      		  :orientation orientation

      		  (box
      			:orientation orientation
      			:spacing status-el-gap
      			:visible {jq(
      			  listener-workspaces,
      			  'first(.[] | select(.name | test("^[0-9]$"))) != null == "true"'
      			)}

      			(for workspace in {jq(
      			  listener-workspaces,
      			  'map(select(.name | test("^[0-9]$")))'
      			)}
      			  (status-workspace
      				:name {workspace.name}
      				:active {workspace.active}
      				:tmp true
      			  )
      			)
      		  )

      		  (button
      			:class "status-el"
      			:onclick "${./scripts/action/create-workspace.sh}" 

      			(status-icon
      			  :type "action"
      			  :name "create-workspace"
      			)
      		  )
      		)
      	  )

      	  (defwidget status-workspace [name active tmp]
      		(button
      		  :class "status-el''${active ? " focused": ""}"
      		  :onclick "${pkgs.hyprland}/bin/hyprctl dispatch workspace name:''${name}"

      		  (box
      			(status-icon
      			  :visible {!tmp}
      			  :type "workspace"
      			  :name "''${name}-''${active ? "active": "inactive"}"
      			)
      			(label
      			  :visible tmp
      			  :text name
      			)
      		  )
      		)
      	  )

      	  (defwidget status-clock [orientation]
      		(box
      		  :class "status-group status-clock ''${orientation}"
      		  :orientation orientation

      		  (label :text "''${formattime(EWW_TIME, "%I")}")
      		  (label :text {orientation == "v" ? "· ·" : ":"})
      		  (label :text "''${formattime(EWW_TIME, "%M")}")
      		)
      	  )

      	  (defwidget status-audio [orientation]
      		(status-group
      		  :orientation orientation

      		  (status-mic)
      		  (status-volume)
      		  (status-playing)
      		)
      	  )

      	  (defwidget status-mic []
      		(box
      		  :class "status-el"

      		  (status-icon
      			:type "status"
      			:name "mic-on-inactive"
      		  )
      		)
      	  )

      	  (defwidget status-volume []
      		(box
      		  :class "status-el"

      		  (status-icon
      			:type "status"
      			:name "volume-2-inactive"
      		  )
      		)
      	  )

      	  (defwidget status-playing []
      		(box
      		  :class "status-el"

      		  (status-icon
      			:type "status"
      			:name "volume-2-inactive"
      		  )
      		)
      	  )

      	  (defwidget status-wireless [orientation]
      		(status-group
      		  :orientation orientation

      		  (status-wifi)
      		  (status-bluetooth)
      		)
      	  )

          (deflisten listener-wifi
            :initial "{\"powered\":false,\"connected\":false}"
            "${./scripts/listener/wifi.sh}"
          )

      	  (defwidget status-wifi []
      		(box
      		  :class "status-el"

      		  (status-icon
      			:type "status"
      			:name "wifi-2-inactive"
      			:visible {listener-wifi.powered && listener-wifi.connected}
      		  )

      		  (status-icon
      			:type "status"
      			:name "wifi-off-inactive"
      			:visible {!listener-wifi.powered}
      		  )
      		)
      	  )

          (deflisten listener-bluetooth
            :initial "{\"powered\":false,\"connected\":false}"
            "${./scripts/listener/bluetooth.sh}" 
          )

      	  (defwidget status-bluetooth []
      		(box
      		  :class "status-el"

      		  (status-icon
      			:type "status"
      			:name "bluetooth-on-inactive" 
      			:visible {listener-bluetooth.powered}
      		  )

      		  (status-icon
      			:type "status"
      			:name "bluetooth-off-inactve" 
      			:visible {!listener-bluetooth.powered}
      		  )
      		)
      	  )
    '';
    ewwScss.text = /* scss */ ''
      .status-bar {
        padding: 8px;
        padding-right: 0;
        font-size: 14px;
        font-weight: bold;
        color: $fg;
      }

      .status-system {
        background: $bg;
        border-radius: 100px;
        /* padding: 10px 6px; */
      }

      .status-group {
        background: $bg;
        border-radius: 100px;
        padding: 4px;
      }

      .status-el {
        background: $interactive;
        border-radius: 100px;
        padding: 8px;
      }

      .status-el:hover {
        background: $hover;
      }

      .status-el.focused {
        background: $active;
        color: $bg;
      }

      .status-clock {
        background: $bg;
        border-radius: 100px;
        padding: 16px 0;
      }
    '';
  };
}
