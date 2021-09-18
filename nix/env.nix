{ nixpkgs ? import <nixpkgs> { } }:
let pkgs = import ./packages.nix { inherit nixpkgs; }; in
with pkgs;
{
  system = [
    coreutils
    gnugrep
    jq
  ];

  dev = [
    pls
    go-task
    kube3d
    terraform
    stern
  ];

  minimal = [
    kubernetes-helm
    kubectl
  ];


  lint = [
    pre-commit
    nixpkgs-fmt
    prettier
    shfmt
    shellcheck
  ];


}
