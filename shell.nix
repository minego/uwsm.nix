{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
	name = "Universal Wayland Session Manager dev shell";

	nativeBuildInputs = with pkgs; [
		pkg-config
	];

	buildInputs = with pkgs; [
		gdb
	];
}
