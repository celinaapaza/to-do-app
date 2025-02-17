// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../utils/k_colors.dart';
import '../components/futuristic.dart';

class LoadingPopup {
  final BuildContext context;
  final Color backgroundColor;
  final Future onLoading;
  Function? onResult;
  Function? onError;

  LoadingPopup({
    required this.context,
    required this.onLoading,
    this.onResult,
    this.onError,
    this.backgroundColor = const Color(0x80707070),
  });

  final double radius = 20;

  Future show() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _dialog();
      },
    );
  }

  _dialog() {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
      },
      canPop: false,
      child: Futuristic(
        autoStart: true,
        futureBuilder: () => onLoading,
        busyBuilder: (context) => body(),
        onData: (data) {
          Navigator.pop(context);
          onResult!(data);
        },
        onError: (error, retry) {
          Navigator.pop(context);
          onError!(error);
        },
      ),
    );
  }

  body() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(color: kColorPrimary),
        ),
      ],
    );
  }
}
