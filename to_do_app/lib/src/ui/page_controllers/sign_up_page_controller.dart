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

class SignUpPageController extends ControllerMVC implements IPageController {
  static late SignUpPageController _this;

  factory SignUpPageController() {
    _this = SignUpPageController._();
    return _this;
  }

  static SignUpPageController get con => _this;
  SignUpPageController._();

  PageArgs? args;

  bool showPassword = false;

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;

  late FocusNode emailFocus;
  late FocusNode passwordFocus;
  late FocusNode repeatPasswordFocus;

  @override
  void initPage() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();

    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    repeatPasswordFocus = FocusNode();
  }

  @override
  disposePage() {}

  @override
  onReceiveNotification(PageArgs? args) {}

  void onPopInvoked(didPop, result) {
    if (didPop) return;
    onBack();
  }

  void onTapShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void onBack() {
    PageManager().goBack();
  }

  void onTapSignUp() async {
    await LoadingPopup(
      context: PageManager().currentContext,
      onLoading: DataManager().signUp(
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
}
