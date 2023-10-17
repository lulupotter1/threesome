import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:threescreens/core/constant/constants.dart';
import 'package:threescreens/core/resources/data_state.dart';
import 'package:threescreens/features/weather_screen/data/datasources/remote/weather_api_service.dart';
import 'package:threescreens/features/weather_screen/data/models/weather.dart';
import 'package:threescreens/features/weather_screen/domain/repositories/weather_repository.dart';

@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService _weatherApiService;

  WeatherRepositoryImpl(this._weatherApiService);

  @override
  Future<DataState<WeatherCommonModel>> getWeather({
    required String cityName,
  }) async {
    try {
      final httpResponse = await _weatherApiService.getWeathers(
        aqi: "no",
        apiKey: weatherApiKey,
        cityName: cityName,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          type: DioExceptionType.badResponse,
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
