import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'models/model.dart';
import 'services/weather_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Dio dio = Dio()..interceptors.add(PrettyDioLogger());
  final String apiKey = "38dd257211fa38fd004451ca1fd1f593";
  final String cityName = "Seoul";
  late WeatherService weatherService;
  Model? weatherData;

  @override
  void initState() {
    super.initState();
    weatherService = WeatherService(dio);
  }

  Future<void> fetchData() async {
    try {
      final data = await weatherService.getWeather(cityName, apiKey);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      print("에러: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("날씨"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (weatherData != null) ...[
                Text("기온: ${weatherData!.main.temp}"),
                Text("습도: ${weatherData!.main.humidity}"),
                Text("기압: ${weatherData!.main.pressure}"),
                Text("풍속: ${weatherData!.wind.speed}"),
              ] else ...[
                Text("~데이터 없음"),
              ],
              ElevatedButton(
                onPressed: fetchData,
                child: Text("날씨 불러오기!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
