let unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
    pkgs = import unstableTarball {};
in
  with pkgs;
  pkgs.mkShell rec {
    propagatedBuildInputs = [
      python37Full # Includes pip and tkinter
      pythonManylinuxPackages.manylinux2014Package
    ];
    LD_LIBRARY_PATH = "${pythonManylinuxPackages.manylinux2014Package}/lib";
    shellHook = ''
      mkdir -p .temp
      export TMPDIR=$(pwd)/.temp/
      if [[ ! -d .venv ]]; then
         python -m venv .venv
      fi
      source $(pwd)/.venv/bin/activate
      unset SOURCE_DATE_EPOCH
      pip install -r requirements.txt
    '';
  }
