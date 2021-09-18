{ nixpkgs ? import <nixpkgs> { } }:
nixpkgs.mkShell {
  buildInputs = [
    nixpkgs.kube3d
    nixpkgs.kubernetes-helm
    nixpkgs.kubectl
    nixpkgs.stern
  ];

}
