//Package imports:
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:to_do_app/src/managers/data_manager.dart';
import 'package:to_do_app/src/providers/theme_data_provider.dart';

//Project imports:
import '../../../utils/page_args.dart';
import '../../enums/task_order_type_enum.dart';
import '../../interfaces/i_page_controller.dart';
import '../../models/filter_task_model.dart';
import '../../models/task_model.dart';

class HomePageController extends ControllerMVC implements IPageController {
  static late HomePageController _this;

  factory HomePageController() {
    _this = HomePageController._();
    return _this;
  }

  static HomePageController get con => _this;
  HomePageController._();

  PageArgs? args;

  late FilterTaskModel filter;

  @override
  void initPage() {
    filter = FilterTaskModel(
      taskOrderType: TaskOrderTypeEnum.expirationDate,
      ascendingOrder: false,
      taskPrioritiesSelected: [],
      taskStatusSelected: [],
    );
  }

  @override
  disposePage() {}

  @override
  onReceiveNotification(PageArgs? args) {}

  void onPopInvoked(didPop, result) {
    if (didPop) return;
  }

  void onTapTaskCheckBox(TaskModel task, bool newValue) {
    setState(() {
      task.isCompleted = newValue;
    });
  }

  void onTapSwitchTheme() {
    ThemeDataProvider().setDarkMode(!ThemeDataProvider().darkMode);
    DataManager().setDarkMode(ThemeDataProvider().darkMode);
  }

  List<TaskModel> tasks = [
    TaskModel(
      taskId: 1,
      title: 'Task 1',
      description: 'Description 1',
      expirationDate: DateTime.now().add(Duration(days: 1)),
      isCompleted: false,
      taskPriorityId: 1,
    ),
    TaskModel(
      taskId: 2,
      title: 'Task 2',
      description: 'Description 2',
      expirationDate: DateTime.now().subtract(Duration(days: 2)),
      isCompleted: true,
      taskPriorityId: 2,
    ),
    TaskModel(
      taskId: 3,
      title: 'Task 3',
      description: 'Description 3',
      expirationDate: DateTime.now().subtract(Duration(days: 3)),
      isCompleted: false,
      taskPriorityId: 3,
    ),
    TaskModel(
      taskId: 4,
      title: 'Task 4',
      description: 'Description 4',
      expirationDate: DateTime.now().add(Duration(days: 4)),
      isCompleted: true,
      taskPriorityId: 1,
    ),
    TaskModel(
      taskId: 5,
      title: 'Task 5',
      description: 'Description 5',
      expirationDate: DateTime.now().add(Duration(days: 5)),
      isCompleted: false,
      taskPriorityId: 2,
    ),
    TaskModel(
      taskId: 6,
      title: 'Task 6',
      description: 'Description 6',
      expirationDate: DateTime.now().subtract(Duration(days: 6)),
      isCompleted: true,
      taskPriorityId: 3,
    ),
    TaskModel(
      taskId: 7,
      title: 'Task 7',
      description: 'Description 7',
      expirationDate: DateTime.now().add(Duration(days: 7)),
      isCompleted: false,
      taskPriorityId: 1,
    ),
    TaskModel(
      taskId: 8,
      title: 'Task 8',
      description: 'Description 8',
      expirationDate: DateTime.now().add(Duration(days: 8)),
      isCompleted: true,
      taskPriorityId: 2,
    ),
    TaskModel(
      taskId: 9,
      title: 'Task 9',
      description: 'Description 9',
      expirationDate: DateTime.now().add(Duration(days: 9)),
      isCompleted: false,
      taskPriorityId: 3,
    ),
    TaskModel(
      taskId: 10,
      title: 'Task 10',
      description: 'Description 10',
      expirationDate: DateTime.now().add(Duration(days: 10)),
      isCompleted: true,
      taskPriorityId: 1,
    ),
    TaskModel(
      taskId: 11,
      title: 'Task 11',
      description: 'Description 11',
      expirationDate: DateTime.now().add(Duration(days: 11)),
      isCompleted: false,
      taskPriorityId: 2,
    ),
    TaskModel(
      taskId: 12,
      title: 'Task 12',
      description: 'Description 12',
      expirationDate: DateTime.now().add(Duration(days: 12)),
      isCompleted: true,
      taskPriorityId: 3,
    ),
    TaskModel(
      taskId: 13,
      title: 'Task 13',
      description: 'Description 13',
      expirationDate: DateTime.now().add(Duration(days: 13)),
      isCompleted: false,
      taskPriorityId: 1,
    ),
    TaskModel(
      taskId: 14,
      title: 'Task 14',
      description: 'Description 14',
      expirationDate: DateTime.now().add(Duration(days: 14)),
      isCompleted: true,
      taskPriorityId: 2,
    ),
    TaskModel(
      taskId: 15,
      title: 'Task 15',
      description: 'Description 15',
      expirationDate: DateTime.now().add(Duration(days: 15)),
      isCompleted: false,
      taskPriorityId: 3,
    ),
  ];
}
