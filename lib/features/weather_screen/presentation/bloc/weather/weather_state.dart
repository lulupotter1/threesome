part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final WeatherCommonEntity weather;
  WeatherSuccess({
    required this.weather,
  });
}

final class WeatherFailure extends WeatherState {
  final DioException error;

  WeatherFailure({
    required this.error,
  });
}
