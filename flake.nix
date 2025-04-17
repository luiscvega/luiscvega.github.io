{
  description = "A Nix-flake-based Elm development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

  outputs = {
    self,
    nixpkgs,
  }: {
    devShells.x86_64-linux.default = (import nixpkgs {system = "x86_64-linux";}).mkShell {
      packages = [
        (import nixpkgs {system = "x86_64-linux";}).gnumake
        (import nixpkgs {system = "x86_64-linux";}).nodejs_23
        (import nixpkgs {system = "x86_64-linux";}).elmPackages.elm
        (import nixpkgs {system = "x86_64-linux";}).elmPackages.elm-format
      ];

      shellHook = ''
      '';
    };
  };
}
