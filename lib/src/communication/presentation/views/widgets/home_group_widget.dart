import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routescom/core/constants/constants.dart';
import 'package:routescom/src/communication/presentation/views/widgets/add_button_widget.dart';
import 'package:routescom/src/communication/presentation/views/widgets/button_widget.dart';
import 'package:routescom/src/communication/presentation/views/widgets/add_template_widget.dart';
import 'package:routescom/src/customisation/presentation/providers/customisation_controller.dart';

class HomeGroupWidget extends ConsumerWidget {
  final int? idParent;
  final List<dynamic> listCards;
  const HomeGroupWidget({super.key, this.idParent, required this.listCards});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size mq = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    final appParameters = ref.watch(customisationControllerProvider);

    if (listCards.isNotEmpty) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: mq.width >= LARGE_SCREEN_SIZE
              ? 4
              : (mq.width < LARGE_SCREEN_SIZE && mq.width >= MEDIUM_SCREEN_SIZE)
                  ? 3
                  : 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: listCards.length + 2,
        itemBuilder: ((_, index) {
          if (index < listCards.length) {
            return ButtonWidget(
              card: listCards[index],
              id: index,
            );
          } else {
            if (appParameters.editMode) {
              if (index == listCards.length) {
                return AddButtonWidget(
                  idParent: idParent,
                );
              } else {
                return AddTemplateWidget(
                  idParent: idParent,
                );
              }
            }
            return const SizedBox.shrink();
          }
        }),
      );
    }
    return appParameters.editMode
        ? GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: mq.width >= LARGE_SCREEN_SIZE
                  ? 4
                  : (mq.width < LARGE_SCREEN_SIZE &&
                          mq.width >= MEDIUM_SCREEN_SIZE)
                      ? 3
                      : 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            children: [
              AddButtonWidget(idParent: idParent),
              AddTemplateWidget(
                idParent: idParent,
              ),
            ],
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: appParameters.highContrast
                            ? Colors.white24
                            : Colors.black12,
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      Icons.edit,
                      color: appParameters.highContrast
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: mq.width * 0.04,
                  ),
                  Text(
                    EDIT_MODE_TEXT,
                    style: TextStyle(
                      color: appParameters.highContrast
                          ? Colors.white
                          : Colors.black,
                      fontSize: orientation == Orientation.portrait
                          ? mq.width * appParameters.factorSize
                          : mq.height * appParameters.factorSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
  }
}
