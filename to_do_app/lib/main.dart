//Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

//Project imports:
import 'src/enums/page_names_enum.dart';
import 'src/managers/data_manager.dart';
import 'src/managers/page_manager.dart';
import 'src/providers/theme_data_provider.dart';
import 'utils/k_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: kColorPrimary,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  await initializeDateFormatting('es', null);
  await _initConfigurations();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeDataProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TO-DO App',
      navigatorKey: PageManager().navigatorKey,
      initialRoute: PageNames.init.name,
      onGenerateRoute: (settings) {
        return PageManager().getRoute(settings);
      },
      debugShowCheckedModeBanner: false,
      locale: const Locale("es", ''),
      // builder: (_, Widget? child) {
      //   final Overlay overlay = Overlay(
      //     initialEntries: <OverlayEntry>[
      //       if (child != null) OverlayEntry(builder: (_) => child),
      //     ],
      //   );
      //   return Directionality(textDirection: TextDirection.ltr, child: overlay);
      // },
      theme: context.watch<ThemeDataProvider>().themeData,
    );
  }
}

Future<void> _initConfigurations() async {
  await DataManager().initPrefereces();
  ThemeDataProvider().init();
}
