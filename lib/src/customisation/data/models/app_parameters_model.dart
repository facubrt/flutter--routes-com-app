import 'package:routescom/core/constants/constants.dart';
import 'package:routescom/src/customisation/domain/entities/app_parameters.dart';

class AppParametersModel extends AppParameters {
  AppParametersModel(
      {required super.factorSize,
      required super.factorText,
      required super.highContrast, 
      required super.editMode, 
      required super.rows,
    });

  static AppParametersModel empty = AppParametersModel(
    factorSize: 0.06,
    factorText: FACTOR_TEXT_DEFAULT,
    highContrast: false,
    editMode: false,
    rows: 2,
  );

  AppParametersModel copyWith({
    double? factorSize,
    String? factorText,
    String? keyboardStyle,
    bool? highContrast,
    bool? editMode,
    int? rows,
  }) =>
      AppParametersModel(
          factorSize: factorSize ?? this.factorSize,
          factorText: factorText ?? this.factorText,
          highContrast: highContrast ?? this.highContrast, 
          editMode: editMode ?? this.editMode,
          rows: rows ?? this.rows
          );

  Map<dynamic, dynamic> toJson() => {
        'factorSize': factorSize,
        'factorText': factorText,
        'highContrast': highContrast,
        'editMode': editMode,
        'rows': rows
      };

  factory AppParametersModel.fromJson(Map<dynamic, dynamic> json) =>
      AppParametersModel(
        factorSize: json['factorSize'],
        factorText: json['factorText'],
        highContrast: json['highContrast'],
        editMode: json['editMode'],
        rows: json['rows'],
      );

  factory AppParametersModel.fromEntity(AppParameters entity) =>
      AppParametersModel(
        factorSize: entity.factorSize,
        factorText: entity.factorText,
        highContrast: entity.highContrast,
        editMode: entity.editMode,
        rows: entity.rows,
      );
}
