import 'package:to_do_app/utils/k_texts.dart';

enum TaskOrderTypeEnum { expirationDate, priority }

extension ExtensionTaskOrderType on TaskOrderTypeEnum {
  static Map<TaskOrderTypeEnum, Map<String, dynamic>> types = {
    TaskOrderTypeEnum.expirationDate: {
      "id": 1,
      "label": kTextExpirationDateLarge,
    },
    TaskOrderTypeEnum.priority: {"id": 2, "label": kTextPriority},
  };

  int get id => types[this]!["id"] as int;
  String get label => types[this]!["label"] as String;
}
