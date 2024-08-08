import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:routescom/src/route_card/data/models/route_card_model.dart';
import 'package:routescom/src/route_card/domain/entities/route_card.dart';

part 'card_controller.g.dart';

@Riverpod(keepAlive: true)
class CardController extends _$CardController {
  @override
  RouteCard build() => RouteCardModel.empty;

  void setCard({required RouteCard card}) {
    state = card;
  }

  void restartCard({int? idParent}) {
    state = RouteCardModel.empty;
  }

  void setParentCard({int? idParent}) {
    RouteCardModel routeCard = ref.read(cardControllerProvider.notifier).state as RouteCardModel;
    routeCard = routeCard.copyWith(
      parent: idParent,
    );
    state = routeCard;
  }

  void setTitleCard({required String title}) {
    
    RouteCardModel routeCard = ref.read(cardControllerProvider.notifier).state as RouteCardModel;
    routeCard = routeCard.copyWith(
      name: title,
    );
    state = routeCard;
  }

  void setTextCard({required String text}) {
    RouteCardModel routeCard = ref.read(cardControllerProvider.notifier).state as RouteCardModel;
    routeCard = routeCard.copyWith(
      text: text,
    );
    state = routeCard;
  }

  void setColorCard({required String color}) {
    RouteCardModel routeCard = ref.read(cardControllerProvider.notifier).state as RouteCardModel;
    routeCard = routeCard.copyWith(
      color: color,
    );
    state = routeCard;
  }

  void setImgCard({String? img}) {
    RouteCardModel routeCard = ref.read(cardControllerProvider.notifier).state as RouteCardModel;
    routeCard = routeCard.copyWith(
      img: img,
    );
    state = routeCard;
  }

  void isGroupCard({required bool isGroup}) {
    RouteCardModel routeCard = ref.read(cardControllerProvider.notifier).state as RouteCardModel;
    routeCard = routeCard.copyWith(
      isGroup: isGroup,
    );
    state = routeCard;
  }
}