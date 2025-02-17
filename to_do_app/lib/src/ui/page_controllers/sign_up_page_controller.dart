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

  bool emailError = false;
  bool passwordError = false;
  bool repeatPasswordError = false;

  String emailLabelError = "";
  String passwordLabelError = "";
  String repeatPasswordLabelError = "";

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

    repeatPasswordController =
        TextEditingController()..addListener(() {
          if (repeatPasswordError) {
            setState(() {
              repeatPasswordError = false;
              repeatPasswordLabelError = "";
            });
          }
        });

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
    _validateEmail();
    _validatePassword();
    _validateRepeatPassword();

    if (emailError || passwordError || repeatPasswordError) {
      setState(() {});
      return;
    }

    await LoadingPopup(
      context: PageManager().currentContext,
      onLoading: DataManager().signUp(
        emailController.text,
        passwordController.text,
      ),
      onError: _onErrorSignUp,
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

    if (passwordController.text.length < minLengthPassword) {
      passwordLabelError = kTextErrorLengthPassword;
      passwordError = true;
      return;
    }
  }

  void _validateRepeatPassword() {
    repeatPasswordError = false;

    if (repeatPasswordController.text.isEmpty) {
      repeatPasswordLabelError = kTextRequiredField;
      repeatPasswordError = true;
      return;
    }

    if (repeatPasswordController.text != passwordController.text) {
      repeatPasswordLabelError = kTextErrorNotMatchPasswords;
      repeatPasswordError = true;
      return;
    }
  }

  void _onErrorSignUp(dynamic error) {
    if (error is FirebaseAuthException) {
      FirebaseErrorCodeEnum? result = FirebaseErrorCodeEnum.values
          .firstWhereOrNull((element) => element.code == error.code);

      switch (result) {
        case FirebaseErrorCodeEnum.invalidEmail:
          setState(() {
            emailError = true;
            emailLabelError = kTextInvalidEmail;
          });

        case FirebaseErrorCodeEnum.emailAlreadyInUse:
          setState(() {
            emailError = true;
            emailLabelError = kTextErrrorEmailAlreadyUse;
          });
        case FirebaseErrorCodeEnum.weakPassword:
          setState(() {
            passwordError = true;
            passwordLabelError = kTextErrorLengthPassword;
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
}
