import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioProvider {
  @singleton
  Dio dio() {
    Dio dio = Dio();
    return dio;
  }
}
