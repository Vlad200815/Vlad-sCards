import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vlads_cards/repositories/save_words/save_words.dart';

part 'save_words_event.dart';
part 'save_words_state.dart';

class SaveWordsBloc extends Bloc<SaveWordsEvent, SaveWordsState> {
  final SaveWordsRepositoryInterface _saveWordsRepository;

  SaveWordsBloc({
    required SaveWordsRepositoryInterface saveWordsRepository,
  })  : _saveWordsRepository = saveWordsRepository,
        super(SaveWordsInitial()) {
    on<OnSaveLearnWords>((event, emit) async {
      try {
        await _saveWordsRepository.saveLearnWords(event.listMap);
      } catch (e, st) {
        GetIt.I<Talker>().handle(e, st);
      }
    });

    on<OnGetLearnWords>((event, emit) async {
      emit(GetLearnWordsProgress());
      try {
        List<Map<String, dynamic>> words =
            await _saveWordsRepository.getLearnWords();
        emit(GetLearnWordsSuccess(words: words));
      } catch (e, st) {
        emit(GetLearnWordsFailure());
        GetIt.I<Talker>().handle(e, st);
      }
    });

    on<OnSaveKnewWords>((event, emit) async {
      try {
        await _saveWordsRepository.saveKnewWords(event.listMap);
      } catch (e, st) {
        GetIt.I<Talker>().handle(e, st);
      }
    });

    on<OnGetKnewWords>((event, emit) async {
      emit(GetKnewWordsProgress());
      try {
        List<Map<String, dynamic>> words =
            await _saveWordsRepository.getKnewWords();
        emit(GetKnewWordsSuccess(words: words));
      } catch (e, st) {
        emit(GetKnewWordsFailure());
        GetIt.I<Talker>().handle(e, st);
      }
    });

    on<OnRemoveLearWords>((event, emit) async {
      try {
        await _saveWordsRepository.removeLearnWord(event.word);
      } catch (e, st) {
        GetIt.I<Talker>().handle(e, st);
      }
    });

    on<OnRemoveKnewWords>((event, emit) async {
      try {
        await _saveWordsRepository.removeKnewWord(event.word);
      } catch (e, st) {
        GetIt.I<Talker>().handle(e, st);
      }
    });

    on<OnRemoveTrainingLearWords>((event, emit) async {
      try {
        await _saveWordsRepository.removeLearn();
      } catch (e, st) {
        GetIt.I<Talker>().handle(e, st);
      }
    });

    // method for savign known words from shared prefs
    // on<OnKnowSaveWords>((event, emit) {
    //   emit(SaveWordsProgress());
    //   try {
    //     _saveWordsRepository.saveKnowWords(event.knowlistMap);
    //     emit(SaveWordsSuccess());
    //   } catch (e, st) {
    //     emit(SaveWordsFailure());
    //     GetIt.I<Talker>().handle(e, st);
    //   }
    // });
    // for saving knew cards in choose_words.dart screen

    // method for getting known words from shared prefs
    // on<OnGetKnowWords>((event, emit) async {
    //   emit(GetWordsProgress());
    //   try {
    //     final List<Map<String, dynamic>> words =
    //         await _saveWordsRepository.getKnowWords();
    //     emit(GetWordsSuccess(words: words));
    //   } catch (e, st) {
    //     emit(GetWordsFailure());
    //     GetIt.I<Talker>().handle(e, st);
    //   }
    // });
  }
}
