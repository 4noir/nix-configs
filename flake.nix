{
    description = "My nix config";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

        home-manager.url = "github:nix-community/home-manager/release-23.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        home-manager-unstable.url = "github:nix-community/home-manager";
        home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";

        darwin.url = "github:LnL7/nix-darwin";
        darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";

        agenix.url = "github:ryantm/agenix";
        agenix.inputs.nixpkgs.follows = "nixpkgs";

        futils.url = "github:numtide/flake-utils";
    };
    outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, home-manager-unstable, darwin, agenix, ...}: rec {
	    legacyPackagesUnstable = nixpkgs-unstable.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" ] (system:
	    	import nixpkgs-unstable {
	    		inherit system;
	    		config.allowUnfree = true;
	    	}
	    );
	    legacyPackages = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" ] (system:
	    	import nixpkgs {
	    		inherit system;
	    		config.allowUnfree = true;
                overlays = [ 
                    (self: super: {
                        bitwig-studio = legacyPackagesUnstable.${system}.bitwig-studio;
                    })
                ];
	    	}
	    );
        homeConfigurations = {
            "rleroy@PIE" = home-manager.lib.homeManagerConfiguration {
                pkgs = legacyPackages.x86_64-linux;
                modules = [ ./home/raphael.leroy-pie ];
            };
            "shin@GARDEN" = home-manager-unstable.lib.homeManagerConfiguration {
                pkgs = legacyPackagesUnstable.x86_64-linux;
                modules = [ ./home/shin-GARDEN ];
            };
        };

        darwinConfigurations."MARC" = darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [
                ./hosts/macbook-air
                home-manager-unstable.darwinModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.shinwoir = import ./home/shinwoir-MARC ;
                    home-manager.extraSpecialArgs = {system = "aarch64-darwin";};
                }
            ];
        };
        darwinPackages = self.darwinConfigurations."MARC".pkgs;

        nixosConfigurations = {
            marigold = nixpkgs.lib.nixosSystem rec {
                system = "x86_64-linux";
                pkgs = legacyPackages.x86_64-linux;
                
                modules = [
                    hosts/marigold
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.raph = import ./home/raph;
                        home-manager.extraSpecialArgs = {system = "x86_64-linux";};
                    }
                    modules/desktop
                    modules/gayming
                    modules/music
                    agenix.nixosModules.default
                    {
                        environment.systemPackages = [ agenix.packages.${system}.default ];
                    }
                ];
            };
        };
    };
}
