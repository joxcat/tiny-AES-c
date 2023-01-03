{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    flake-utils.url = "github:numtide/flake-utils";
    yotta = {
      url = "github:joxcat/yotta?dir=nix";
    };
  };

  outputs = { 
    self, 
    nixpkgs, 
    flake-utils, 
    yotta, 
  }: flake-utils.lib.eachSystem (with flake-utils.lib.system; [ x86_64-linux ]) (system:
  let
    pkgs = import nixpkgs {
      system = system;
    };

    yottaPackage = yotta.packages.${system}.default;
  in { 
    packages.default = yottaPackage;
    devShells.${system} = pkgs.mkShell {
      packages = [
        yottaPackage
      ];
    };

    checks = {};
  });
}

