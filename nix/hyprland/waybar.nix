{ config, pkgs, ... }:

{
	xdg.configFile = {
		"waybar/style.css" = {
			source = "${config.home.homeDirectory}/dotfiles/hyprland/hyprland/waybar/style.css";
			target = "waybar/style.css";
		};
	};

	programs.waybar = {
		enable = true;
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
