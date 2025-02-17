//Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

//Project imports:
import '../../../utils/k_texts.dart';
import '../../../utils/page_args.dart';
import '../../enums/task_order_type_enum.dart';
import '../../interfaces/i_page_controller.dart';
import '../../managers/data_manager.dart';
import '../../managers/page_manager.dart';
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
      taskOrderType: TaskOrderTypeEnum.expirationDate,
      ascendingOrder: false,
      taskPrioritiesSelected: [],
      taskStatusSelected: [],
    );

    streamTasks = DataManager().getListTask();
  }

  @override
  disposePage() {}

  @override
  onReceiveNotification(PageArgs? args) {}

  void onPopInvoked(didPop, result) {
    if (didPop) return;
    //TODO: salir de la app??
  }

  String get userEmail => DataManager().getUserPrefs()?.email ?? "-";

  void onSnapshotData(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      tasks = List<TaskModel>.from(
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          TaskModel newTask = TaskModel.fromJson(data);
          newTask.uid = document.id;
          return newTask;
        }).toList(),
      );
    }
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
          title: kTextTitleError,
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
