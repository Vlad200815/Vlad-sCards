part of 'english_words_api_bloc.dart';

abstract class EnglishWordsApiEvent extends Equatable {
  const EnglishWordsApiEvent();

  @override
  List<Object> get props => [];
}

class OnEnglishWordsApiEvent extends EnglishWordsApiEvent {
  final String level;

  const OnEnglishWordsApiEvent({required this.level});
}
