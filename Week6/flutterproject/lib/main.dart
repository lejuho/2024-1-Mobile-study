import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

String apiKey = "38dd257211fa38fd004451ca1fd1f593";
String cityName = "kor";
Response<dynamic>? response;

class _MyAppState extends State<MyApp> {
  final Dio dio = Dio();

  String apiCall =
      "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey";

  Future<void> fetchData() async {
    try {
      final res = await dio.get(apiCall);
      setState(() {
        response = res;
      }); // 화면을 다시 그리도록 상태 업데이트
    } catch (e) {
      print("데이터를 가져오는 중 오류 발생: $e");
      // 에러를 적절히 처리하세요
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Pretendard',
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "GDSC 모바일 스터디",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.black,
                  height: 0.5,
                ),
                SizedBox(
                  height: 1,
                ),
                ElevatedButton(
                    onPressed: fetchData,
                    child: const Text("날씨 API 받기!!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black))),
                if (response != null)
                  Column(
                    children: [
                      Text(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          "기온 : ${response!.data?['main']['temp'] ?? "No Data~"}"),
                      Text(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          "습도 : ${response!.data?['main']['humidity'] ?? "No Data~"}"),
                      Text(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          "기압 : ${response!.data?['main']['pressure'] ?? "No Data~"}"),
                      Text(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          "풍속 : ${response!.data?['wind']['speed'] ?? "No data~"}"),
                    ],
                  ),
                if (response == null)
                  const Column(
                    children: [
                      Text(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          "기온 : No Data~"),
                      Text(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          "습도 : No Data~"),
                      Text(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          "기압 : No Data~"),
                      Text(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          "풍속 : No data~"),
                    ],
                  ),
              ],
            ),
          ),
        ));
  }
}
