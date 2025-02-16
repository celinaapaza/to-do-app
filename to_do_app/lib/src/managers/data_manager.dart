//Package imports:
import 'package:shared_preferences/shared_preferences.dart';

//Project imports:
import '../data_access/remote_data_access.dart';
import '../interfaces/i_data_access.dart';

class DataManager {
  static final DataManager _instance = DataManager._constructor();

  SharedPreferences? prefs;
  IDataAccess? dataAccess;

  factory DataManager() {
    return _instance;
  }

  DataManager._constructor();

  Future<void> initPrefereces() async {
    prefs = await SharedPreferences.getInstance();
  }

  init() async {
    dataAccess = RemoteDataAccess();

    // await saveCulture(getSystemLanguage());

    // if (hasSession()) {
    //   String token = getToken()!;
    //   Network().setToken(token);
    // }
  }

  //#region Preferences
  void setDarkMode(bool value) {
    prefs?.setBool('darkMode', value);
  }

  bool getDarkMode() {
    return prefs?.getBool('darkMode') ?? false;
  }
}
