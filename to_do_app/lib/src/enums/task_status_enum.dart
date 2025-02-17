//Project imports:
import '../../utils/k_texts.dart';

enum TaskStatusEnum { pending, completed }

extension ExtensionTaskStatus on TaskStatusEnum {
  static Map<TaskStatusEnum, Map<String, dynamic>> types = {
    TaskStatusEnum.pending: {
      "id": 1,
      "label": kTextPending,
      "isCompleted": false,
    },
    TaskStatusEnum.completed: {
      "id": 2,
      "label": kTextCompleted,
      "isCompleted": true,
    },
  };

  int get id => types[this]!["id"] as int;
  String get label => types[this]!["label"] as String;
  bool get isCompleted => types[this]!["isCompleted"] as bool;
}
