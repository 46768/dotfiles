{ config, pkgs, ... }:

{
	imports = [ ../kitty/kitty.nix ];

	home.file = {
		".config/hypr/main.conf" = {
			source = ./hyprmain.conf;
			target = ".config/hypr/hyprmain.conf";
		};

		".config/hypr/background" = {
			source = ./background;
			recursive = true;
			target = ".config/hypr/background";
		};

		".config/hypr/waybar" = {
			source = ./waybar;
			recursive = true;
			target = ".config/hypr/waybar";
		};
	};

	wayland.windowManager.hyprland = {
		enable = true;

		settings = {
			"source" = "./hyprmain.conf";
		};
	};

	services.hyprpaper = {
		enable = true;
		settings = {
			preload = "~/.config/hypr/background/bg1.png";
			wallpaper = ", ~/.config/hypr/background/bg1.png";
		};
	};

	programs.hyprlock = {
		enable = true;
		settings = {
			background = {
				monitor = "";
				path = "~/.config/hypr/background/bg1.png";
			};

			input-field = {
				monitor = "";
				size = "200, 50";
				outline_thickness = 3;
				dots_size = "0.33";
				dots_spacing = "0.15";
				dots_center = false;
				dots_rounding = -1;
				outer_color = "rgb(151515)";
				inner_color = "rgb(200, 200, 200)";
				font_color = "rgb(10, 10, 10)";
				fade_on_empty = false;
				placeholder_text = "<i>Input Password</i>";
				hide_input = false;
				rounding = -1;
				check_color = "rgb(204, 136, 34)";
				fail_color = "rgb(204, 34, 34)";
				fail_text = "<i>Nope</i>";
				fail_transition = 300;
				capslock_color = -1;
				numlock_color = -1;
				bothlock_color = -1;
				invert_numlock = false;
				swap_font_color = false;

				position = "0, -20";
				halign = "center";
				valign = "center";
			};
		};
	};

	programs.waybar = {
		enable = true;
		style = ./waybar/style.css;
		settings = {
			mainBar = {
			"layer" = "top";
			"modules-left" = ["wireplumber" /*"hyprland/workspaces"*/];
			"modules-center" = [ "clock" ];
			"modules-right" = [ "battery" "cpu" "memory" "network" ];

			"battery" = {
				"states" = {
					"warning" = 30;
					"critical" = 15;
				};
				"format" = "{capacity}% {icon}";
				"format-charging" = "󱐋 {capacity}% {icon}";
				"format-plugged" = "󱐋 {capacity}% {icon}";
				"format-icons" = [
					""
						""
						"" 
						"" 
						""
				];
			};

			"cpu" = {
				"format" = "{usage}% ";
			};

			"memory" = {
				"format" = "{}% ";
			};

			"network" = {
				"format" = "{essid} {icon}";
				"tooltip-format" = "IP: {ipaddr}\nGateway: {gwaddr}\nSpeed: {bandwidthTotalBytes}";
				"format-ethernet" = "{ipaddr} 󰌗";
				"format-disconnected" = "None 󰪎";
				"format-icons" = [
					"󰤯"
						"󰤟"
						"󰤢"
						"󰤥"
						"󰤨"
				];
			};

			"wireplumber" = {
				"format" = "{volume}% ";
				"format-muted" = "Off ";
			};

			"clock" = {
				"format" = "{:%H:%M %d/%m/%Y}";
			};

			"hyprland/workspaces" = {
				"disable-scroll" = true;
				"all-outputs" = true;
				"persistent_workspaces" = {
					"1" = [];
					"2" = [];
					"3" = [];
					"4" = [];
					"5" = [];
					"6" = [];
					"7" = [];
					"8" = [];
					"9" = [];
					"10" = [];
				};
			};
		};
	};
	};
}
