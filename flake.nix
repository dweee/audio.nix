{
  description = "Audio Nix packages and modules";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nix-buildproxy.url = "github:polygon/nix-buildproxy/v0.1.0";
  };


  outputs = { self, nixpkgs, nix-buildproxy }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ nix-buildproxy.overlays.default ];
    };
  in
  {
    packages.${system} = {
      # Various VSTs
      amplocker = pkgs.callPackage ./vst/amplocker { };
      atlas2 = pkgs.callPackage ./vst/atlas2.nix { };
      plugdata = pkgs.callPackage ./vst/plugdata.nix { };
      paulxstretch = pkgs.callPackage ./vst/paulxstretch.nix { };
      vital = pkgs.callPackage ./vst/vital.nix { };

      # Bitwig
      bitwig-studio4 = pkgs.callPackage ./bitwig/bitwig-studio4.nix { };
      bitwig-studio5-beta3 = pkgs.callPackage ./bitwig/bitwig-studio5-beta3.nix { };
      bitwig-studio5-beta5 = pkgs.callPackage ./bitwig/bitwig-studio5-beta5.nix { };
      bitwig-studio5-beta6 = pkgs.callPackage ./bitwig/bitwig-studio5-beta6.nix { };
      bitwig-studio5-beta8 = pkgs.callPackage ./bitwig/bitwig-studio5-beta8.nix { };
      bitwig-studio5-beta9 = pkgs.callPackage ./bitwig/bitwig-studio5-beta9.nix { };
      bitwig-studio5-beta10 = pkgs.callPackage ./bitwig/bitwig-studio5-beta10.nix { };
      bitwig-studio5-beta11 = pkgs.callPackage ./bitwig/bitwig-studio5-beta11.nix { };
      bitwig-studio5-beta12 = pkgs.callPackage ./bitwig/bitwig-studio5-beta12.nix { };
      bitwig-studio5-beta13 = pkgs.callPackage ./bitwig/bitwig-studio5-beta13.nix { };
      bitwig-studio5 = pkgs.callPackage ./bitwig/bitwig-studio-5.0.nix { };
      bitwig-studio5-1-beta1 = pkgs.callPackage ./bitwig/bitwig-studio-5.1-beta1.nix { };
      bitwig-studio5-1-beta2 = pkgs.callPackage ./bitwig/bitwig-studio-5.1-beta2.nix { };
      bitwig-studio5-1-beta3 = pkgs.callPackage ./bitwig/bitwig-studio-5.1-beta3.nix { };
      bitwig-studio5-1-beta4 = pkgs.callPackage ./bitwig/bitwig-studio-5.1-beta4.nix { };
      bitwig-studio5-1-beta5 = pkgs.callPackage ./bitwig/bitwig-studio-5.1-beta5.nix { };
      bitwig-studio5-1-beta6 = pkgs.callPackage ./bitwig/bitwig-studio-5.1-beta6.nix { };
      bitwig-studio5-1-beta7 = pkgs.callPackage ./bitwig/bitwig-studio-5.1-beta7.nix { };
      bitwig-studio5-1-beta8 = pkgs.callPackage ./bitwig/bitwig-studio-5.1-beta8.nix { };
      bitwig-studio5-1-beta9 = pkgs.callPackage ./bitwig/bitwig-studio-5.1-beta9.nix { };
      bitwig-studio5-1 = pkgs.callPackage ./bitwig/bitwig-studio-5.1.nix { };
      bitwig-studio5-2-beta = pkgs.callPackage ./bitwig/bitwig-studio-5.2-beta.nix { };
      bitwig-studio5-latest = self.packages.${system}.bitwig-studio5-2-beta;
      bitwig-studio5-stable-latest = self.packages.${system}.bitwig-studio5-1;

      # Chow plugins
      chow-centaur = pkgs.callPackage ./chow/chow-centaur.nix { };  
      chow-kick = pkgs.callPackage ./chow/chow-kick.nix { };  
      chow-phaser = pkgs.callPackage ./chow/chow-phaser.nix { };  
      chow-tape-model = pkgs.callPackage ./chow/chow-tape-model.nix { };  
      chow-multitool = pkgs.callPackage ./chow/chow-multitool.nix { };

      libonnxruntime-neuralnote = pkgs.callPackage ./vst/neuralnote/libonnxruntime-neuralnote.nix { };
      neuralnote = pkgs.callPackage ./vst/neuralnote/neuralnote.nix { libonnxruntime-neuralnote = self.packages.${system}.libonnxruntime-neuralnote; };
      grainbow = pkgs.callPackage ./vst/grainbow { };
      papu = pkgs.callPackage ./vst/papu.nix { };
    };

    overlays.default = (final: prev: {
      atlas2 = self.packages.${system}.atlas2;
      plugdata = self.packages.${system}.plugdata;
      paulxstretch = self.packages.${system}.paulxstretch;
      bitwig-studio4 = self.packages.${system}.bitwig-studio4;
      bitwig-studio5 = self.packages.${system}.bitwig-studio5;
      bitwig-studio5-latest = self.packages.${system}.bitwig-studio5-latest;
      bitwig-studio5-stable-latest = self.packages.${system}.bitwig-studio5-stable-latest;
      chow-centaur = self.packages.${system}.chow-centaur;
      chow-kick = self.packages.${system}.chow-kick;
      chow-phaser = self.packages.${system}.chow-phaser;
      chow-tape-model = self.packages.${system}.chow-tape-model;
      chow-multitool = self.packages.${system}.chow-multitool;
      neuralnote = self.packages.${system}.neuralnote;
      vital = self.packages.${system}.vital;
      amplocker = self.packages.${system}.amplocker;
      grainbow = self.packages.${system}.grainbow;
      papu = self.packages.${system}.papu;
    });

    devShells.${system}.juce = pkgs.callPackage ./devshell/juce.nix { };
  };
}
