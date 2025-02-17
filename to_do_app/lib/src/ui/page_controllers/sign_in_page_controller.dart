//Flutter imports:
import 'package:flutter/material.dart';

//Package imports:
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

//Project imports:
import '../../../utils/k_texts.dart';
import '../../../utils/k_values.dart';
import '../../../utils/page_args.dart';
import '../../enums/firebase_error_code_enum.dart';
import '../../interfaces/i_page_controller.dart';
import '../../managers/data_manager.dart';
import '../../managers/page_manager/page_manager.dart';
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

  bool emailError = false;
  bool passwordError = false;

  String emailLabelError = "";
  String passwordLabelError = "";

  bool showPassword = false;

  @override
  void initPage() {
    emailController =
        TextEditingController()..addListener(() {
          if (emailError) {
            setState(() {
              emailError = false;
              emailLabelError = "";
            });
          }
        });

    passwordController =
        TextEditingController()..addListener(() {
          if (passwordError) {
            setState(() {
              passwordError = false;
              passwordLabelError = "";
            });
          }
        });

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
    _validateEmail();
    _validatePassword();

    if (emailError || passwordError) {
      setState(() {});
      return;
    }

    await LoadingPopup(
      context: PageManager().currentContext,
      onLoading: DataManager().signIn(
        emailController.text,
        passwordController.text,
      ),
      onError: _onErrorSignIn,
      onResult: (UserModel? user) {
        if (user != null) {
          PageManager().goHomePage();
        }
      },
    ).show();
  }

  void _validateEmail() {
    emailError = false;
    if (emailController.text.isEmpty) {
      emailLabelError = kTextRequiredField;
      emailError = true;
      return;
    }

    if (!regExpEmail.hasMatch(emailController.text)) {
      emailLabelError = kTextInvalidEmail;
      emailError = true;
      return;
    }
  }

  void _validatePassword() {
    passwordError = false;

    if (passwordController.text.isEmpty) {
      passwordLabelError = kTextRequiredField;
      passwordError = true;
      return;
    }
  }

  void _onErrorSignIn(dynamic error) {
    if (error is FirebaseAuthException) {
      FirebaseErrorCodeEnum? result = FirebaseErrorCodeEnum.values
          .firstWhereOrNull((element) => element.code == error.code);

      switch (result) {
        case FirebaseErrorCodeEnum.invalidEmail:
          setState(() {
            emailError = true;
            emailLabelError = kTextInvalidEmail;
          });
        case FirebaseErrorCodeEnum.userDisabled:
          AlertPopup(
            context: PageManager().currentContext,
            title: kTextErrorUserDisbledTitle,
            description: kTextErrorUserDisbledDescription,
          ).show();
          break;
        case FirebaseErrorCodeEnum.userNotFound:
          setState(() {
            emailError = true;
            emailLabelError = kTextUserNotFound;
          });
        case FirebaseErrorCodeEnum.wrongPassword:
          setState(() {
            passwordError = true;
            passwordLabelError = kTextWrongPassword;
          });
        case FirebaseErrorCodeEnum.networkRequestFailed:
          AlertPopup(
            context: PageManager().currentContext,
            title: kTextErrorNetworkTitle,
            description: kTextErrorNetworkDescription,
          ).show();
          break;
        case FirebaseErrorCodeEnum.invalidCredential:
          AlertPopup(
            context: PageManager().currentContext,
            title: kTextInvalidCredentialTitle,
            description: kTextErrorInvalidCredentialDescription,
          ).show();
          break;
        default:
          AlertPopup(
            context: PageManager().currentContext,
            title: kTextErrorTitle,
            description: kTextErrorDescription,
          ).show();
          break;
      }
      return;
    }
    AlertPopup(
      context: PageManager().currentContext,
      title: kTextErrorTitle,
      description: kTextErrorDescription,
    ).show();
  }

  void onTapSignInWithGoogle() async {
    await LoadingPopup(
      context: PageManager().currentContext,
      onLoading: DataManager().signInWithGoogle(),
      onError: (error) {
        AlertPopup(
          context: PageManager().currentContext,
          title: kTextErrorTitle,
          description: kTextErrorDescription,
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
