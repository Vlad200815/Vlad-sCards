import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'english_words_api_event.dart';
part 'english_words_api_state.dart';

class EnglishWordsApiBloc
    extends Bloc<EnglishWordsApiEvent, EnglishWordsApiState> {
  EnglishWordsApiBloc() : super(EnglishWordsApiInitial()) {
    on<OnEnlishWordsApiEvent>((event, emit) async {
      emit(EnglishWordsApiProgress());
      try {
        final dio = Dio();
        final Response response =
            await dio.get("https://test-eight-xi-89.vercel.app/");
        print(response);
        emit(EnglishWordsApiSuccess(response: response));
      } catch (e) {
        emit(EnglishWordsApiFailure());
        debugPrint(e.toString());
      }
    });
  }
}
