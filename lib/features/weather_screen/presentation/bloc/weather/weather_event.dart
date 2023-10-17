part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {
  const WeatherEvent();
}

class GetWeather extends WeatherEvent {
  final String cityName;
  final bool withLoading;
  const GetWeather({
    required this.cityName,
    this.withLoading = true,
  });
}

class DisposeWeather extends WeatherEvent {}
