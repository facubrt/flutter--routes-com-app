import 'package:routescom/core/constants/constants.dart';
import 'package:routescom/src/customisation/application/services/customisation_service.dart';
import 'package:routescom/src/customisation/domain/entities/app_parameters.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'customisation_controller.g.dart';

@Riverpod(keepAlive: true)
class CustomisationController extends _$CustomisationController {
  final CustomisationService customisationService = CustomisationService();

  @override
  AppParameters build() => CustomisationService().appParameters;

  Future<AppParameters> getAppParameters() async {
    return customisationService.getAppParameters();
  }

  Future<bool> setHighContrast({required bool highContrast}) async {
    final AppParameters parameters = AppParameters(
      highContrast: highContrast,
      factorSize: state.factorSize,
      factorText: state.factorText, 
      editMode: state.editMode,
      rows: state.rows,
      
    );
    state = parameters;
    return customisationService.setAppParameters(parameters);
  }

  Future<bool> setFactorText(
      {required double size, required String factorText}) async {
    final double factorSize = factorText == FACTOR_TEXT_SMALL
        ? size > MEDIUM_SCREEN_SIZE
            ? 0.03
            : 0.054
        : factorText == FACTOR_TEXT_DEFAULT
            ? size > MEDIUM_SCREEN_SIZE
                ? 0.036
                : 0.06
            : size > MEDIUM_SCREEN_SIZE
                ? 0.04
                : 0.08;

    final AppParameters parameters = AppParameters(
      highContrast: state.highContrast,
      factorSize: factorSize,
      factorText: factorText,
      editMode: state.editMode,
      rows: state.rows,
    );

    state = parameters;
    return customisationService.setAppParameters(parameters);
  }

  Future<bool> setRows({required int rows}) async {
    final AppParameters parameters = AppParameters(
      highContrast: state.highContrast,
      factorSize: state.factorSize,
      factorText: state.factorText, 
      editMode: state.editMode,
      rows: rows,
    );

    state = parameters;
    return customisationService.setAppParameters(parameters); 
  }

  Future<bool> setEditMode({required bool editMode}) async {
    final AppParameters parameters = AppParameters(
      highContrast: state.highContrast,
      factorSize: state.factorSize,
      factorText: state.factorText, 
      editMode: editMode,
      rows: state.rows,
    );

    state = parameters;
    return customisationService.setAppParameters(parameters);
  }

  Future<bool> setAppParameters(AppParameters parameters) async {
    return customisationService.setAppParameters(parameters);
  }

  Future<bool> clearAppParameters() async {
    return customisationService.clearAppParameters();
  }
}
