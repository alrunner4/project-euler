{ nixpkgs ? import <nixpkgs> {}
, idris2 ? nixpkgs.idris2
}: let

# in case you've been interpreting within the working directory:
strip-build = builtins.filterSource
  (path: type: !(type == "directory" && baseNameOf path == "build"));

PROJECT_EULER_LIB = strip-build ./common;
PROJECT_EULER_SRC = n: strip-build ./problems/${n};

common-lib = derivation {
  name = "project-euler-common";
  system = builtins.currentSystem;
  inherit PROJECT_EULER_LIB;
  builder = nixpkgs.writeScript "project-euler-common-builder" ''
    #!${nixpkgs.bash}/bin/bash
    set -eux
    PATH+=:${nixpkgs.coreutils}/bin
    export IDRIS2_PACKAGE_PATH=${idris2}/idris2-${idris2.version}
    export IDRIS2_PREFIX=$out
    mkdir build
    ${idris2}/bin/idris2 \
      --install $PROJECT_EULER_LIB/package.ipkg \
      --build-dir $(pwd)/build
    '';
};

problem-builder = n: derivation {
  system = builtins.currentSystem;
  name = "project-euler-solution-${n}";
  PROJECT_EULER_SRC = PROJECT_EULER_SRC n;
  builder = nixpkgs.writeScript "project-euler-builder" ''
    #!${nixpkgs.bash}/bin/bash
    set -eux
    PATH+=:${nixpkgs.coreutils}/bin
    export IDRIS2_PACKAGE_PATH=${common-lib}/idris2-${idris2.version}
    ${idris2}/bin/idris2 $PROJECT_EULER_SRC/Main.idr \
      --source-dir $PROJECT_EULER_SRC \
      -p projecteuler-common \
      --exec main | tee $out
    '';
};

in map problem-builder (builtins.attrNames (builtins.readDir ./problems))
