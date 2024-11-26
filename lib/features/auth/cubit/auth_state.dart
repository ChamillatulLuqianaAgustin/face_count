part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Unauthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final String userName;
  const Authenticated({required this.userName});

  @override
  List<Object> get props => [userName];
}

class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}
