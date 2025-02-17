//Flutter imports:
import 'package:flutter/material.dart';

//Package imports:
import 'package:mvc_pattern/mvc_pattern.dart';

//Project imports:
import '../../../utils/k_texts.dart';
import '../../../utils/page_args.dart';
import '../../interfaces/i_page_controller.dart';
import '../../managers/data_manager.dart';
import '../../managers/page_manager.dart';
import '../../models/user_model.dart';
import '../popups/alert_popup.dart';
import '../popups/loading_popup.dart';

class SignInPageController extends ControllerMVC implements IPageController {
  static late SignInPageController _this;

  factory SignInPageController() {
    _this = SignInPageController._();
    return _this;
  }

  static SignInPageController get con => _this;
  SignInPageController._();

  PageArgs? args;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  late FocusNode emailFocus;
  late FocusNode passwordFocus;

  bool showPassword = false;

  @override
  void initPage() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    emailFocus = FocusNode();
    passwordFocus = FocusNode();
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

  void onTapShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void onTapSignIn() async {
    await LoadingPopup(
      context: PageManager().currentContext,
      onLoading: DataManager().signIn(
        emailController.text,
        passwordController.text,
      ),
      onError: (error) {
        AlertPopup(
          context: PageManager().currentContext,
          title: kTextTitleError,
          description: error.toString(),
        ).show();
      },
      onResult: (UserModel? user) {
        if (user != null) {
          PageManager().goHomePage();
        }
      },
    ).show();
  }

  void onTapSignInWithGoogle() async {
    await LoadingPopup(
      context: PageManager().currentContext,
      onLoading: DataManager().signInWithGoogle(),
      onError: (error) {
        AlertPopup(
          context: PageManager().currentContext,
          title: kTextTitleError,
          description: error.toString(),
        ).show();
      },
      onResult: (UserModel? user) {
        if (user != null) {
          PageManager().goHomePage();
        }
      },
    ).show();
  }

  void onTapSignUp() {
    PageManager().goSignUpPage();
  }
}
