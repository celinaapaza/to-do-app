//Flutter imports:
import 'package:flutter/widgets.dart';

//Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

//Project imports:
import '../../../utils/k_texts.dart';
import '../../../utils/page_args.dart';
import '../../interfaces/i_page_controller.dart';
import '../../managers/data_manager.dart';
import '../../managers/page_manager.dart';
import '../../models/task_model.dart';
import '../popups/alert_popup.dart';

class TaskDetailPageController extends ControllerMVC
    implements IPageController {
  static late TaskDetailPageController _this;

  factory TaskDetailPageController() {
    _this = TaskDetailPageController._();
    return _this;
  }

  static TaskDetailPageController get con => _this;
  TaskDetailPageController._();

  PageArgs? args;

  TaskModel? task;

  Stream<DocumentSnapshot>? streamTask;

  @override
  void initPage() {
    args = PageManager().currentRoute?.settings.arguments as PageArgs?;
    task = args?.task;

    if (task?.uid != null) {
      streamTask = DataManager().getTask(task!.uid!);
    }
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

  void onSnapshotData(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      Map<String, dynamic>? data =
          snapshot.data.data() as Map<String, dynamic>?;

      if (data != null) {
        task = TaskModel.fromJson(data);
        task?.uid = snapshot.data.id;
      }
    }
  }

  void onTapTaskCheckBox(bool newValue) async {
    if (task == null) return;

    task?.isCompleted = newValue;

    try {
      await DataManager().updateTask(task!);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onTapEdit() {
    PageManager().goCreateOrEditTaskPage(args: PageArgs(task: task));
  }

  void onTapDelete() async {
    AlertPopup(
      context: PageManager().currentContext,
      title: kTextDeleteTaskTitle,
      description: kTextDeleteTaskDescription,
      onAcceptPressed: () async {
        if (task?.uid == null) return;

        try {
          await DataManager().deleteTask(task!.uid!);
        } catch (e) {
          debugPrint(e.toString());
        }

        PageManager().goBack();
      },
    ).show();
  }
}
