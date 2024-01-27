{inputs, ...}: {
    nixpkgs = {
    # overlays = [
    #   inputs.nur.overlay
    # ];

    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      # allowUnfreePredicate = _: true; # todo: check this
    };
  };
}