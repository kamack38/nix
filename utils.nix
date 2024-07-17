{
  readFromDir =
    (dir: (map (f: dir + "/${f}") (builtins.attrNames (builtins.readDir dir))));
}
