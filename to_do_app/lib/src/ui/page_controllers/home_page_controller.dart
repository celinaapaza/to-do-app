import 'package:mvc_pattern/mvc_pattern.dart';
import '../../interfaces/i_page_controller.dart';
import '../../../utils/page_args.dart';

class HomePageController extends ControllerMVC implements IPageController {
  static late HomePageController _this;

  factory HomePageController() {
    _this = HomePageController._();
    return _this;
  }

  static HomePageController get con => _this;
  HomePageController._();

  PageArgs? args;

  @override
  void initPage() {}

  @override
  disposePage() {}

  @override
  onReceiveNotification(PageArgs? args) {}

  void onPopInvoked(didPop, result) {
    if (didPop) return;
  }
}
