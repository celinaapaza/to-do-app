//Dart imports:
import 'dart:convert';

//Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Project imports:
import '../data_access/remote_data_access.dart';
import '../interfaces/i_data_access.dart';
import '../models/task_model.dart';
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

  Future<bool> logout() async {
    bool result = await _dataAccess?.logout() ?? false;

    if (result) {
      return await prefs?.remove("user") ?? false;
    }

    return false;
  }

  Future<bool> hasSession() async {
    User? user = _dataAccess?.getCurrentUser();

    if (user == null) {
      return false;
    }

    UserModel userModel = UserModel(uid: user.uid, email: user.email);

    await _saveUserPrefs(userModel);

    return true;
  }

  //#endregion

  //#region Task
  Stream<QuerySnapshot>? getListTask() {
    String? userUid = getUserPrefs()?.uid;

    if (userUid == null) {
      return null;
    }

    return _dataAccess!.getListTask(userUid);
  }

  Stream<DocumentSnapshot>? getTask(String taskUid) {
    String? userUid = getUserPrefs()?.uid;

    if (userUid == null) {
      return null;
    }

    return _dataAccess!.getTask(userUid, taskUid);
  }

  Future<bool> createTask(TaskModel task) async {
    String? userUid = getUserPrefs()?.uid;

    if (userUid == null) {
      return false;
    }

    return await _dataAccess?.createTask(userUid, task) ?? false;
  }

  Future<bool> updateTask(TaskModel task) async {
    String? userUid = getUserPrefs()?.uid;

    if (userUid == null) {
      return false;
    }

    return await _dataAccess?.updateTask(userUid, task) ?? false;
  }

  Future<bool> deleteTask(String taskUid) async {
    String? userUid = getUserPrefs()?.uid;

    if (userUid == null) {
      return false;
    }

    return await _dataAccess?.deleteTask(userUid, taskUid) ?? false;
  }

  //#endregion
}
