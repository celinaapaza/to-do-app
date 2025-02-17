//Package imports:
import 'package:mvc_pattern/mvc_pattern.dart';

//Project imports:
import '../../managers/data_manager.dart';
import '../../managers/notifications_manager.dart';
import '../../managers/page_manager/page_manager.dart';
import '../../interfaces/i_page_controller.dart';
import '../../../utils/page_args.dart';

class InitPageController extends ControllerMVC implements IPageController {
  static late InitPageController _this;

  factory InitPageController() {
    _this = InitPageController._();
    return _this;
  }

  static InitPageController get con => _this;
  InitPageController._();

  PageArgs? args;

  bool hasSession = false;

  @override
  void initPage() {}

  @override
  disposePage() {}

  @override
  onReceiveNotification(PageArgs? args) {}

  Future<void> initApp() async {
    DataManager().init();
    hasSession = await DataManager().hasSession();
    // await NotificationsManager().init();

    await Future.delayed(const Duration(seconds: 2));

    goInitialPage();
  }

  void goInitialPage() {
    if (hasSession) {
      PageManager().goHomePage();
    } else {
      PageManager().goSignInPage();
    }
  }
}
