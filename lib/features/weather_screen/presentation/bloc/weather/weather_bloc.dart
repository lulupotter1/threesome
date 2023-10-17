import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import 'package:threescreens/core/resources/data_state.dart';
import 'package:threescreens/features/weather_screen/domain/entities/weather_entities.dart';
import 'package:threescreens/features/weather_screen/domain/usecases/get_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

@Injectable()
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase _getWeatherUseCase;
  WeatherBloc(
    this._getWeatherUseCase,
  ) : super(WeatherInitial()) {
    on<GetWeather>(onGetWeather);
    on<DisposeWeather>(onDisposeWeather);
  }

  Timer? timer;

  onGetWeather(GetWeather event, Emitter<WeatherState> emit) async {
    if (event.withLoading) {
      emit(WeatherLoading());
    }

    final dataState = await _getWeatherUseCase.call(
      params: event.cityName,
    );
    if (dataState is DataSuccess) {
      emit(WeatherSuccess(weather: dataState.data!));
      if (timer == null) {
        timer = Timer.periodic(const Duration(seconds: 3), (timer) {
          add(GetWeather(cityName: event.cityName, withLoading: false));
        });
      } else {
        timer!.cancel();
        timer = Timer.periodic(const Duration(seconds: 3), (timer) {
          add(GetWeather(cityName: event.cityName, withLoading: false));
        });
      }
    } else {
      emit(WeatherFailure(error: dataState.exception!));
    }
  }

  onDisposeWeather(DisposeWeather event, Emitter<WeatherState> emit) async {
    if (timer != null) {
      timer!.cancel();
    }
  }
}
