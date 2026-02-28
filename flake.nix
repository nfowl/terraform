{
  description = "Personal Terraform configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils}:
    flake-utils.lib.eachDefaultSystem
      (system:
        let 
          pkgs = nixpkgs.legacyPackages.${system};
          tofuProvider = provider:
            provider.override (oldArgs: {
              provider-source-address =
                builtins.replaceStrings
                ["https://registry.terraform.io/providers"]
                ["registry.opentofu.org"]
                oldArgs.homepage;
            });
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = [
              pkgs.opentofu
              (pkgs.opentofu.withPlugins (ps:
                builtins.map tofuProvider [
                  ps.aws
                  ps.cloudflare
                  ps.http
                  ps.auth0
              ]))
              pkgs.terraform-ls
              pkgs.awscli2
            ];
          };
        }
      );
}
