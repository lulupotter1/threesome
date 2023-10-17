import 'package:injectable/injectable.dart';
import 'package:threescreens/core/resources/data_state.dart';
import 'package:threescreens/core/usecases/usecase.dart';
import 'package:threescreens/features/weather_screen/domain/entities/weather_entities.dart';
import 'package:threescreens/features/weather_screen/domain/repositories/weather_repository.dart';

@Injectable()
class GetWeatherUseCase implements UseCase<DataState<WeatherCommonEntity>, String> {
  final WeatherRepository _weatherRepository;

  GetWeatherUseCase(this._weatherRepository);

  @override
  Future<DataState<WeatherCommonEntity>> call({required String params}) {
    return _weatherRepository.getWeather(cityName: params);
  }
}
