import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'image_search_api_event.dart';
part 'image_search_api_state.dart';

class ImageSearchApiBloc
    extends Bloc<ImageSearchApiEvent, ImageSearchApiState> {
  ImageSearchApiBloc() : super(ImageSearchApiInitial()) {
    on<OnSearchImageEvent>((event, emit) async {
      emit(ImageSearchApiProgress());
      try {
        final dio = Dio();
        dio.interceptors.add(TalkerDioLogger());
        final Response response = await dio
            .get(
                "https://api.unsplash.com/search/photos?query=${event.query}&client_id=z4817XVH1sVYXkkOrXQ_v0px_lkSGJhXfzWJkXOgay0")
            .timeout(const Duration(seconds: 10));
        if (response.statusCode == 200) {
          var url = response.data['results'][0]['urls']['regular'];
          GetIt.I<Talker>().debug(url);
          emit(ImageSearchApiSuccess(url: url));
        } else {
          emit(ImageSearchApiFailure());
        }
      } catch (e, st) {
        emit(ImageSearchApiFailure());
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
