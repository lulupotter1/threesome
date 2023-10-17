import 'package:threescreens/features/weather_screen/domain/entities/weather_entities.dart';

class WeatherCurrentModel extends WeatherCurrentEntity {
  const WeatherCurrentModel({
    double? temp,
    double? feelslike,
    double? wind,
    double? pressure,
    int? cloud,
    int? isDay,
  }) : super(
          temp: temp,
          feelslike: feelslike,
          wind: wind,
          pressure: pressure,
          cloud: cloud,
          isDay: isDay,
        );

  factory WeatherCurrentModel.fromJson(Map<String, dynamic> map) {
    return WeatherCurrentModel(
      temp: map['temp_c'],
      feelslike: map['feelslike_c'],
      wind: map['wind_kph'],
      pressure: map['pressure_mb'],
      cloud: map['cloud'],
      isDay: map['is_day'],
    );
  }
}

class WeatherLocationModel extends WeatherLocationEntity {
  const WeatherLocationModel({
    String? name,
    String? region,
    String? country,
    String? localtime,
  }) : super(
          name: name,
          region: region,
          country: country,
          localtime: localtime,
        );

  factory WeatherLocationModel.fromJson(Map<String, dynamic> map) {
    return WeatherLocationModel(
      name: map['name'],
      region: map['region'],
      country: map['country'],
      localtime: map['localtime'],
    );
  }
}

class WeatherCommonModel extends WeatherCommonEntity {
  const WeatherCommonModel({
    WeatherLocationModel? weatherLocationModel,
    WeatherCurrentModel? weatherCurrentModel,
  }) : super(
          weatherCurrentEntity: weatherCurrentModel,
          weatherLocationEntity: weatherLocationModel,
        );

  factory WeatherCommonModel.fromJson(Map<String, dynamic> map) {
    return WeatherCommonModel(
      weatherLocationModel: WeatherLocationModel.fromJson(map['location'] as Map<String, dynamic>),
      weatherCurrentModel: WeatherCurrentModel.fromJson(map['current'] as Map<String, dynamic>),
    );
  }
}
