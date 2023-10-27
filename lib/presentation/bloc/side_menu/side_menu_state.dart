class SideMenuState {
  final String? routeName;

  SideMenuState({
    this.routeName,
  });

  SideMenuState copyWith({
    String? routeName,
  }) {
    return SideMenuState(
      routeName: routeName ?? this.routeName,
    );
  }
}
