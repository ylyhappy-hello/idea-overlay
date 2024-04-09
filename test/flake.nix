{
  description = "my project description";
  inputs.idea.url = "github:ylyhappy-hello/idea-overlay";

  outputs = { self, nixpkgs, idea}:
  let pkgs = import nixpkgs {
    system = "x86_64-linux";
    overlays = [idea.overlays.default];
  }; in {
    packages.x86_64-linux.default = pkgs.jetbrains-idea-ultimate-d;
  };
}
