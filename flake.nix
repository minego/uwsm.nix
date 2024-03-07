{
	description = "Universal Wayland Session Manager";

	inputs = {
		nixpkgs = {
			url = "github:NixOS/nixpkgs/nixos-unstable";
		};

		# Override the systems for the flake, because this only builds on Linux
		systems = {
			url = "github:nix-systems/default-linux";
		};

		flake-utils = {
			url	= "github:numtide/flake-utils";
			inputs.systems.follows = "systems";
		};

		uwsm = {
			url = github:Vladimir-csp/uwsm;
			flake = false;
		};
	};

	outputs = { self, nixpkgs, flake-utils, ... }@inputs:

	let
		overlay = final: prev: {
			uwsm					= prev.pkgs.callPackage ./derivation.nix { inherit inputs; };
		};
	in

	flake-utils.lib.eachDefaultSystem (system:
		let
			pkgs = nixpkgs.legacyPackages.${system}.extend overlay;
		in rec {
			packages.uwsm			= pkgs.uwsm;

			packages.default		= packages.uwsm;
			devShells.default		= import ./shell.nix { inherit pkgs; };
		}
	)
	//
	{
		overlays.default			= overlay;
	};
}


