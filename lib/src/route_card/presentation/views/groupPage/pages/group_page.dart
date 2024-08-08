import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routescom/core/constants/constants.dart';
import 'package:routescom/core/theme/color_app.dart';
import 'package:routescom/src/customisation/presentation/providers/customisation_controller.dart';
import 'package:routescom/src/route_card/domain/entities/route_card.dart';
import 'package:routescom/src/route_card/presentation/providers/route_card_controller.dart';
import 'package:routescom/src/route_card/presentation/views/groupPage/widgets/group_widget.dart';

class GroupPage extends ConsumerWidget {
  final String? groupName;
  final Color? groupColor;
  final int? idParent;
  const GroupPage({super.key, this.groupName, this.groupColor, this.idParent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appParameters = ref.watch(customisationControllerProvider);
    final routeCards = ref.watch(routeCardControllerProvider);
    
    List<RouteCard> listCards = routeCards.where((card) => card.parent == idParent).toList();
    return Scaffold(
      backgroundColor: appParameters.highContrast ? Colors.black : Colors.white,
      appBar: AppBar(
              title: Text(
                groupName ?? APP_NAME,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              backgroundColor: groupColor ?? TAColors.brandblue,
              iconTheme: const IconThemeData(color: Colors.white),
              centerTitle: true,
              elevation: 0,
            ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GroupWidget(listCards: listCards, idParent: idParent),
      ),
    );
  }
}
