# Example at https://lantian.pub/en/article/modify-computer/nixos-packaging.lantian/
{ lib
, stdenv
, fetchFromGitHub
, pkgs
, ...
} @ args:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "action-validator";
  version = "v0.1.2";

  src = fetchFromGitHub {
    owner = "mpalmer";
    repo = pname;
    rev = version;
    sha256 = "sha256-66p/1AFD9dP8WvAy9efK8WLMrELbRO1jr2BaBzpmRWY=";
  };

  cargoSha256 = "sha256-/9+BxukZ83DeLYLnCcuJjfgdaf0fkPNwW4rYygX8zlc=";

  #buildInputs = (
     #lib.optionals stdenv.isDarwin [
       #pkgs.darwin.apple_sdk.frameworks.Security
     #]
  #);

  meta = with lib; {
    description = "Tool to validate GitHub Action and Workflow YAML files";
    homepage = "https://github.com/mpalmer/action-validator";
    license = licenses.gpl3Only;
  };
}
