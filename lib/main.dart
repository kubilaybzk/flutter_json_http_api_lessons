import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_http_api_lessons/Http/Ders2.dart';
import 'package:flutter_json_http_api_lessons/Http/Ders3.dart';
import 'package:flutter_json_http_api_lessons/Lesson1/Lesson1.dart';
import 'package:flutter_json_http_api_lessons/Lesson2/Lesson2.dart';
import 'package:flutter_json_http_api_lessons/Lesson3/Lesson3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AnaSayfa());
  }
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter json lessons"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Lesson1()));
                  },
                  child: Text("Lesson1")),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Lesson2()));
                  },
                  child: Text("Lesson2")),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Lesson3()));
                  },
                  child: Text("Lesson3 (Tam kurs değil.)")),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 4,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Ders2()));
                  },
                  child: Text("API Kullanma")),
              SizedBox(
                height: 4,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ListApiKullanma()));
                  },
                  child: Text("Liste olarak API Kullanma"))
            ],
          ),
        ),
      ),
    );
  }
}
