{ config, pkgs, ... }:

{
	programs.kitty.environment = {
		"EDITOR" = "nvim";
		"JAVA_HOME" = "${pkgs.graalvm-ce}";
		"CC" = "${pkgs.gcc}/bin/gcc";
	};
}
