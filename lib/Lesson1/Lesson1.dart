import 'package:flutter/material.dart';
import 'dart:convert';

class Lesson1 extends StatefulWidget {
  Lesson1({Key? key}) : super(key: key);

  @override
  _Lesson1State createState() => _Lesson1State();
}

class _Lesson1State extends State<Lesson1> {
  @override
  Widget build(BuildContext context) {
    JsonOku();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: Text("KAYNAK KODLARINI İNCELE ! ")),
        ));
  }

/*
Şimdi öncelikle yapmamız gerekenler ilk önce 
Json dosyasını dönüştürebilmemiz için bir kütüphane import etmemiz gerekiyor.
*/

/*Daha sonra gelen bilgileri düzenleyebilmemiz için 
    bir fonksiyon yazmamız gerekmekte.
          Bunun için ;
*/

  JsonOku() async {
    /*
  Öncelikle amacımız json dosyasına erişmek bunun için 
  DefaultAssetBundle isminde bir yöntem kullnabiliriz.
        Şimdi 
        Future<String> Jsongelenveri =
        DefaultAssetBundle.of(context).loadString('assets/data/araba.json');
            Şeklinde Dosyayı okuyoruz Daha sonra

        .then kullanarak okunan dosyanın yazılmasını istiyoruz.
  */
    Future<String> Jsongelenveri =
        DefaultAssetBundle.of(context).loadString('assets/data/araba.json');

    Jsongelenveri.then((value) {
      debugPrint(value);
      return value;
    });

    /*
        Fakat burada veri okunurken build işlemi yapılıyor.
        Fakat biz direk json olarak verileri istemiyoruz.
            Ama okuma işlemi uzan sürecek bunun sonucununda beklenmesini istiyoruz.
              Bunu sağlamak için ; 
                          async kullanabiliriz.
                        

    */

    var gelenJSONdegeri = await DefaultAssetBundle.of(context)
        .loadString('assets/data/araba.json');

    /*
    Şimdi bir üstte bulunnan yorum satırında bahsettiklerimi
    başarı ile yaptık ama biz bu verileri çevirmek istiyoruz.
    O zaman  jsonDecode kullanarak string olarak gelen değerleri 
    alıp ArabaListesi adında bir listeye atalım.

    */
    List ArabaListesi = jsonDecode(gelenJSONdegeri);
    debugPrint("Toplam Araba Sayısı" + ArabaListesi.length.toString());
    for (int i = 0; i < ArabaListesi.length; i++) {
      debugPrint("Markanın adı : " + ArabaListesi[i]['araba_adi']);
    }
    return ArabaListesi;
  }
}
