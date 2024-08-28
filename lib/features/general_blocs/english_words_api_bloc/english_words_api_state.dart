part of 'english_words_api_bloc.dart';

sealed class EnglishWordsApiState extends Equatable {
  const EnglishWordsApiState();

  @override
  List<Object> get props => [];
}

final class EnglishWordsApiInitial extends EnglishWordsApiState {}

final class EnglishWordsApiProgress extends EnglishWordsApiState {}

final class EnglishWordsApiFailure extends EnglishWordsApiState {}

final class EnglishWordsApiSuccess extends EnglishWordsApiState {
  final Response response;

  const EnglishWordsApiSuccess({required this.response});

  @override
  List<Object> get props => [response];
}
