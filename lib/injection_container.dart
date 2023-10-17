// import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
// import 'package:threescreens/features/weather_screen/data/datasources/remote/weather_api_service.dart';
// import 'package:threescreens/features/weather_screen/data/repositories/weather_repository_impl.dart';
// import 'package:threescreens/features/weather_screen/domain/repositories/weather_repository.dart';
// import 'package:threescreens/features/weather_screen/domain/usecases/get_weather.dart';
// import 'package:threescreens/features/weather_screen/presentation/bloc/weather/weather_bloc.dart';
import 'injection_container.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => sl.init();

// Future<void> initializeDependencies() async {
//   sl.registerSingleton<Dio>(Dio());

//   sl.registerSingleton<WeatherApiService>(WeatherApiService(sl()));

//   sl.registerSingleton<WeatherRepository>(WeatherRepositoryImpl(sl()));

//   sl.registerSingleton<GetWeatherUseCase>(GetWeatherUseCase(sl()));

//   sl.registerFactory<WeatherBloc>(() => WeatherBloc(sl()));
// }
