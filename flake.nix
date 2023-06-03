{
  description = "yet another way to paint a cat";

  inputs.std.url = "github:divnix/std";
  inputs.haumea.url = "github:nix-community/haumea";
  inputs.nixpkgs.follows = "std/nixpkgs";

  ##: original sources
  inputs.base16-schemes.url = "github:tinted-theming/base16-schemes";
  inputs.base16-schemes.flake = false;

  outputs = {
    std,
    haumea,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./nix;
      cellBlocks = with std.blockTypes; [
        # Development Environments
        (nixago "config")
        (devshells "shells")
      ];
    }
    {
      lib = haumea.lib.load {
        src = ./src;
        loader = haumea.lib.loaders.verbatim;
      };
    };
}
