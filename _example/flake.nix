{
  inputs = {
    action-validator.url = github:a-h/nix-mpalmer-action-validator;
    # For local development, use this instead.
    #action-validator.url = "path:../";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, action-validator, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
          pkgs = import nixpkgs {
            system = system;
          };
      in
      {
        # Access this by `nix shell`
        defaultPackage = action-validator.outputs.packages.${system};
        # Access this via `nix develop`
        devShell = pkgs.mkShell {
          packages = [
            action-validator.outputs.packages.${system}
            pkgs.cowsay
          ];
        };
      }
    );
}
