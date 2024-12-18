import 'package:equatable/equatable.dart';

abstract class PictureState extends Equatable {
  const PictureState();

  @override
  List<Object?> get props => [];
}

class PictureInitial extends PictureState {}

class PictureLoading extends PictureState {}

class PictureScanSuccess extends PictureState {
  final int maleCount;
  final int femaleCount;
  final List<String> urls;
  const PictureScanSuccess({
    required this.maleCount,
    required this.femaleCount,
    required this.urls,
  });

  @override
  List<Object?> get props => [maleCount, femaleCount, urls];
}

class PictureAddSuccess extends PictureState {
  final int male;
  final int female;
  const PictureAddSuccess({required this.male, required this.female});

  @override
  List<Object?> get props => [male, female];
}

class PictureLoaded extends PictureState {
  final List<String> photosUrl;
  const PictureLoaded(this.photosUrl);

  @override
  List<Object?> get props => [photosUrl];
}

class PictureError extends PictureState {
  final String message;
  const PictureError(this.message);

  @override
  List<Object?> get props => [message];
}
