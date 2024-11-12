// lib/cubit/acara_state.dart
import 'package:equatable/equatable.dart';
import 'package:face_count/models/acara_model.dart';
import '../models/acara_model.dart';

abstract class AcaraState extends Equatable {
  const AcaraState();

  @override
  List<Object?> get props => [];
}

class AcaraInitial extends AcaraState {}

class AcaraLoading extends AcaraState {}

class AddAcaraSuccess extends AcaraState {}

class AcaraLoaded extends AcaraState {
  final List<AcaraModel> acaraList;

  const AcaraLoaded(this.acaraList);

  @override
  List<Object?> get props => [acaraList];
}

class AcaraError extends AcaraState {
  final String message;

  const AcaraError(this.message);

  @override
  List<Object?> get props => [message];
}
