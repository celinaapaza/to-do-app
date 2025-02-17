//Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

//Project imports:
import '../../../utils/k_texts.dart';
import '../../../utils/page_args.dart';
import '../../enums/task_order_type_enum.dart';
import '../../enums/task_priority_enum.dart';
import '../../enums/task_status_enum.dart';
import '../../interfaces/i_page_controller.dart';
import '../../managers/data_manager.dart';
import '../../managers/notifications_manager.dart';
import '../../managers/page_manager/page_manager.dart';
import '../../models/filter_task_model.dart';
import '../../models/task_model.dart';
import '../../providers/theme_data_provider.dart';
import '../popups/alert_popup.dart';
import '../popups/loading_popup.dart';

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
  List<TaskModel> tasks = [];

  Stream<QuerySnapshot>? streamTasks;

  @override
  void initPage() {
    filter = FilterTaskModel(
      taskSortType: TaskSortTypeEnum.oldestExpirationDate,
      taskPrioritiesSelected: [],
      taskStatusSelected: [],
    );

    streamTasks = DataManager().getListTask();

    NotificationsManager().requestPermissions();
  }

  @override
  disposePage() {}

  @override
  onReceiveNotification(PageArgs? args) {}

  void onPopInvoked(didPop, result) {
    if (didPop) return;

    AlertPopup(
      context: PageManager().currentContext,
      title: kTextExitAppTitle,
      description: kTextExitAppDescription,
      onAcceptPressed: () {
        PageManager().closeApp();
      },
    ).show();
  }

  String get userEmail => DataManager().getUserPrefs()?.email ?? "-";

  void onSnapshotData(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      List<TaskModel> newList = List<TaskModel>.from(
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          TaskModel newTask = TaskModel.fromJson(data);
          newTask.uid = document.id;
          return newTask;
        }).toList(),
      );

      tasks = _sortTasks(_filterTasks(newList));
    }
  }

  void onTapSortButton() {
    PageManager().openSortTaskBottomSheet(
      taskSortInit:
          filter.taskSortType ?? TaskSortTypeEnum.oldestExpirationDate,
      onSelectedTaskSort: (TaskSortTypeEnum newTaskSort) {
        Navigator.pop(PageManager().currentContext);
        setState(() {
          filter.taskSortType = newTaskSort;
        });
      },
    );
  }

  List<TaskModel> _sortTasks(List<TaskModel> list) {
    try {
      switch (filter.taskSortType) {
        case TaskSortTypeEnum.oldestExpirationDate:
          list.sort((a, b) => a.expirationDate!.compareTo(b.expirationDate!));
          break;
        case TaskSortTypeEnum.latestExpirationDate:
          list.sort((a, b) => b.expirationDate!.compareTo(a.expirationDate!));
          break;
        case TaskSortTypeEnum.descendingPriority:
          list.sort((a, b) => a.taskPriority!.id.compareTo(b.taskPriority!.id));
          break;
        case TaskSortTypeEnum.ascendingPriority:
          list.sort((a, b) => b.taskPriority!.id.compareTo(a.taskPriority!.id));
          break;
        default:
          break;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return list;
  }

  void onTapFilterButton() async {
    await PageManager().openFilterTaskBottomSheet(filterTask: filter);

    setState(() {
      //TO UPDATE TASKS
    });
  }

  List<TaskModel> _filterTasks(List<TaskModel> list) {
    if (filter.taskStatusSelected.isEmpty &&
        filter.taskPrioritiesSelected.isEmpty) {
      return list;
    }

    List<TaskModel> filteredTasks =
        list.where((task) {
          for (TaskStatusEnum status in filter.taskStatusSelected) {
            if (status.isCompleted == task.isCompleted) {
              return true;
            }
          }

          for (TaskPriorityEnum priority in filter.taskPrioritiesSelected) {
            if (priority.id == task.taskPriority!.id) {
              return true;
            }
          }

          return false;
        }).toList();

    return filteredTasks;
  }

  void onTapTaskCheckBox(TaskModel task, bool newValue) async {
    task.isCompleted = newValue;
    try {
      await DataManager().updateTask(task);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onTapTask(TaskModel selectedTask) {
    PageManager().goTaskDetailPage(args: PageArgs(task: selectedTask));
  }

  void onTapFab() {
    PageManager().goCreateOrEditTaskPage();
  }

  void onTapSwitchTheme() {
    ThemeDataProvider().setDarkMode(!ThemeDataProvider().darkMode);
    DataManager().setDarkMode(ThemeDataProvider().darkMode);
  }

  void onTapLogout() async {
    await LoadingPopup(
      context: PageManager().currentContext,
      onLoading: DataManager().logout(),
      onError: (error) {
        AlertPopup(
          context: PageManager().currentContext,
          title: kTextErrorTitle,
          description: error.toString(),
        ).show();
      },
      onResult: (bool? result) {
        if (result == true) {
          PageManager().goSignInPage();
        }
      },
    ).show();
  }
}
