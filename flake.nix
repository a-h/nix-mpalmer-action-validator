{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = import nixpkgs {
          system = system;
        };
        action-validator = pkgs.callPackage ./action-validator.nix {};
      in
      {
        defaultPackage = action-validator;
        packages = action-validator;
      }
    );
}
