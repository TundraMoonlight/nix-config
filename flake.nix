{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    catppuccin.url = "github:catppuccin/nix";

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: To ensure compatibility with the latest Firefox version, use nixpkgs-unstable.
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = inputs@{ silentSDDM, self, zen-browser, nvf, nixpkgs, home-manager, catppuccin }: {
    nixosConfigurations.moonlight = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};

    modules = [ 
        ./configuration.nix
	catppuccin.nixosModules.catppuccin
	nvf.nixosModules.default

	home-manager.nixosModules.home-manager {
	  home-manager = {
	    useGlobalPkgs = true;
	    useUserPackages = true;
      backupFileExtension = "back";
	    extraSpecialArgs = {inherit inputs;};
	    users.tundra = import ./home.nix;
	  };
	}
      ];	
    };
  };
}
