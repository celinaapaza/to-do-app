//Package imports:
import 'package:firebase_auth/firebase_auth.dart';

abstract class IDataAccess {
  Future<UserCredential?> signIn(String email, String password);
  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential?> signUp(String email, String password);
  Future<bool> logout();
}
