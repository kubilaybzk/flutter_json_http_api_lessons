import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';

/*

Şimdi aşağıda oluşturduğumuz Listeyi build ederken kullamayı öğrenelim:

İlk önce bir Liste oluşturalım.
    Daha sonra bu listeye eleman aktarması yapalım.
      Önce State içine bir Liste tanımlayalım.
        Daha sonra initState altında widget oluşturulmadan önce atamanın olması için TumArabalar=Jsonoku()
            olarak atamanın yapılmasını sağlayalım.

        Tüm bunlara rağmen hata alacağız.
          Bu hatayı düzeltmek için ; 

*/

/*

class Lesson2 extends StatefulWidget {
  Lesson2({Key? key}) : super(key: key);

  @override
  _Lesson2State createState() => _Lesson2State();
}

class _Lesson2State extends State<Lesson2> {
  List TumArabalar = [];

  @override
  void initState() {
    // TODO: implement initState
    TumArabalar = JsonOku();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Ders2"),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(TumArabalar[index]['araba_adi']),
                );
              },
              itemCount: TumArabalar.length,
            )));
  }

  JsonOku() async {
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

*/

/*------------------------------------2.Kısım-------------------------------------------------------------------*/

/*
    1. Yöntem :

  void initState() {
    // TODO: implement initState
    TumArabalar = JsonOku();
  }
  Şimdi burada hata almamızın sebebi .
    Çözüm için yapmamız gereken;
        JsonOku adında oluşturduğumuz foksiyonun bize bir Future yollamasını sağlamak.
          Daha sonra yolladığı bu future değerini. init state altında Listeye çevirmek.

 void initState() {
    // TODO: implement initState
    JsonOku().then((value) { 
        TumArabalar = value;
    });
  }


  burada bulunan atamaları yapıyoruz fakat burada Flutter çook hızlı bir şekilde 
        buraya çalıştırıyor okurken widget oluşturuyor.
            Bunu çözmek için ;

                          void initState() {
              // TODO: implement initState
              JsonOku().then((value) {
                setState(() {
                  TumArabalar = value;
                });
              });
            }
            
                TumArabalar = value; kısmını setState içinde yazabiliriz.

*/

/*

class Lesson2 extends StatefulWidget {
  Lesson2({Key? key}) : super(key: key);

  @override
  _Lesson2State createState() => _Lesson2State();
}

class _Lesson2State extends State<Lesson2> {
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
              title: Text("Ders2"),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(TumArabalar[index]['araba_adi']),
                );
              },
              itemCount: TumArabalar.length,
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
*/

/*--------------------------------------------------------------------------------------------------------------*/

/*---------------------------------------3. Kısım--------------------------------------------------------------*/

/*

Normalde arka planda hata veriyor uygulama ilk çalışmada
      Biz her atama yaparken set state kullanarak bu işlemi çözdük aslında.
          Bunun için bir kaç kontrol ekleyebiliriz.

          Mesela Null ise dönen bir bar olsun gibi ..


*/

/*
class Lesson2 extends StatefulWidget {
  Lesson2({Key? key}) : super(key: key);

  @override
  _Lesson2State createState() => _Lesson2State();
}

class _Lesson2State extends State<Lesson2> {
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
              title: Text("Ders2"),
            ),
            body: TumArabalar != null
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(TumArabalar[index]['araba_adi']),
                      );
                    },
                    itemCount: TumArabalar.length,
                  )
                : Center(
                    child: CircularProgressIndicator(),
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


*/
/*--------------------------------------------------------------------------------------------------------------*/

/*---------------------------------------4. Kısım--------------------------------------------------------------*/

/*

FutureBuilder kullanarak düzeltebiliriz bu işlemleri.
  Future Builder Future olarak gönderilen değerleri ele alarak build yapan bir widget.
      iki adet gereksinim duyar bu widget
      builder: Build fonksiyonu
      future: Future olarak gönderilen eleman foksiyon vs..
    Eğer bunu yapıyorsak initstate içinde yapılanlara gerek yokk.



*/

class Lesson2 extends StatefulWidget {
  Lesson2({Key? key}) : super(key: key);

  @override
  _Lesson2State createState() => _Lesson2State();
}

class _Lesson2State extends State<Lesson2> {
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
              title: Text("Ders2"),
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
