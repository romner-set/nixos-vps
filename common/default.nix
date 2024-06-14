{lib, ...}:
with lib.lists; {
  imports =
    concatMap (dir: map (n: "${dir}/${n}") (builtins.attrNames (builtins.readDir dir)))
    [./system ./services];
}
