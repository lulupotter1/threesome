import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threescreens/core/core_bloc/core_blocs.dart';
import 'package:threescreens/features/weather_screen/domain/entities/weather_entities.dart';
import 'package:threescreens/features/weather_screen/presentation/bloc/weather/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threescreens/features/weather_screen/presentation/widgets/custom_text_field.dart';

@RoutePage()
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void dispose() {
    CoreBlocs.weather.add(DisposeWeather());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: CoreBlocs.weather..add(const GetWeather(cityName: "London")),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Weather Current",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: const WeatherBody(),
      ),
    );
  }
}

class WeatherBody extends StatelessWidget {
  const WeatherBody({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController cityController = TextEditingController(text: "London");
    WeatherCommonEntity? weatherCommonEntity;
    bool isDay = true;
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherFailure) {
          final snackBar = SnackBar(
            content: Text(state.error.message ?? "Error"),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if (state is WeatherSuccess) {
          final snackBar = SnackBar(
            duration: const Duration(milliseconds: 500),
            content: Text("Refreshing ${state.weather.weatherLocationEntity?.name ?? "-"}"),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is WeatherSuccess) {
          weatherCommonEntity = state.weather;
          isDay = state.weather.weatherCurrentEntity?.isDay == 1;
        }

        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: cityController,
                            labelTitle: "Name",
                            hintText: "City name",
                          ),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            CoreBlocs.weather.add(GetWeather(
                              cityName: cityController.text,
                            ));
                          },
                          child: const Text("Search"),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          isDay ? "assets/pictures/day.jpg" : "assets/pictures/night.jpg",
                        ),
                        fit: BoxFit.fill,
                      )),
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            weatherCommonEntity?.weatherLocationEntity?.name ?? "",
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            weatherCommonEntity?.weatherLocationEntity?.localtime ?? "",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            weatherCommonEntity?.weatherLocationEntity?.country ?? "",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            weatherCommonEntity?.weatherLocationEntity?.region ?? "",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: weatherCommonEntity != null
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          _row(
                            left: "Temperature",
                            right: "${weatherCommonEntity!.weatherCurrentEntity?.temp ?? "0"} C",
                          ),
                          const SizedBox(height: 10),
                          _row(
                            left: "Temperature feels like",
                            right: "${weatherCommonEntity!.weatherCurrentEntity?.feelslike ?? "0"} C",
                          ),
                          const SizedBox(height: 10),
                          _row(
                            left: "Wind",
                            right: "${weatherCommonEntity!.weatherCurrentEntity?.wind ?? "0"} km/hour",
                          ),
                          const SizedBox(height: 10),
                          _row(
                            left: "Rain chance percent",
                            right: "${weatherCommonEntity!.weatherCurrentEntity?.cloud ?? "0"}%",
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                AutoRouter.of(context).replaceNamed("/calculatorScreen");
              },
              child: const Text(
                "Calculator Screen",
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 50)
          ],
        );
      },
    );
  }

  Widget _row({
    required String left,
    required String right,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            left,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          child: Text(
            right,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
