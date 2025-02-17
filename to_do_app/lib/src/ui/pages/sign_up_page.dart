//Flutter imports:
import 'package:flutter/material.dart';

//Package imports:
import 'package:mvc_pattern/mvc_pattern.dart';

//Project imports:
import '../../../utils/k_assets.dart';
import '../../../utils/k_colors.dart';
import '../../../utils/k_texts.dart';
import '../components/custom_button_component.dart';
import '../components/text_field_component.dart';
import '../page_controllers/sign_up_page_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends StateMVC<SignUpPage> {
  late SignUpPageController _con;

  SignUpPageState() : super(SignUpPageController()) {
    _con = SignUpPageController.con;
  }

  @override
  void initState() {
    _con.initPage();
    super.initState();
  }

  @override
  void dispose() {
    _con.disposePage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _con.onPopInvoked,
      child: SafeArea(child: Scaffold(body: _body())),
    );
  }

  Widget _body() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(kAssetsIconApp, height: 70, fit: BoxFit.contain),
              const SizedBox(height: 10),
              const Text(
                kTextTitleHome,
                style: TextStyle(
                  color: kColorPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 40),
              TextFieldComponent(
                controller: _con.emailController,
                focusNode: _con.emailFocus,
                hintText: kTextEmail,
                error: _con.emailError,
                labelError: _con.emailLabelError,
                onTapOutside: (_) {
                  if (_con.emailFocus.hasFocus) {
                    _con.emailFocus.unfocus();
                  }
                },
              ),
              const SizedBox(height: 20),
              TextFieldComponent(
                controller: _con.passwordController,
                focusNode: _con.passwordFocus,
                hintText: kTextPassword,
                obscureText: !_con.showPassword,
                suffixIcon: _suffixIconPassword(),
                error: _con.passwordError,
                labelError: _con.passwordLabelError,
                onTapOutside: (_) {
                  if (_con.passwordFocus.hasFocus) {
                    _con.passwordFocus.unfocus();
                  }
                },
              ),
              const SizedBox(height: 20),
              TextFieldComponent(
                controller: _con.repeatPasswordController,
                focusNode: _con.repeatPasswordFocus,
                hintText: kTextRepeatPassword,
                obscureText: !_con.showPassword,
                suffixIcon: _suffixIconPassword(),
                error: _con.repeatPasswordError,
                labelError: _con.repeatPasswordLabelError,
                onTapOutside: (_) {
                  if (_con.repeatPasswordFocus.hasFocus) {
                    _con.repeatPasswordFocus.unfocus();
                  }
                },
              ),
              const SizedBox(height: 40),
              customButtonComponent(
                context,
                kTextSignUp,
                Icons.person_add_alt_outlined,
                kColorBlue,
                _con.onTapSignUp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _suffixIconPassword() {
    return GestureDetector(
      onTap: () {
        _con.onTapShowPassword();
      },
      child: Icon(_con.showPassword ? Icons.visibility : Icons.visibility_off),
    );
  }
}
