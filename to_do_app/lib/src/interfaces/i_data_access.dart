//Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task_model.dart';

abstract class IDataAccess {
  Future<UserCredential?> signIn(String email, String password);
  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential?> signUp(String email, String password);
  Future<bool> logout();
  User? getCurrentUser();

  Stream<QuerySnapshot> getListTask(String userUid);
  Stream<DocumentSnapshot> getTask(String userUid, String taskUid);
  Future<bool> updateTask(String userUid, TaskModel task);
  Future<bool> createTask(String userUid, TaskModel task);
  Future<bool> deleteTask(String userUid, String taskUid);
}
