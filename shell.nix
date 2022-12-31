{ pkgs ? import <nixpkgs> {} }:
let 
  providers = p: with p; [
    aws
    auth0
    cloudflare
    http
  ];
in
pkgs.mkShell {
  buildInputs = [
    pkgs.terraform.withPlugins providers
    pkgs.terraform-ls
    # Providers
    # pkgs.terraform-providers.cloudflare
    # pkgs.terraform-providers.aws
    # pkgs.terraform-providers.auth0
    # pkgs.terraform-providers.http
  ];
}
