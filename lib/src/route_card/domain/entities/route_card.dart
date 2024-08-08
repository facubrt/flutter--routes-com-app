class RouteCard {
  final String name;
  final String text;
  final String color;
  final String? img;
  final bool isGroup;
  final int? parent;
  final List<int>? children;
  final int id;

  const RouteCard({
    required this.name,
    required this.text,
    required this.color,
    this.img,
    required this.isGroup,
    this.parent,
    this.children,
    required this.id,
  });
}
