import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _auth;
  AuthCubit(this._auth) : super(Unauthenticated());

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading());
    try {
      User? user = await _auth.register(
        email: email,
        password: password,
      );
      if (user != null) {
        await _auth.updateDisplayName(name);
        await user.reload(); // Pastikan pengguna diperbarui
        emit(Authenticated(userName: name, userId: user.uid));
      } else {
        emit(AuthError(message: "User registration failed"));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(message: e.message ?? "An unknown error occurred."));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      User? user = await _auth.login(
        email: email,
        password: password,
      );
      if (user != null) {
        emit(Authenticated(
          userName: user.displayName ?? user.email ?? "User",
          userId: user.uid)); 
      } else {
        emit(AuthError(message: "User login failed"));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(message: e.message ?? "An unknown error occurred."));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _auth.logout();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
