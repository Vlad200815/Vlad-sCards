part of 'save_words_bloc.dart';

abstract class SaveWordsEvent extends Equatable {
  const SaveWordsEvent();

  @override
  List<Object> get props => [];
}

class OnGetLearnWords extends SaveWordsEvent {}

class OnGetKnewWords extends SaveWordsEvent {}

class OnSaveLearnWords extends SaveWordsEvent {
  final Map<String, dynamic> listMap;

  const OnSaveLearnWords({required this.listMap});

  @override
  List<Object> get props => [listMap];
}

class OnSaveKnewWords extends SaveWordsEvent {
  final Map<String, dynamic> listMap;

  const OnSaveKnewWords({required this.listMap});

  @override
  List<Object> get props => [listMap];
}

class OnRemoveLearWords extends SaveWordsEvent {
  final Map<String, dynamic> word;

  const OnRemoveLearWords(this.word);

  @override
  List<Object> get props => [word];
}

class OnRemoveKnewWords extends SaveWordsEvent {
  final Map<String, dynamic> word;

  const OnRemoveKnewWords({required this.word});

  @override
  List<Object> get props => [word];
}

class OnRemoveTrainingLearWords extends SaveWordsEvent {}
