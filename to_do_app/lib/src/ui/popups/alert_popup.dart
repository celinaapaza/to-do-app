// Flutter imports:
import 'package:flutter/material.dart';

//Project imports:
import '../../../utils/k_colors.dart';
import '../../../utils/k_texts.dart';
import '../../providers/theme_data_provider.dart';
import '../components/custom_button_component.dart';

class AlertPopup {
  final BuildContext context;
  final String title;
  final String description;
  final Function? onAcceptPressed;

  AlertPopup({
    required this.context,
    required this.title,
    required this.description,
    this.onAcceptPressed,
  });

  final double radius = 20;

  Future show() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return _dialog();
      },
    );
  }

  _dialog() {
    return Center(
      child: Container(
        child: _body(),
        margin: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color:
              ThemeDataProvider().darkMode
                  ? kColorBackgroundDark
                  : kColorBackgroundLight,
        ),
      ),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            const SizedBox(height: 24),
            _description(),
            const SizedBox(height: 24),
            _buttonAccept(),
          ],
        ),
      ),
    );
  }

  _title() {
    return Material(
      type: MaterialType.transparency,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.isNotEmpty ? title : "",
            softWrap: true,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: kColorPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 18,
              fontFamily: 'Inter',
            ),
          ),
          _buttonExit(),
        ],
      ),
    );
  }

  _description() {
    return Material(
      type: MaterialType.transparency,
      child: Text(
        description.isNotEmpty ? description : "",
        softWrap: true,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  _buttonAccept() {
    return customButtonComponent(context, kTextAccept, null, kColorPrimary, () {
      Navigator.pop(context);
      onAcceptPressed?.call();
    });
  }

  _buttonExit() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, false);
      },
      child: const Icon(Icons.close, size: 24),
    );
  }
}
