// import 'package:equatable/equatable.dart';

class WeatherCommonEntity {
  final WeatherCurrentEntity? weatherCurrentEntity;
  final WeatherLocationEntity? weatherLocationEntity;

  const WeatherCommonEntity({
    this.weatherCurrentEntity,
    this.weatherLocationEntity,
  });
}

class WeatherCurrentEntity {
  final double? temp;
  final double? feelslike;
  final double? wind;
  final double? pressure;
  final int? cloud;
  final int? isDay;

  const WeatherCurrentEntity({
    this.temp,
    this.feelslike,
    this.wind,
    this.pressure,
    this.cloud,
    this.isDay,
  });
}

class WeatherLocationEntity {
  final String? name;
  final String? region;
  final String? country;
  final String? localtime;

  const WeatherLocationEntity({
    this.name,
    this.region,
    this.country,
    this.localtime,
  });
}
