import 'package:routescom/core/constants/constants.dart';
import 'package:routescom/src/route_card/domain/entities/route_card.dart';

class RouteCardModel extends RouteCard {
  RouteCardModel(
      {required super.name,
      required super.text,
      required super.color,
      required super.isGroup,
      required super.id,
      super.parent,
      super.img,
      super.children});

  static RouteCardModel empty = RouteCardModel(
    id: 99999,
    name: '',
    text: '',
    color: DEFAULT_COLOR_CARD,
    isGroup: false,
    parent: null,
    img: '',
    children: [],
  );

  factory RouteCardModel.fromJson(Map<dynamic, dynamic> json) {
    return RouteCardModel(
      name: json['name'],
      text: json['text'],
      color: json['color'],
      isGroup: json['isGroup'],
      id: json['id'],
      parent: json['parent'],
      img: json['img'],
      children: json['children'],
    );
  }

  Map<dynamic, dynamic> toJson() => {
        'id': id,
        'name': name,
        'text': text,
        'color': color,
        'isGroup': isGroup,
        'parent': parent,
        'img': img,
        'children': children,
      };

  factory RouteCardModel.fromEntity(RouteCard entity) {
    return RouteCardModel(
      name: entity.name,
      text: entity.text,
      color: entity.color,
      isGroup: entity.isGroup,
      id: entity.id,
      parent: entity.parent,
      img: entity.img,
      children: entity.children,
    );
  }

  RouteCardModel copyWith({
    String? name,
    String? text,
    String? color,
    String? img,
    bool? isGroup,
    int? parent,
    List<int>? children,
    int? id,
  }) =>
      RouteCardModel(
        name: name ?? this.name,
        text: text ?? this.text,
        color: color ?? this.color,
        img: img ?? this.img,
        isGroup: isGroup ?? this.isGroup,
        parent: parent ?? this.parent,
        children: children ?? this.children,
        id: id ?? this.id,
      );
}
