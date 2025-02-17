//Package imports:
import 'package:collection/collection.dart';

//Project imports:
import '../enums/task_priority_enum.dart';
import '../../utils/function_utils.dart';

class TaskModel {
  String? uid;
  String? title;
  String? description;
  DateTime? expirationDate;
  bool isCompleted = false;
  int? _taskPriorityId;
  int? notificationId;

  TaskModel({
    this.uid,
    this.title,
    this.description,
    this.expirationDate,
    this.isCompleted = false,
    int? taskPriorityId,
    int? notificationId,
  }) {
    _taskPriorityId = taskPriorityId;
  }

  TaskModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    title = json['title'];
    description = json['description'];
    expirationDate = dateTimeTryParse(json['expirationDate']);
    isCompleted = json['isCompleted'] == true;
    _taskPriorityId = json['taskPriorityId'];
    notificationId = json['notificationId'];
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'expirationDate': expirationDate?.toString(),
    'isCompleted': isCompleted,
    'taskPriorityId': _taskPriorityId,
    'notificationId': notificationId,
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
