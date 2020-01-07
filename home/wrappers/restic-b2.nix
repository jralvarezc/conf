with import <nixpkgs> {};

let
  cmd = "restic-b2";
  store = ../../secrets.yml;
  sops = "${pkgs.sops}/bin/sops";
  secret = (v: "export ${v}=\$(${sops} -d --extract '[\"${v}\"]' ${store})");
  wrapper = pkgs.writeShellScriptBin cmd ''
    export PATH=${lib.makeBinPath [ sops gnupg ]}
    ${secret "B2_ACCOUNT_ID"}
    ${secret "B2_ACCOUNT_KEY"}
    ${secret "RESTIC_PASSWORD"}
    ${secret "RESTIC_REPOSITORY"}
    ${pkgs.restic}/bin/restic "$@"
  '';
in stdenv.mkDerivation {
  name = cmd;
  src = ./.;
  installPhase = ''
    mkdir -p $out/bin
    install ${wrapper}/bin/* $out/bin
  '';
}
