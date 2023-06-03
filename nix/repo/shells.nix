{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
in {
  # Tool Homepage: https://numtide.github.io/devshell/
  default = std.lib.dev.mkShell {
    name = "nix-base16-schemes";

    # Tool Homepage: https://nix-community.github.io/nixago/
    # This is Standard's devshell integration.
    # It runs the startup hook when entering the shell.
    nixago = [
      std.lib.cfg.conform
      (std.lib.cfg.treefmt cell.config.treefmt)
      (std.lib.cfg.editorconfig cell.config.editorconfig)
      (std.lib.cfg.githubsettings cell.config.githubsettings)
      (std.lib.cfg.lefthook cell.config.lefthook)
      (std.lib.cfg.mdbook cell.config.mdbook)
    ];

    env = [
      {
        name = "BASE16_SCHEMES_PATH";
        eval = inputs.base16-schemes.outPath;
      }
    ];

    commands = [
      {
        category = "tasks";
        package = nixpkgs.just;
      }
      {
        category = "tasks";
        name = "copy-src-yaml";
        command = ''

        '';
      }
      {
        category = "tools";
        package = nixpkgs.yaml2json;
      }
      {
        category = "rendering";
        package = nixpkgs.mdbook;
      }
    ];

    # packages = [nixpkgs.nushell];

    imports = [std.std.devshellProfiles.default];
  };
}
