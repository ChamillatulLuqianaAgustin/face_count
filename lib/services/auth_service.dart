import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_count/features/auth/forgot_password_page.dart';
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

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw Exception("No user is currently signed in.");
    }

    final cred = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    try {
      // Reauthenticate the user
      await user.reauthenticateWithCredential(cred);

      // Update the password
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> resetPassword(String email)async{
     if (email.isEmpty) {
    throw Exception("Email tidak boleh kosong");
  }

  try {
    // Periksa apakah email terdaftar di Firestore
    final QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: email)
        .get();

    if (query.docs.isEmpty) {
      throw Exception("Email tidak terdaftar");
    }

    // Kirim email reset password
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } catch (e) {
    // Tangani error
    throw Exception("Gagal mengirim email reset password: ${e.toString()}");
  }
  }
}
