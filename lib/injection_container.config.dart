// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/resources/dio_provider.dart' as _i9;
import 'features/weather_screen/data/datasources/remote/weather_api_service.dart'
    as _i4;
import 'features/weather_screen/data/repositories/weather_repository_impl.dart'
    as _i6;
import 'features/weather_screen/domain/repositories/weather_repository.dart'
    as _i5;
import 'features/weather_screen/domain/usecases/get_weather.dart' as _i7;
import 'features/weather_screen/presentation/bloc/weather/weather_bloc.dart'
    as _i8;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioProvider = _$DioProvider();
    gh.singleton<_i3.Dio>(dioProvider.dio());
    gh.factory<_i4.WeatherApiService>(
        () => _i4.WeatherApiService(gh<_i3.Dio>()));
    gh.factory<_i5.WeatherRepository>(
        () => _i6.WeatherRepositoryImpl(gh<_i4.WeatherApiService>()));
    gh.factory<_i7.GetWeatherUseCase>(
        () => _i7.GetWeatherUseCase(gh<_i5.WeatherRepository>()));
    gh.factory<_i8.WeatherBloc>(
        () => _i8.WeatherBloc(gh<_i7.GetWeatherUseCase>()));
    return this;
  }
}

class _$DioProvider extends _i9.DioProvider {}
