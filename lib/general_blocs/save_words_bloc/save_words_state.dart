part of 'save_words_bloc.dart';

abstract class SaveWordsState extends Equatable {
  const SaveWordsState();

  @override
  List<Object> get props => [];
}

//
final class SaveWordsInitial extends SaveWordsState {}

final class GetLearnWordsProgress extends SaveWordsState {}

final class GetLearnWordsFailure extends SaveWordsState {}

final class GetLearnWordsSuccess extends SaveWordsState {
  final List<Map<String, dynamic>> words;

  const GetLearnWordsSuccess({required this.words});

  @override
  List<Object> get props => [words];
}

final class GetKnewWordsProgress extends SaveWordsState {}

final class GetKnewWordsFailure extends SaveWordsState {}

final class GetKnewWordsSuccess extends SaveWordsState {
  final List<Map<String, dynamic>> words;

  const GetKnewWordsSuccess({required this.words});

  @override
  List<Object> get props => [words];
}

final class RemoveTrainingLearWordsAgain extends SaveWordsState {
  final List<Map<String, dynamic>> words;

  const RemoveTrainingLearWordsAgain({required this.words});

  @override
  List<Object> get props => [words];
}

// final class GetWordsSuccess extends SaveWordsState {
//   final List<Map<String, dynamic>> words;

//   const GetWordsSuccess({required this.words});

//   @override
//   List<Object> get props => [words];
// }

