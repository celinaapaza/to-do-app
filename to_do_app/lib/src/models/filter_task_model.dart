//Project imports:
import '../enums/task_priority_enum.dart';
import '../enums/task_status_enum.dart';
import '../enums/task_order_type_enum.dart';

class FilterTaskModel {
  TaskOrderTypeEnum? taskOrderType;
  bool ascendingOrder = false;

  List<TaskPriorityEnum> taskPrioritiesSelected = [];
  List<TaskStatusEnum> taskStatusSelected = [];

  FilterTaskModel({
    this.taskOrderType,
    this.ascendingOrder = false,
    this.taskPrioritiesSelected = const [],
    this.taskStatusSelected = const [],
  });

  int get totalFilterApplied =>
      taskPrioritiesSelected.length + taskStatusSelected.length;
}
