//Flutter imports:
import 'package:flutter/widgets.dart';

//Package imports:
import 'package:mvc_pattern/mvc_pattern.dart';

//Project imports:
import '../../../utils/page_args.dart';
import '../../enums/task_priority_enum.dart';
import '../../interfaces/i_page_controller.dart';
import '../../managers/page_manager.dart';
import '../../models/task_model.dart';

class CreateOrEditTaskPageController extends ControllerMVC
    implements IPageController {
  static late CreateOrEditTaskPageController _this;

  factory CreateOrEditTaskPageController() {
    _this = CreateOrEditTaskPageController._();
    return _this;
  }

  static CreateOrEditTaskPageController get con => _this;
  CreateOrEditTaskPageController._();

  PageArgs? args;

  TaskModel? initialTask;

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController dateController;
  late TextEditingController timeController;

  late FocusNode titleFocus;
  late FocusNode descriptionFocus;

  late TaskPriorityEnum prioritySelected;

  @override
  void initPage() {
    args = PageManager().currentRoute?.settings.arguments as PageArgs?;
    initialTask = args?.task;

    titleFocus = FocusNode();
    descriptionFocus = FocusNode();

    titleController = TextEditingController(text: initialTask?.title ?? '');

    descriptionController = TextEditingController(
      text: initialTask?.description ?? '',
    );

    dateController = TextEditingController(
      text: initialTask?.expirationDateFormat() ?? '',
    );

    timeController = TextEditingController(
      text: initialTask?.expirtaionTimeFormat() ?? '',
    );

    prioritySelected = initialTask?.taskPriority ?? TaskPriorityEnum.low;
  }

  @override
  disposePage() {}

  @override
  onReceiveNotification(PageArgs? args) {}

  void onPopInvoked(didPop, result) {
    if (didPop) return;
    onBack();
  }

  void onBack() {
    PageManager().goBack();
  }

  void onTapButton() {
    if (initialTask != null) {
      _updateTask();
      return;
    }

    _createTask();
  }

  void _updateTask() {}

  void _createTask() {}

  void onSelectHour() {}

  void onSelectDay() {}

  void onSelectPriority(TaskPriorityEnum newValue) {
    setState(() {
      prioritySelected = newValue;
    });
  }
}
