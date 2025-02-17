//Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Project imports:
import '../interfaces/i_data_access.dart';
import '../models/task_model.dart';

class RemoteDataAccess implements IDataAccess {
  //#region Authentication

  @override
  Future<UserCredential?> signIn(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      throw Exception('No se pudo iniciar sesión con Google');
    }
  }

  @override
  Future<UserCredential?> signUp(String email, String password) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<bool> logout() async {
    await FirebaseAuth.instance.signOut();
    return true;
  }

  @override
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
  //#endregion

  //#region Task
  String userCollection = "users";
  String taskCollection = "tasks";

  @override
  Stream<QuerySnapshot> getListTask(String userUid) {
    return FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userUid)
        .collection(taskCollection)
        .snapshots();
  }

  @override
  Stream<DocumentSnapshot> getTask(String userUid, String taskUid) {
    return FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userUid)
        .collection(taskCollection)
        .doc(taskUid)
        .snapshots();
  }

  @override
  Future<bool> createTask(String userUid, TaskModel task) async {
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userUid)
        .collection(taskCollection)
        .add(task.toJson());

    return true;
  }

  @override
  Future<bool> updateTask(String userUid, TaskModel task) async {
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userUid)
        .collection(taskCollection)
        .doc(task.uid)
        .update(task.toJson());

    return true;
  }

  @override
  Future<bool> deleteTask(String userUid, String taskUid) async {
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userUid)
        .collection(taskCollection)
        .doc(taskUid)
        .delete();

    return true;
  }

  //#endregion
}
