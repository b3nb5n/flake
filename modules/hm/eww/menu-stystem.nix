{ ... }: {
  xdg.configFile = {
    ewwYuck.text = /* yuck */ ''
      	(defwindow menu-system 
      	  :monitor 0
      	  :stacking "fg"
      	  :exclusive false
      	  :geometry (geometry
      		:anchor "top left"
      		:x "12px"
      		:y "12px"
      		:height "512px"
      		:width "360px"
      	  )

      	  (menu-system)
      	)

        (defpoll uptime
      	  :interval "30s"
      	  :initial "0s"
      	  "${./scripts/getter/uptime.sh}"
        )

      	(defwidget menu-system []
      	  (eventbox
      		:class "menu"
      		:onhoverlost "''${EWW_CMD} close menu-system"

      		(box
      		  :orientation "v"
      		  :space-evenly false

      		  (label :text "ben@bnixdsk")
      		  (label :text uptime)
      		  (menu-system-graph
      			:value {EWW_RAM.used_mem}
      			:max {EWW_RAM.total_mem}
      		  )

      		  (menu-system-actions)
      		)
      	  )
      	)

      	(defwidget menu-system-graph [value ?max ?time]
      	  (graph
      		:class "menu-graph"
      		:time-range {time ?: "30s"}
      		:thickness 4
      		:value value
      		:max max
      		:dynamic {"''${max}" == ""}
      	  )
      	)

      	(defwidget menu-system-action [name action]
      	  (button
      		:class "menu-system-action"
      		:onclick action

      		(box
      		  :orientation "v"
      		  :spacing 4

      		  (image
      			:path "''${EWW_CONFIG_DIR}/icons/action/''${name}.svg"
      			:image-width 24
      			:image-height 24
      		  )

      		  (label
      			:text name
      		  )
      		)
      	  )
      	)

      	(defwidget menu-system-actions []
      	  (box
      		:spacing 6

      		(menu-system-action
      		  :name "lock"
      		  :action "hyprlock"
      		)
      		(menu-system-action
      		  :name "reboot"
      		  :action "systemctl reboot"
      		)
      		(menu-system-action
      		  :name "shutdown"
      		  :action "systemctl poweroff"
      		)
      	  )
      	)
    '';
    ewwScss.text = /* scss */ ''
      .menu {
        background: rgba(31, 35, 53, 0.8);
        border-radius: 8px;
        padding: 8px;
      }

      .menu-system-action {
        background: $interactive;
        border-radius: 6px;
        padding-top: 12px;
        padding-bottom: 8px;
      }

      .menu-system-action:hover {
        background: $hover;
      }
    '';
  };
}
