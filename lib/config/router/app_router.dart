import 'package:auto_route/auto_route.dart';
import 'package:threescreens/features/calculator_screen/calculator_screen.dart';
import 'package:threescreens/features/first_screen/first_screen.dart';
import 'package:threescreens/features/weather_screen/presentation/pages/weather_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: WeatherRoute.page, path: '/'),
      AutoRoute(page: CalculatorRoute.page, path: '/calculatorScreen'),
      AutoRoute(page: FirstRoute.page, path: '/firstScreen'),
    ];
  }
}
