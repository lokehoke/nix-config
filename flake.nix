{
  description = "lokehoke's Ubuntu + Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      mkHome =
        extraModules:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/lokehoke.nix ] ++ extraModules;
        };
    in
    {
      homeConfigurations = {
        lokehoke = mkHome [ { my.desktop.enable = true; } ];
        lokehoke-minimal = mkHome [ ];
        lokehoke-audio = mkHome [
          {
            my.desktop.enable = true;
            my.audio.enable = true;
          }
        ];
      };
      checks.${system}.minimal = self.homeConfigurations.lokehoke-minimal.activationPackage;
      apps.${system}.home-manager = {
        type = "app";
        program = "${home-manager.packages.${system}.home-manager}/bin/home-manager";
      };
      formatter.${system} = pkgs.nixfmt-tree;
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nixfmt
          statix
          deadnix
          shellcheck
          python3
        ];
      };
    };
}
