{ config, pkgs, ... }:

{
	imports = [
		../kitty/kitty.nix
			./hyprpaper.nix
			./hyprlock.nix
			./waybar.nix
			./rofi.nix
			./mako.nix
	];

	home.packages = [
		# Hyprland Clipboard
		pkgs.wl-clipboard
		pkgs.grim
		pkgs.slurp
	];

	wayland.windowManager.hyprland = {
		enable = true;

		settings = {
			# Monitors
			"monitor" = [
				"eDP-1, preferred, auto, 1"
				"HDMI-A-1, preferred, auto-right, 1"
			];

			# Programs
			"$terminal" = "kitty";
			"$fileManager" = "dolphin";
			"$webBrowser" = "librewolf";
			"$menu" = "rofi -show drun";
			"$audioStepI" = "5%+";
			"$audioStepD" = "5%-";
			"$audioLimit" = "1.0";

			# Autostart
			"exec-once" = [
				"hyprpaper"
				"waybar"
				"mako"
				"fcitx5 -d -r"
				"fcitx5-remote -r"
			];

			# Environment variables
			"env" = [
				"XCURSOR_SIZE,24"
				"HYPRCURSOR_SIZE,24"
			];

			# Look and Feel
			"general" = {
				"gaps_in" = "5";
				"gaps_out" = "20";

				"border_size" = "2";

				"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
				"col.inactive_border" = "rgba(595959aa)";

				"resize_on_border" = "false";

				"allow_tearing" = "false";

				"layout" = "dwindle";
			};

			"decoration" = {
				"rounding" = "0";

				"active_opacity" = "1.0";
				"inactive_opacity" = "1.0";

				"shadow" = {
					"enabled" = "true";
					"range" = "4";
					"render_power" = "3";
					"color" = "rgba(1a1a1aee)";
				};

				"blur" = {
					"enabled" = "true";
					"size" = "3";
					"passes" = "1";

					"vibrancy" = "0.1696";
				};
			};

			"misc" = {
				"font_family" = "FiraCode Nerd Font Mono";

				"force_default_wallpaper" = "-1";
				"disable_hyprland_logo" = "false";
			};

			"animations" = {
				"enabled" = "true";

				"bezier" = "myBezier, 0.05, 0.9, 0.1, 1.05";

				"animation" = [
					"windows, 1, 7, myBezier"
					"windowsOut, 1, 7, default, popin 80%"
					"border, 1, 10, default"
					"borderangle, 1, 8 ,default"
					"fade, 1, 7, default"
					"workspaces, 1, 6, default"
				];
			};

			"dwindle" = {
				"pseudotile" = "true";
				"preserve_split" = "true";
			};

			"master" = {
				"new_status" = "master";
			};

			"input" = {
				"kb_layout" = "us";
				"kb_variant" = "";
				"kb_model" = "";
				"kb_options" = "";
				"kb_rules" = "";

				"repeat_delay" = "300";
				"repeat_rate" = "45";

				"follow_mouse" = "1";
				"sensitivity" = "0";
				"touchpad" = {
					"natural_scroll" = "false";
				};
			};

			"gestures" = {
				"workspace_swipe" = "false";
			};

			# Keybindings
			"$mainMod" = "SUPER";

			"bind" = [
				"$mainMod, Q, exec, $terminal"
				"$mainMod, C, killactive"
				"$mainMod, M, exit"
				"$mainMod, E, exec, $fileManager"
				"$mainMod, V, togglefloating"
				"$mainMod, R, exec, $menu"
				"$mainMod, P, pseudo"
				"$mainMod, J, togglesplit"
				"$mainMod, F, exec, $webBrowser"
				"$mainMod, L, exec, hyprlock"
				"$mainMod, N, exec, grim"
				"$mainMod, B, exec, slurp | grim -g -"
				"$mainMod, G, exec, $webBrowser https://search.nixos.org/packages"

				"$mainMod, left, movefocus, l"
				"$mainMod, right, movefocus, r"
				"$mainMod, up, movefocus, u"
				"$mainMod, down, movefocus, d"

				"$mainMod, 1, workspace, 1"
				"$mainMod, 2, workspace, 2"
				"$mainMod, 3, workspace, 3"
				"$mainMod, 4, workspace, 4"
				"$mainMod, 5, workspace, 5"
				"$mainMod, 6, workspace, 6"
				"$mainMod, 7, workspace, 7"
				"$mainMod, 8, workspace, 8"
				"$mainMod, 9, workspace, 9"
				"$mainMod, 0, workspace, 10"

				"$mainMod SHIFT, 1, movetoworkspace, 1"
				"$mainMod SHIFT, 2, movetoworkspace, 2"
				"$mainMod SHIFT, 3, movetoworkspace, 3"
				"$mainMod SHIFT, 4, movetoworkspace, 4"
				"$mainMod SHIFT, 5, movetoworkspace, 5"
				"$mainMod SHIFT, 6, movetoworkspace, 6"
				"$mainMod SHIFT, 7, movetoworkspace, 7"
				"$mainMod SHIFT, 8, movetoworkspace, 8"
				"$mainMod SHIFT, 9, movetoworkspace, 9"
				"$mainMod SHIFT, 0, movetoworkspace, 10"

				"$mainMod, S, togglespecialworkspace, magic"
				"$mainMod SHIFT, S, movetoworkspace, special:magic"

				"$mainMod, mouse_down, workspace, e+1"
				"$mainMod, mouse_up, workspace, e-1"
			];

			"bindm" = [
				"$mainMod, mouse:272, movewindow"
				"$mainMod, mouse:273, resizewindow"
			];

			"bindr" = [
				"ALT, A, exec, wpctl set-volume -l $audioLimit @DEFAULT_AUDIO_SINK@ $audioStepI"
				"ALT, X, exec, wpctl set-volume -l $audioLimit @DEFAULT_AUDIO_SINK@ $audioStepD"
				"ALT, Z, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
			];

			"windowrulev2" = [
				"suppressevent maximize, class:.*"
			];
		};
	};
}
