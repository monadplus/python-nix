# Pulling from a non-pinned unstable version.
let unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
    pkgs = import unstableTarball {};
in
  pkgs.mkShell rec {
    name = "impure-python-venv";

    # Required by venvShellHook script
    venvDir = "./.venv";

    # build-time dependencies
    buildInputs = [
      # Includes pip and tkinter
      pkgs.python37Full
      # Triggers the .venv after entering the shell.
      pkgs.python37Packages.venvShellHook
    ];

    # Runtime dependencies
    propagatedBuildInputs = [
      # This contains most of the .so for building python libraries such as pandas
      pkgs.pythonManylinuxPackages.manylinux2014Package
      pkgs.python37Packages.tkinter
    ];

    # Add .so to the linker path
    LD_LIBRARY_PATH = "${pkgs.pythonManylinuxPackages.manylinux2014Package}/lib";

    postShellHook = ''
      pip install -r requirements.txt
    '';

  }
