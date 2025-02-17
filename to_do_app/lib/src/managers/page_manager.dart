//Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/src/ui/pages/init_page.dart';

//Project imports:
import '../../utils/page_args.dart';
import '../enums/page_names_enum.dart';
import '../interfaces/i_page_controller.dart';
import '../ui/page_controllers/create_or_edit_task_page_controller.dart';
import '../ui/page_controllers/home_page_controller.dart';
import '../ui/page_controllers/init_page_controller.dart';
import '../ui/page_controllers/sign_in_page_controller.dart';
import '../ui/page_controllers/sign_up_page_controller.dart';
import '../ui/page_controllers/task_detail_page_controller.dart';
import '../ui/pages/create_or_edit_task_page.dart';
import '../ui/pages/home_page.dart';
import '../ui/pages/sign_in_page.dart';
import '../ui/pages/sign_up_page.dart';
import '../ui/pages/task_detail_page.dart';

class PageManager {
  static final PageManager _instance = PageManager._constructor();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory PageManager() {
    return _instance;
  }

  PageManager._constructor();

  BuildContext get currentContext => navigatorKey.currentState!.context;

  Route<dynamic>? get currentRoute {
    Route<dynamic>? currentRoute;

    navigatorKey.currentState!.popUntil((route) {
      currentRoute = route;
      return true;
    });

    return currentRoute;
  }

  PageNames? get currentPage => currentRoute?.settings.name.pageNameEnum;

  MaterialPageRoute? getRoute(RouteSettings settings) {
    PageNames? page = settings.name.pageNameEnum;

    return MaterialPageRoute(
      builder: (context) => _getPage(page),
      settings: settings,
    );
  }

  Widget _getPage(PageNames? page) {
    switch (page) {
      case PageNames.signIn:
        return const SignInPage();
      case PageNames.signUp:
        return const SignUpPage();
      case PageNames.init:
        return const InitPage();
      case PageNames.home:
        return const HomePage();
      case PageNames.taskDetail:
        return const TaskDetailPage();
      case PageNames.creatOrEditTask:
        return const CreateOrEditTaskPage();
      default:
        return throw Exception("No existe página con este PageName");
    }
  }

  IPageController _getPageController(PageNames? page) {
    switch (page) {
      case PageNames.signIn:
        return SignInPageController();
      case PageNames.signUp:
        return SignUpPageController();
      case PageNames.init:
        return InitPageController();
      case PageNames.home:
        return HomePageController();
      case PageNames.taskDetail:
        return TaskDetailPageController();
      case PageNames.creatOrEditTask:
        return CreateOrEditTaskPageController();
      default:
        return throw Exception("No existe página con este PageName");
    }
  }

  _goPage(
    PageNames pageName, {
    PageArgs? args,
    Function(PageArgs? args)? actionBack,
    bool makeRootPage = false,
    bool replaceCurrentPage = false,
  }) {
    if (makeRootPage) {
      return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        pageName.name,
        (route) => false,
        arguments: args,
      );
    }

    if (replaceCurrentPage) {
      return navigatorKey.currentState!
          .pushReplacementNamed(pageName.name, arguments: args)
          .then((value) {
            if (actionBack != null) {
              actionBack(value != null ? (value as PageArgs) : null);
            }
          });
    }

    return navigatorKey.currentState!
        .pushNamed(pageName.name, arguments: args)
        .then((value) {
          if (actionBack != null) {
            actionBack(value != null ? (value as PageArgs) : null);
          }
        });
  }

  void goBack({PageArgs? args, PageNames? specificPage}) {
    if (specificPage != null) {
      navigatorKey.currentState!.popUntil((route) {
        PageNames? currentPage = route.settings.name.pageNameEnum;
        bool predicate =
            currentPage == specificPage || !navigatorKey.currentState!.canPop();
        return predicate;
      });
    } else {
      if (navigatorKey.currentState!.canPop()) {
        navigatorKey.currentState!.pop(args);
      } else {
        closeApp();
      }
    }
  }

  void closeApp() {
    SystemNavigator.pop();
  }

  void notifyCurrentPage(PageArgs? args) {
    _getPageController(currentPage).onReceiveNotification(args);
  }

  //#region Pages

  //NAV EXAMPLE:
  goSignInPage({PageArgs? args}) {
    _goPage(PageNames.signIn, args: args, makeRootPage: true);
  }

  goSignUpPage({PageArgs? args}) {
    _goPage(PageNames.signUp, args: args, makeRootPage: true);
  }

  goHomePage({PageArgs? args}) {
    _goPage(PageNames.home, args: args, makeRootPage: true);
  }

  goTaskDetailPage({PageArgs? args, Function(PageArgs? args)? actionBack}) {
    _goPage(
      PageNames.taskDetail,
      args: args,
      actionBack: actionBack,
      makeRootPage: false,
    );
  }

  goCreateOrEditTaskPage({
    PageArgs? args,
    Function(PageArgs? args)? actionBack,
  }) {
    _goPage(
      PageNames.creatOrEditTask,
      args: args,
      actionBack: actionBack,
      makeRootPage: false,
    );
  }
}
