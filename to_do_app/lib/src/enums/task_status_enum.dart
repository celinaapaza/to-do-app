import 'package:to_do_app/utils/k_texts.dart';

enum TaskStatusEnum { pending, completed }

extension ExtensionTaskStatus on TaskStatusEnum {
  static Map<TaskStatusEnum, Map<String, dynamic>> types = {
    TaskStatusEnum.pending: {"id": 1, "label": kTextPending},
    TaskStatusEnum.completed: {"id": 2, "label": kTextCompleted},
  };

  int get id => types[this]!["id"] as int;
  String get label => types[this]!["label"] as String;
}
