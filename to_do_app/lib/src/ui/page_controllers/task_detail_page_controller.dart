//Package imports:
import 'package:mvc_pattern/mvc_pattern.dart';

//Project imports:
import '../../../utils/page_args.dart';
import '../../interfaces/i_page_controller.dart';
import '../../managers/page_manager.dart';
import '../../models/task_model.dart';

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

  @override
  void initPage() {
    args = PageManager().currentRoute?.settings.arguments as PageArgs?;
    task = args?.task;
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

  void onTapEdit() {
    PageManager().goCreateOrEditTaskPage(args: PageArgs(task: task));
  }

  void onTapDelete() {
    //TODO: delete item
  }
}
