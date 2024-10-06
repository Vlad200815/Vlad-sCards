part of 'image_search_api_bloc.dart';

sealed class ImageSearchApiState extends Equatable {
  const ImageSearchApiState();

  @override
  List<Object> get props => [];
}

final class ImageSearchApiInitial extends ImageSearchApiState {}

final class ImageSearchApiProgress extends ImageSearchApiState {}

final class ImageSearchApiFailure extends ImageSearchApiState {}

final class ImageSearchApiSuccess extends ImageSearchApiState {
  final String url;

  const ImageSearchApiSuccess({required this.url});

  @override
  List<Object> get props => [url];
}

final class ImageSearchLearnApiProgress extends ImageSearchApiState {}

final class ImageSearchLearnApiFailure extends ImageSearchApiState {}

final class ImageSearchLearnApiSuccess extends ImageSearchApiState {
  final String url;

  const ImageSearchLearnApiSuccess({required this.url});

  @override
  List<Object> get props => [url];
}

final class ImageSearchKnewApiProgress extends ImageSearchApiState {}

final class ImageSearchKnewApiFailure extends ImageSearchApiState {}

final class ImageSearchKnewApiSuccess extends ImageSearchApiState {
  final String url;

  const ImageSearchKnewApiSuccess({required this.url});

  @override
  List<Object> get props => [url];
}
