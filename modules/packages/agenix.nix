{ ... }: {
  perSystem = { inputs', ... }: {
    packages.agenix = inputs'.agenix.packages.agenix;
  };
}
