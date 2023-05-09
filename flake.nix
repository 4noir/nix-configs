{
    description = "My nix config";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

        home-manager.url = "github:nix-community/home-manager/release-22.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        home-manager-unstable.url = "github:nix-community/home-manager";
        home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";

        nix-darwin.url = "github:LnL7/nix-darwin";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

        futils.url = "github:numtide/flake-utils";
    };
    outputs = { self, nixpkgs, nixpkgs-unstable, nix-darwin, home-manager, home-manager-unstable, ...}:
    let
        pkgs-unstable-x64-linux = nixpkgs-unstable.legacyPackages."x86_64-linux";
        pkgs-unstable-x64-darwin = nixpkgs-unstable.legacyPackages."x86_64-darwin";
        pkgs-unstable-aarch64-darwin = nixpkgs-unstable.legacyPackages."aarch64-darwin";

        pkgs-x64-linux = nixpkgs.legacyPackages."x86_64-linux";
        pkgs-x64-darwin = nixpkgs.legacyPackages."x86_64-darwin";
        pkgs-aarch64-darwin = nixpkgs.legacyPackages."aarch64-darwin";
    in
    {
        homeConfigurations = {
            "pie" = home-manager.lib.homeManagerConfiguration {
                pkgs = pkgs-x64-linux;
                modules = [ ./home/raphael.leroy ];
            };
            "wsl" = home-manager-unstable.lib.homeManagerConfiguration {
                pkgs = pkgs-unstable-x64-linux;
                modules = [ ./home/shin ];
            };
        };
    };
}