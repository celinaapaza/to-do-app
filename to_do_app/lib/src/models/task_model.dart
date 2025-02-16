//Project imports:
import 'package:collection/collection.dart';

import '../enums/task_priority_enum.dart';
import '../../utils/function_utils.dart';

class TaskModel {
  int? taskId;
  String? title;
  String? description;
  DateTime? expirationDate;
  bool isCompleted = false;
  int? _taskPriorityId;

  TaskModel({
    this.taskId,
    this.title,
    this.description,
    this.expirationDate,
    this.isCompleted = false,
    int? taskPriorityId,
  }) {
    _taskPriorityId = taskPriorityId;
  }

  TaskModel.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    title = json['title'];
    description = json['description'];
    expirationDate = dateTimeTryParse(json['expirationDate']);
    isCompleted = json['isCompleted'] == true;
    _taskPriorityId = json['taskPriorityId'];
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'expirationDate': expirationDate?.toString(),
    'isCompleted': isCompleted,
    'taskPriorityId': _taskPriorityId,
  };

  TaskPriorityEnum? get taskPriority => TaskPriorityEnum.values
      .firstWhereOrNull((element) => element.id == _taskPriorityId);

  String expirationDateFormat() {
    return getFormattedDate(expirationDate);
  }

  String expirtaionTimeFormat() {
    return getFormattedTime(expirationDate);
  }
}
