import 'package:mvc_pattern/mvc_pattern.dart';
import '../../interfaces/i_page_controller.dart';
import '../../../utils/page_args.dart';

class TaskDetailPageController extends ControllerMVC implements IPageController {
  static late TaskDetailPageController _this;

  factory TaskDetailPageController() {
    _this = TaskDetailPageController._();
    return _this;
  }

  static TaskDetailPageController get con => _this;
  TaskDetailPageController._();

  PageArgs? args;

  @override
  void initPage() {}

  @override
  disposePage() {}

  @override
  onReceiveNotification(PageArgs? args) {}

  void onPopInvoked(didPop) {
    if (didPop) return;
    // ADD CODE >>>>>>

    // <<<<<<<<<<<<<<<
  }
}
  