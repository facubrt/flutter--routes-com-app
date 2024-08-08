import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routescom/core/constants/constants.dart';
import 'package:routescom/core/utils/transitions.dart';
import 'package:routescom/src/customisation/presentation/providers/customisation_controller.dart';
import 'package:routescom/src/customisation/presentation/views/pages/config_page.dart';
import 'package:routescom/src/communication/presentation/views/widgets/home_group_widget.dart';
import 'package:routescom/src/route_card/domain/entities/route_card.dart';
import 'package:routescom/src/route_card/presentation/providers/route_card_controller.dart';

class CommunicationPage extends ConsumerWidget {
  const CommunicationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appParameters = ref.watch(customisationControllerProvider);
    final routeCards = ref.watch(routeCardControllerProvider);
    List<RouteCard> listCards = routeCards.where((card) => card.parent == null).toList();
    
    return Scaffold(
      backgroundColor: appParameters.highContrast ? Colors.black : Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          HOME_SCREEN_TITLE,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003A70),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                FadeTransitionRoute(
                  widget: const ConfigPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: HomeGroupWidget(listCards: listCards),
      ),
    );
  }
}
