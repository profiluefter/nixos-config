{ ... }:
{
  flake.modules.nixos.default =
    { ... }:
    {
      console.keyMap = "de-latin1-nodeadkeys";
    };
}
