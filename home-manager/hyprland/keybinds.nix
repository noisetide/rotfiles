{
  config,
  lib,
  pkgs,
  ...
}:
let
  pamixer = lib.getExe pkgs.pamixer;
in
{
  wayland.windowManager.hyprland.settings = lib.mkIf config.wayland.windowManager.hyprland.enable {
    bindn =
      [
        #GLOBAL
        # ", code:70, pass, class:^(librewolf)$"
        # ", code:70, pass, class:^(discord)$"
        ", code:70, pass, class:^(vesktop)$"
        ", code:115, pass, class:^(vesktop)$"
        ", code:70, exec, notify-send hello"
    ];
    bind =
      [
        ", mouse:275, pass, class:^(librewolf)$"

        # Exec
        "SUPER, Return, exec, ${lib.getExe pkgs.kitty}"
        "SUPER_SHIFT, Return, exec, rofi -show drun"
        # Kill
        "SUPER, BackSpace, killactive,"
        "SUPER_CTRL, BackSpace, exec, hyprctl kill"
        # File
        "SUPER, b, exec, nemo ~/Downloads"

        # exit hyprland
        "SUPER_CTRL, 5, exit,"

        ''SUPER_CTRL, Return, exec, rofi -show power-menu -font "${config.custom.fonts.monospace} 14" -modi power-menu:rofi-power-menu''
        "SUPER_CTRL, v, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

        # reset monitors
        "CTRL_SHIFT, Escape, exec, hypr-monitors"

        # reset input language
        # "SUPER_SHIFT, z, exec, fcitx5-remote -s keyboard-jp"

        # lighting
        "SUPER_CTRL, a, exec, hyprshade on blue-light-filter"
        "SUPER_CTRL, s, exec, hyprshade off"
        "SUPER_CTRL, d, exec, hyprshade on blue-light-filter2"

        "SUPER, Escape, killactive"

        "SUPER, h, movefocus, l"
        "SUPER, l, movefocus, r"
        "SUPER, k, movefocus, u"
        "SUPER, j, movefocus, d"

        "SUPER_SHIFT, h, movewindow, l"
        "SUPER_SHIFT, l, movewindow, r"
        "SUPER_SHIFT, k, movewindow, u"
        "SUPER_SHIFT, j, movewindow, d"

        # Switch workspaces with SUPER
        # +
        # 1234 -> 1|2|3|4
        # qwe  -> 5|6|7
        # asd  -> 8|9|10
        "SUPER, 1, workspace, 1" # 1
        "SUPER, 2, workspace, 2" # 2
        "SUPER, 3, workspace, 3" # 3
        "SUPER, 4, workspace, 4" # 4

        "SUPER, 5, workspace, 5" # 5
        "SUPER, q, workspace, 5" # q for 5

        "SUPER, 6, workspace, 6" # 6
        "SUPER, w, workspace, 6" # w for 6

        "SUPER, 7, workspace, 7" # 7
        "SUPER, e, workspace, 7" # e for 7

        "SUPER, 8, workspace, 8" # 8
        "SUPER, a, workspace, 8" # a for 8

        "SUPER, 9, workspace, 9" # 9
        "SUPER, s, workspace, 9" # s for 9

        "SUPER, 0, workspace, 10" # 10
        "SUPER, d, workspace, 10" # d for 10

        # "SUPER, -, workspace, 11" # -
        # "SUPER, z, workspace, 11" # z for 11

        "SUPER, x, workspace, 12" # x for 12

        "SUPER, c, workspace, 13" # x for 12

        # Move active window to a workspace with SUPER + SHIFT
        # +
        # 1234 -> 1|2|3|4
        # qwe  -> 5|6|7
        # asd  -> 8|9|10
        "SUPER_SHIFT, 1, movetoworkspacesilent, 1" # 1
        "SUPER_SHIFT, 2, movetoworkspacesilent, 2" # 2
        "SUPER_SHIFT, 3, movetoworkspacesilent, 3" # 3
        "SUPER_SHIFT, 4, movetoworkspacesilent, 4" # 4

        "SUPER_SHIFT, 5, movetoworkspacesilent, 5" # 5
        "SUPER_SHIFT, q, movetoworkspacesilent, 5" # q for 5

        "SUPER_SHIFT, 6, movetoworkspacesilent, 6" # 6
        "SUPER_SHIFT, w, movetoworkspacesilent, 6" # w for 6

        "SUPER_SHIFT, 7, movetoworkspacesilent, 7" # 7
        "SUPER_SHIFT, e, movetoworkspacesilent, 7" # e for 7

        "SUPER_SHIFT, 8, movetoworkspacesilent, 8" # 8
        "SUPER_SHIFT, a, movetoworkspacesilent, 8" # a for 8

        "SUPER_SHIFT, 9, movetoworkspacesilent, 9" # 9
        "SUPER_SHIFT, s, movetoworkspacesilent, 9" # s for 9

        "SUPER_SHIFT, 0, movetoworkspacesilent, 10" # 10
        "SUPER_SHIFT, d, movetoworkspacesilent, 10" # d for 10

        # "SUPER_SHIFT, -, movetoworkspacesilent, 11" # 11
        # "SUPER_SHIFT, z, movetoworkspacesilent, 11" # z for 11

        "SUPER_SHIFT, x, movetoworkspacesilent, 12" # x for 12

        "SUPER_SHIFT, c, movetoworkspacesilent, 13" # c for 13

        # "SUPER_SHIFT, b, layoutmsg, swapwithmaster"

        # focus the previous / next desktop in the current monitor (DE style)
        "SUPER_SHIFT_CTRL, h, workspace, m-1"
        "SUPER_SHIFT_CTRL, l, workspace, m+1"

        # monocle mode
        "SUPER, n, fullscreen, 1"

        # fullscreen
        "SUPER, f, fullscreen, 0"
        # "SUPER_SHIFT_CTRL, f, fakefullscreen"
        "SUPER_SHIFT, f, fullscreenstate, -1 2"


        # floating
        "SUPER, g, togglefloating"

        # sticky
        "SUPER_CTRL, s, pin"

        # focus next / previous monitor
        "SUPER_CTRL, l, focusmonitor, DP-3"
        "SUPER_CTRL, h, focusmonitor, DP-2"
        "SUPER_CTRL, k, movewindow, DP-2"
        "SUPER_CTRL, j, movewindow, DP-3"

        # resize windows
        "SUPER, Left, resizeactive, -50 0"
        "SUPER, Right, resizeactive, 0 50"
        "SUPER, Up, resizeactive, 0 -50"
        "SUPER, Down, resizeactive, 50 0"

        # # move to next / previous monitor
        # "SUPER_SHIFT, Left, movewindow, ${
        #   if lib.length displays < 3
        #   then "mon:-1"
        #   else "mon:l"
        # }"
        # "SUPER_SHIFT, Right, movewindow, ${
        #   if lib.length displays < 3
        #   then "mon:+1"
        #   else "mon:r"
        # }"
        # "SUPER_SHIFT, Up, movewindow, ${
        #   if lib.length displays < 3
        #   then "mon:-1"
        #   else "mon:u"
        # }"
        # "SUPER_SHIFT, Down, movewindow, ${
        #   if lib.length displays < 3
        #   then "mon:+1"
        #   else "mon:d"
        # }"

        "ALT, Tab, cyclenext"
        "ALT_SHIFT, Tab, cyclenext, prev"

        # switches to the next / previous window of the same class
        # hardcoded to SUPER so it doesn't clash on VM
        # "SUPER, Tab, exec, hypr-same-class next"
        # "SUPER_SHIFT, Tab, exec, hypr-same-class prev"

        # picture in picture mode
        "SUPER, p, exec, hypr-pip"

        # add / remove master windows
        "SUPER, m, layoutmsg, addmaster"
        "SUPER_SHIFT, m, layoutmsg, removemaster"

        # rotate via switching master orientation
        "SUPER, r, layoutmsg, orientationcycle left top"

        # reload config
        "SUPER_CTRL, r, exec, hyprctl reload"

        # Scroll through existing workspaces with SUPER + scroll
        "SUPER, mouse_down, workspace, e-1"
        "SUPER, mouse_up, workspace, e+1"

        # dunst controls
        "SUPER, grave, exec, dunstctl history-pop"

        # switching wallpapers or themes
        "SUPER, apostrophe, exec, imv-wallpaper"
        "SUPER_SHIFT, comma, exec, rofi-wallust-theme"

        # special keys
        # "XF86AudioPlay, mpvctl playpause"

        # audio
        ",XF86AudioLowerVolume, exec, ${pamixer} -d 5"
        ",XF86AudioRaiseVolume, exec, ${pamixer} -i 5"
        ",XF86AudioMute, exec, ${pamixer} -t"

        "SUPER, n, exec, hypr-wallpaper"
      ]
      ++ lib.optionals config.custom.backlight.enable [
        ",XF86MonBrightnessDown, exec, ${lib.getExe pkgs.brightnessctl} set 5%-"
        ",XF86MonBrightnessUp, exec, ${lib.getExe pkgs.brightnessctl} set +5%"
      ];

    # Move/resize windows with SUPER + LMB/RMB and dragging
    bindm = [
      # "SUPER, mouse:272, movewindow"
      "SUPER, code:49, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };
}
