import 'package:mvc_pattern/mvc_pattern.dart';
import '../../interfaces/i_page_controller.dart';
import '../../../utils/page_args.dart';

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
