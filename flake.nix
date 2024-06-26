{
  description = "my project description";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:

    let
      overlay =
      let version = "2022.3.3";
      in
        final: prev: {
          jetbrains-idea-ultimate-d = prev.jetbrains.idea-ultimate.overrideAttrs (finalAttrs: {
            src = prev.fetchurl {
              url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
              sha256 = "sha256-wwK9hLSKVu8bDwM+jpOg2lWQ+ASC6uFy22Ew2gNTFKY=";
            };  
            installPhase = finalAttrs.installPhase + ''
            echo '-javaagent:${(final.callPackage ./jetbrains-agent.nix { })}/ja-netfilter/ja-netfilter.jar=jetbrains
--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED'>> $out/idea-ultimate/bin/idea64.vmoptions
            '';
          });
        };
    in
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
         rec {
            packages = {
              idea = pkgs.jetbrains-idea-ultimate-d;
            };
          }
        )
      // {
        overlays.default = overlay;
      };
}
