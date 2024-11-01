import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _auth;
  AuthCubit(this._auth) : super(Unauthenticated());

  Future<void> register({
    required String email,
    required String password,
  }) async {
    // Set to loading state
    emit(AuthLoading());
    try {
      await _auth.register(
        email: email,
        password: password,
      );
      // If register success, set to 'authenticated' state
      emit(Authenticated());
    } catch (e) {
      // If register success, set to 'autherror' state
      emit(AuthError(message: e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    // Set to loading state
    emit(AuthLoading());
    try {
      await _auth.login(
        email: email,
        password: password,
      );
      // If login success, set to 'authenticated' state
      emit(Authenticated());
    } catch (e) {
      // If login success, set to 'autherror' state
      emit(AuthError(message: e.toString()));
      emit(Unauthenticated());
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
