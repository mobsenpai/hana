{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      inputs.nur.overlay
    ];
  };
}
