import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:threescreens/core/constant/constants.dart';
import 'package:dio/dio.dart';
import 'package:threescreens/features/weather_screen/data/models/weather.dart';

part 'weather_api_service.g.dart';

@RestApi(baseUrl: weatherApiBaseUrl)
@Injectable()
abstract class WeatherApiService {
  @factoryMethod
  factory WeatherApiService(Dio dio) = _WeatherApiService;

  @POST("current.json")
  Future<HttpResponse<WeatherCommonModel>> getWeathers({
    @Query("key") required String apiKey,
    @Query("q") required String cityName,
    @Query("aqi") required String aqi,
  });
}
