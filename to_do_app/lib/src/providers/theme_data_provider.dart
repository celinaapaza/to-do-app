//Flutter imports:
import 'package:flutter/material.dart';
import 'package:to_do_app/src/managers/data_manager.dart';
import 'package:to_do_app/utils/k_colors.dart';

class ThemeDataProvider with ChangeNotifier {
  static final ThemeDataProvider _instance = ThemeDataProvider._constructor();

  factory ThemeDataProvider() {
    return _instance;
  }

  ThemeDataProvider._constructor();

  init() async {
    _darkMode = DataManager().getDarkMode();
    _themeData = _darkMode ? _themeDataDark : _themeDataLight;
  }

  bool _darkMode = false;
  ThemeData? _themeData;

  void setDarkMode(bool value) {
    _darkMode = value;
    _setThemeData(_darkMode ? _themeDataDark : _themeDataLight);
  }

  ThemeData? get themeData => _themeData;

  void _setThemeData(ThemeData value) {
    _themeData = value;
    notifyListeners();
  }

  final ThemeData _themeDataLight = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    primaryColor: kColorPrimary,
    appBarTheme: AppBarTheme(backgroundColor: kColorPrimary),
    scaffoldBackgroundColor: kColorBackgroundLight,

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: kColorPrimary,
      selectionColor: kColorPrimaryWithOpacity,
      selectionHandleColor: kColorPrimary,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      modalElevation: 0,
      modalBackgroundColor: kColorBackgroundLight,
      dragHandleSize: Size(32, 4),
      dragHandleColor: kColorPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return kColorPrimary;
        } else {
          return kColorWhite;
        }
      }),
    ),
  );

  final ThemeData _themeDataDark = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    primaryColor: kColorPrimary,
    appBarTheme: AppBarTheme(backgroundColor: kColorPrimary),
    scaffoldBackgroundColor: kColorBackgroundLight,

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: kColorPrimary,
      selectionColor: kColorPrimaryWithOpacity,
      selectionHandleColor: kColorPrimary,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      modalElevation: 0,
      modalBackgroundColor: kColorBackgroundLight,
      dragHandleSize: Size(32, 4),
      dragHandleColor: kColorPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return kColorPrimary;
        } else {
          return kColorWhite;
        }
      }),
    ),
  );
}
