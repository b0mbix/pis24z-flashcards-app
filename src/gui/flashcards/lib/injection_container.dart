import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<Dio>(_createDio);
}

Dio _createDio() {
  final dio = Dio(BaseOptions(
    //baseUrl: "https://api.sampleapis.com/baseball", //MOCK
    baseUrl: "http://127.0.0.1:8000/", // Replace with your backend URL

  ));
  return dio;
}


