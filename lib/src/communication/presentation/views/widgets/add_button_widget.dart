import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routescom/core/utils/transitions.dart';
import 'package:routescom/src/customisation/presentation/providers/customisation_controller.dart';
import 'package:routescom/src/route_card/presentation/providers/card_controller.dart';
import 'package:routescom/src/route_card/presentation/views/editPage/pages/edit_page.dart';

class AddButtonWidget extends ConsumerWidget {
  final int? idParent;
  const AddButtonWidget({
    super.key,
    this.idParent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size mq = MediaQuery.of(context).size;
    final appParameters = ref.watch(customisationControllerProvider);
    Orientation orientation = MediaQuery.of(context).orientation;
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.infinity,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: orientation == Orientation.portrait
                    ? mq.width * appParameters.factorSize * 2
                    : mq.height * appParameters.factorSize * 2,
                color: appParameters.highContrast ? Colors.white : Colors.grey,
              ),
              Text(
                'Nuevo',
                style: TextStyle(
                    fontSize: orientation == Orientation.portrait
                        ? mq.width * appParameters.factorSize
                        : mq.height * appParameters.factorSize,
                    fontWeight: FontWeight.bold,
                    color: appParameters.highContrast ? Colors.white : Colors.grey),
              )
            ],
          ),
          onTap: () {
            HapticFeedback.lightImpact();
            ref.read(cardControllerProvider.notifier).restartCard(idParent: idParent);
            ref.read(cardControllerProvider.notifier).setParentCard(idParent: idParent);
            Navigator.push(
              context,
              SlideLeftTransitionRoute(widget: const EditPage(),),
            );
          },
        ),
      ),
    );
  }

  void showCustomDialog() {}
}
