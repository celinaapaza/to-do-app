//Flutter imports:
import 'package:flutter/material.dart';

//Project imports:
import '../managers/data_manager.dart';
import '../../utils/k_colors.dart';

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

  bool get darkMode => _darkMode;

  void setDarkMode(bool value) {
    _darkMode = value;
    notifyListeners();
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
    appBarTheme: const AppBarTheme(
      backgroundColor: kColorPrimary,
      shadowColor: kColorBackgroundDarkWithOpacity,
      elevation: 5,
      iconTheme: IconThemeData(color: kColorWhite),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: kColorBackgroundLight),
    scaffoldBackgroundColor: kColorBackgroundLight,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: kColorWhite,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: kColorTextLight,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: kColorTextLight,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: kColorTextLight,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: kColorTextLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: kColorTextLight,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: kColorPrimary,
      selectionColor: kColorShadowLight,
      selectionHandleColor: kColorPrimary,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      modalElevation: 0,
      modalBackgroundColor: kColorBackgroundLight,
      dragHandleSize: Size(32, 4),
      dragHandleColor: kColorPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(kColorBackgroundLight),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return kColorPrimary;
        } else {
          return kColorBackgroundLight;
        }
      }),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kColorPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
        backgroundColor: const WidgetStatePropertyAll(kColorPrimary),
        iconColor: const WidgetStatePropertyAll(kColorWhite),
        iconSize: const WidgetStatePropertyAll(25),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            color: kColorWhite,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
    radioTheme: const RadioThemeData(
      fillColor: WidgetStatePropertyAll(kColorPrimary),
    ),
    colorScheme: const ColorScheme.light(
      primary: kColorPrimary,
      secondary: kColorPrimary,
      onSurface: kColorPrimary,
      surfaceTint: kColorWhite,
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(kColorPrimary),
        textStyle: WidgetStatePropertyAll(
          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: kColorBackgroundLight,
      headerForegroundColor: kColorPrimary,
      headerBackgroundColor: kColorBackgroundLight,
      weekdayStyle: TextStyle(color: kColorPrimary),
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: kColorBackgroundLight,
      entryModeIconColor: kColorPrimary,
      dialBackgroundColor: kColorBackgroundLight,
      dialHandColor: kColorPrimary,
    ),
  );

  final ThemeData _themeDataDark = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    primaryColor: kColorPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: kColorPrimary,
      shadowColor: kColorShadowDark,
      elevation: 5,
      iconTheme: IconThemeData(color: kColorBlack),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: kColorBackgroundDark),
    scaffoldBackgroundColor: kColorBackgroundDark,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: kColorBlack,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: kColorTextDark,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: kColorTextDark,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: kColorTextDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: kColorTextDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: kColorTextDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        color: kColorTextDark,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        color: kColorTextDark,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(
        color: kColorTextDark,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: kColorPrimary,
      selectionColor: kColorShadowLight,
      selectionHandleColor: kColorPrimary,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      modalElevation: 0,
      modalBackgroundColor: kColorBackgroundLight,
      dragHandleSize: Size(32, 4),
      dragHandleColor: kColorPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(kColorBackgroundDark),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return kColorPrimary;
        } else {
          return kColorBackgroundDark;
        }
      }),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kColorPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
        backgroundColor: const WidgetStatePropertyAll(kColorPrimary),
        iconColor: const WidgetStatePropertyAll(kColorBlack),
        iconSize: const WidgetStatePropertyAll(25),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            color: kColorBlack,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
    radioTheme: const RadioThemeData(
      fillColor: WidgetStatePropertyAll(kColorPrimary),
    ),
    colorScheme: const ColorScheme.light(
      primary: kColorPrimary,
      secondary: kColorPrimary,
      onSurface: kColorPrimary,
      surfaceTint: kColorWhite,
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(kColorPrimary),
        textStyle: WidgetStatePropertyAll(
          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: kColorBackgroundDark,
      headerForegroundColor: kColorPrimary,
      headerBackgroundColor: kColorBackgroundDark,
      weekdayStyle: TextStyle(color: kColorPrimary),
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: kColorBackgroundDark,
      entryModeIconColor: kColorPrimary,
      dialBackgroundColor: kColorBackgroundDark,
      dialHandColor: kColorPrimary,
      hourMinuteColor: kColorBackgroundDark,
    ),
  );
}
