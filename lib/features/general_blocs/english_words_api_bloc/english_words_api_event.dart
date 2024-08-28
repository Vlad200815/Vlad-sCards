part of 'english_words_api_bloc.dart';

abstract class EnglishWordsApiEvent extends Equatable {
  const EnglishWordsApiEvent();

  @override
  List<Object> get props => [];
}

class OnEnlishWordsApiEvent extends EnglishWordsApiEvent {}
