{ stdenv, pkgs, fetchurl, ... }:
stdenv.mkDerivation rec {
  pname = "jetbrains-agent";
  version = "2022.2.0";
  # src = fetchurl {
  #   url = "https://sso.ylyhappy.cn/jetbra.zip?e=1690198221&attname=&token=p3TgNmhjou3tLt9UguPxSBztvjmHFEdSLD24XnL7:dhAcDxz1PtQP1oBzCFBM8We9UCA=";
  #   sha256 = "sha256-3WHmik7+bekiHrb1s+xiFBlTpFJH0Rm9uM6CAQQLRcA=";
  # };

  src = ./ja-netfilter-2022.2.0.zip;
  nativeBuildInputs = with pkgs; [ unzip ];

  unpackPhase = ''
    unzip $src -d $out
  '';
  installPhase = ''
  '';
}

