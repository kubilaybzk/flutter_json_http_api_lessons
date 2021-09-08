import 'dart:convert';

import 'package:flutter/material.dart';

class Lesson3 extends StatefulWidget {
  Lesson3({Key? key}) : super(key: key);

  @override
  _Lesson3State createState() => _Lesson3State();
}

class _Lesson3State extends State<Lesson3> {
  List TumArabalar = [];

  @override
  void initState() {
    // TODO: implement initState
    JsonOku().then((value) {
      setState(() {
        TumArabalar = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Ders3"),
            ),
            body: Center(
              child: FutureBuilder(
                builder: (context, sonuc) {
                  if (sonuc.hasData) {
                    TumArabalar = sonuc.data as List;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(TumArabalar[index]['araba_adi']),
                          subtitle: Text(TumArabalar[index]['ulke']),
                        );
                      },
                      itemCount: TumArabalar.length,
                    );
                  } else {
                    return Container(child: CircularProgressIndicator());
                  }
                },
                future: JsonOku(),
              ),
            )));
  }

  Future JsonOku() async {
    var gelenJSONdegeri = await DefaultAssetBundle.of(context)
        .loadString('assets/data/araba.json');

    List ArabaListesi = jsonDecode(gelenJSONdegeri);
    //debugPrint("Toplam Araba Sayısı" + ArabaListesi.length.toString());
    for (int i = 0; i < ArabaListesi.length; i++) {
      //debugPrint("Markanın adı : " + ArabaListesi[i]['araba_adi']);
    }
    return ArabaListesi;
  }
}
