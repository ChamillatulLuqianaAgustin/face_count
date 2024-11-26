import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User?> register({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateDisplayName(String name) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload(); 
      }
    } catch (e) {
      throw Exception("Failed to update display name: $e");
    }
  }
}
