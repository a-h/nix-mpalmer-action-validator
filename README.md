# Flake for action-validator

# Running - locally

If you've downloaded this code, you can run this by using `nix shell` in the current directory.

```sh
nix shell
```

# Running - remotely

If you haven't got the flake on disk, you can use it remotely like this.

```
nix shell github:a-h/nix-mpalmer-action-validator
```

# Using the flake

If you want to use this flake, but add your own stuff to the shell, you can create your own flake that imports this one.

See `_example/flake.nix`.

```nix
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
```
