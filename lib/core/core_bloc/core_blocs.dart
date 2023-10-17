import 'package:threescreens/features/weather_screen/presentation/bloc/weather/weather_bloc.dart';
import 'package:threescreens/injection_container.dart';

class CoreBlocs {
  static final weather = sl.get<WeatherBloc>();
}
