{ nixpkgs ? import <nixpkgs> { } }:
let pkgs = {
  atomi = (
    with import (fetchTarball "https://github.com/kirinnee/test-nix-repo/archive/refs/tags/v7.0.0.tar.gz");
    {
      inherit pls;
    }
  );
  "Unstable 18th September 2021" = (
    with import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/9f75aabfb06346e7677fc3ad53cc9b6669eead61.tar.gz") { };
    {
      inherit
        pre-commit
        git
        shfmt
        shellcheck
        nixpkgs-fmt
        bash
        coreutils
        kube3d
        kubernetes-helm
        kubectl
        go-task
        gnugrep
        jq
        terraform
        stern;


      prettier = nodePackages.prettier;
    }
  );
}; in
with pkgs;
pkgs."Unstable 18th September 2021" // pkgs.atomi
