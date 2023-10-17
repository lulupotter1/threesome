import 'package:threescreens/core/resources/data_state.dart';
import 'package:threescreens/features/weather_screen/domain/entities/weather_entities.dart';

abstract class WeatherRepository {
  Future<DataState<WeatherCommonEntity>> getWeather({
    required String cityName,
  });
}
