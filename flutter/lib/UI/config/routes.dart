class Routes {
  static final landing = RouteName("/");
  static final home = RouteName("/home");
}

class RouteName {
  final String name;

  const RouteName(this.name);
}
