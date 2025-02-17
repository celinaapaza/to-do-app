//Dart imports:
import 'dart:convert';

//Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Project imports:
import '../data_access/remote_data_access.dart';
import '../interfaces/i_data_access.dart';
import '../models/user_model.dart';

class DataManager {
  static final DataManager _instance = DataManager._constructor();

  SharedPreferences? prefs;
  IDataAccess? _dataAccess;

  factory DataManager() {
    return _instance;
  }

  DataManager._constructor();

  Future<void> initPrefereces() async {
    prefs = await SharedPreferences.getInstance();
  }

  init() async {
    _dataAccess = RemoteDataAccess();

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

  Future<void> _saveUserPrefs(UserModel user) async {
    await prefs?.setString("user", jsonEncode(user.toJson()));
  }

  UserModel? getUserPrefs() {
    String? jsonString = prefs?.getString("user");
    if (jsonString != null) {
      return UserModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  //#endregion

  //#region FirebaseAuth
  Future<bool> logout() async {
    bool result = await _dataAccess?.logout() ?? false;

    if (result) {
      return await prefs?.remove("user") ?? false;
    }

    return false;
  }

  Future<UserModel?> signIn(String email, String password) async {
    UserCredential? userCredential = await _dataAccess?.signIn(email, password);

    if (userCredential == null) {
      return null;
    }

    return saveUser(userCredential);
  }

  Future<UserModel?> signInWithGoogle() async {
    UserCredential? userCredential = await _dataAccess?.signInWithGoogle();

    if (userCredential == null) {
      return null;
    }

    return saveUser(userCredential);
  }

  Future<UserModel?> signUp(String email, String password) async {
    UserCredential? userCredential = await _dataAccess?.signUp(email, password);

    if (userCredential == null) {
      return null;
    }

    return saveUser(userCredential);
  }

  Future<UserModel> saveUser(UserCredential userCredential) async {
    UserModel user = UserModel(
      uid: userCredential.user?.uid,
      email: userCredential.user?.email,
    );
    await _saveUserPrefs(user);

    return user;
  }

  //#endregion
}
