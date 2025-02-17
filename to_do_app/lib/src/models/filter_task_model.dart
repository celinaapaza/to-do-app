//Flutter imports:
import 'package:flutter/material.dart';

//Project imports:
import '../../utils/k_texts.dart';
import '../enums/task_order_type_enum.dart';
import '../enums/task_priority_enum.dart';
import '../enums/task_status_enum.dart';

class FilterTaskModel {
  TaskSortTypeEnum? taskSortType;

  List<TaskPriorityEnum> taskPrioritiesSelected = [];
  List<TaskStatusEnum> taskStatusSelected = [];

  FilterTaskModel({
    this.taskSortType,
    this.taskPrioritiesSelected = const [],
    this.taskStatusSelected = const [],
  });

  int get totalFilterApplied =>
      taskPrioritiesSelected.length + taskStatusSelected.length;

  IconData get orderIcon =>
      taskSortType == TaskSortTypeEnum.ascendingPriority ||
              taskSortType == TaskSortTypeEnum.oldestExpirationDate
          ? Icons.keyboard_arrow_up_rounded
          : Icons.keyboard_arrow_down_rounded;

  String get orderLabel =>
      taskSortType == TaskSortTypeEnum.latestExpirationDate ||
              taskSortType == TaskSortTypeEnum.oldestExpirationDate
          ? kTextExpirationDateLarge
          : kTextPriority;
}
