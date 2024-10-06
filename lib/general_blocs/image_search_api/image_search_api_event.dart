part of 'image_search_api_bloc.dart';

abstract class ImageSearchApiEvent extends Equatable {
  const ImageSearchApiEvent();

  @override
  List<Object> get props => [];
}

class OnSearchImageEvent extends ImageSearchApiEvent {
  final String query;

  const OnSearchImageEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class OnSearchImageLearnEvent extends ImageSearchApiEvent {
  final String learnQurey;

  const OnSearchImageLearnEvent({required this.learnQurey});

  @override
  List<Object> get props => [learnQurey];
}

class OnSearchImageKnewEvent extends ImageSearchApiEvent {
  final String knewQurey;

  const OnSearchImageKnewEvent({required this.knewQurey});

  @override
  List<Object> get props => [knewQurey];
}
