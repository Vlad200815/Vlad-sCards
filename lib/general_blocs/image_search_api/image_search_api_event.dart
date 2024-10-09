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
