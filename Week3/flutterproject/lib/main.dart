// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w900),
          bodyMedium: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w900),
        ),
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.black,
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "GDSC 모바일 스터디"),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
          centerTitle: false,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(4.0),
              child: Container(color: Colors.grey, height: 1.0)),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(width: 18),
              Text(
                "과제",
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: Size(150, 150),
                    backgroundColor: Colors.white),
                child: Column(children: [
                  Text(
                    "오늘의 과제",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 15),
                  Icon(
                    color: Colors.black,
                    Icons.book_outlined,
                    size: 60,
                  )
                ])),
            SizedBox(width: 30),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: Size(150, 150),
                    backgroundColor: Colors.white),
                child: Column(children: [
                  Text(
                    "수행한 과제",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 15),
                  Icon(
                    color: Colors.black,
                    Icons.collections_bookmark,
                    size: 60,
                  )
                ])),
          ]),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 18),
              Text(
                "나의 수행도",
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
          SizedBox(
            width: 370,
            height: 350,
            child: TableCalendar(
              firstDay: DateTime.utc(2024, 4, 1),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.month,
              onPageChanged: (d) {
                print(d.month.toString());
              },
              availableCalendarFormats: {CalendarFormat.month: 'Month'},
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              SizedBox(width: 18),
              Text(
                "나의 다짐",
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              SizedBox(width: 18),
              Text(
                "과제를 모두 죽이겠다.그르르르",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ]));
  }
}
