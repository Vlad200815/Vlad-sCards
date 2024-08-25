import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import 'package:talker_flutter/talker_flutter.dart';

part 'english_words_api_event.dart';
part 'english_words_api_state.dart';

class EnglishWordsApiBloc
    extends Bloc<EnglishWordsApiEvent, EnglishWordsApiState> {
  EnglishWordsApiBloc() : super(EnglishWordsApiInitial()) {
    on<OnEnlishWordsApiEvent>((event, emit) async {
      emit(EnglishWordsApiProgress());
      try {
        final dio = Dio();
        dio.interceptors.add(TalkerDioLogger());
        final Response response =
            await dio.get("https://english-words-api-xq8o.onrender.com/words");
        // print(response.body);
        emit(EnglishWordsApiSuccess(response: response));
      } catch (e, st) {
        emit(EnglishWordsApiFailure());
        GetIt.I<Talker>().handle(e, st);
      }
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}