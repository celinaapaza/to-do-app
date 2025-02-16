enum TaskPriorityEnum { high, medium, low }

extension Extensionname on TaskPriorityEnum {
  static Map<TaskPriorityEnum, Map<String, dynamic>> types = {
    TaskPriorityEnum.high: {"id": 1},
    TaskPriorityEnum.medium: {"id": 2},
    TaskPriorityEnum.low: {"id": 3},
  };

  int get id => types[this]!["id"] as int;
}
