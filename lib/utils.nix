lib: let
  inherit
    (lib)
    attrNames
    filterAttrs
    ;
in {
  # We use an unorthodox pkgs reference here because pkgs will not be in the
  # first layer of arguments if it is not explicitly added to the module
  # parameters. This is annoying because the LSP complains about pkgs being an
  # unused argument when it actually is used. This method avoids that.
  flakePkgs = args: flake: args.inputs.${flake}.packages.${args.options._module.args.value.pkgs.system};

  # Get list of all nix files and directories in path for easy importing
  scanPaths = path:
    map (f: (path + "/${f}"))
    (attrNames
      (filterAttrs
        (
          path: _type:
            (_type == "directory")
            || (
              (path != "default.nix")
              && (lib.strings.hasSuffix ".nix" path)
            )
        )
        (builtins.readDir path)));
}
