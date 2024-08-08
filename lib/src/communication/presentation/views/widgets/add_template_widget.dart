import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:routescom/core/constants/constants.dart';
import 'package:routescom/core/utils/utils.dart';
import 'package:routescom/src/customisation/presentation/providers/customisation_controller.dart';
import 'package:routescom/src/route_card/presentation/providers/route_card_controller.dart';

class AddTemplateWidget extends ConsumerWidget {
  final int? idParent;
  const AddTemplateWidget({
    super.key,
    this.idParent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size mq = MediaQuery.of(context).size;
    final appParameters = ref.watch(customisationControllerProvider);
    final routeCards = ref.watch(routeCardControllerProvider);
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
                'Plantilla',
                style: TextStyle(
                    fontSize: orientation == Orientation.portrait
                        ? mq.width * appParameters.factorSize
                        : mq.height * appParameters.factorSize,
                    fontWeight: FontWeight.bold,
                    color: appParameters.highContrast ? Colors.white : Colors.grey),
              )
            ],
          ),
          onTap: () => showModalBottomSheet(
              context: context,
              showDragHandle: true,
              
              builder: (context) {
                
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.family_restroom),
                      title: const Text(TEMPLATE_FAMILY_TEXT),
                      enabled: routeCards.any((route) => route.name == TEMPLATE_FAMILY_TITLE) ? false : true,
                      onTap: () async {
                        loadTemplates(TEMPLATE_FAMILY).then((path) {
                          ref
                              .read(routeCardControllerProvider.notifier)
                              .importRouteCard(backupPath: path);
                          Navigator.pop(context);
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text(TEMPLATE_HOME_TEXT),
                      enabled: routeCards.any((route) => route.name == TEMPLATE_HOME_TITLE) ? false : true,
                      onTap: () async {
                        loadTemplates(TEMPLATE_HOME).then((path) {
                          ref
                              .read(routeCardControllerProvider.notifier)
                              .importRouteCard(backupPath: path);
                          Navigator.pop(context);
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.map),
                      title: const Text(TEMPLATE_FLENI_TEXT),
                      enabled: routeCards.any((route) => route.name == TEMPLATE_FLENI_TITLE) ? false : true,
                      onTap: () async {
                        loadTemplates(TEMPLATE_FLENI).then((path) {
                          ref
                              .read(routeCardControllerProvider.notifier)
                              .importRouteCard(backupPath: path);
                          Navigator.pop(context);
                        });
                      },
                    ),
                    const Divider(
                      height: 40,
                      color: Colors.black12,
                    ),
                    ListTile(
                      leading: const Icon(Icons.folder),
                      title: const Text(IMPORT_TEMPLATE_TEXT),
                      onTap: () async {
                        Directory? directory =
                            await getExternalStorageDirectory();
                        FilePicker.platform
                            .pickFiles(
                          initialDirectory: directory!.path,
                          type: FileType.any,
                        )
                            .then(
                          (result) {
                            if (result != null &&
                                result.files.single.extension == DB_EXTENSION) {
                              File file = File(result.files.single.path!);
                              ref.read(routeCardControllerProvider.notifier).importRouteCard(backupPath: file.path);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    IMPORT_TEMPLATE_ERROR,
                                  ),
                                ),
                              );
                            }
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
