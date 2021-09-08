/*
Şimdi öncelikle bir veri çekmek istiyorsak bir json dosyası okumak istiyorsak yapmamız gerkeenler .
    İlk önce 
      iki adet kütüphane import etmemiz gerekir.
           Kütüphanemiz.
            import 'package:http/http.dart' as http;
              import 'dart:convert'; //Dataları çevirmek için kullanılan bir paket.


*/
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/*
iNTERNETTEN ALINAN BÜTÜN VERİLER STRİNG DEĞERİNDEDİR. 
Şimdi biz https://jsonplaceholder.typicode.com
sitesinden sadece tek bir tane json objesi alalım.
https://jsonplaceholder.typicode.com/posts/1
bu biizm objemiz .
Bunu kullanmak için bizim bir nesne üretmemiz gerekiyor.
Yani bir class oluşturmalıyız.

Ya başka bir klasör içinde yada burada oluşturarabiliriz.

  Biz bir bu dosyanın içinde oluşturalım.


*/

class Post {
  /*

{
  "userId": 1,
  "id": 1,
  "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
  "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
}
Json dosyamız üst tarafta bulunan bilgilerden oluşmakta.

  O zaman bu bilgileri tek tek eleman olarak yazalım.
  */

  int userId;
  int id;
  String title;
  String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

/*
Diyoruz ki biz sana bir json dosyası vericez bunu
    şuradaki elemenalara göre düzenleyen bir foksiyon oluştur ve oluşan
    bu fonksiyonları tek tek eleman olarak bir Post objesi olarak yolla

*/
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json['body']);
  }
}

Future<Post> veriAl() async {
  /*
    Burada amacımız json dosyalarına ulaşacak bir fonksiyon yazmak.
    Burada http olarak adlandırdığımız kütüphanenin fonksiyonlarını
    kullanarak diyoruz ki git bize bir json elemanını al ve 
      o elemanları bize getir.
      Bunun için ;


    */
  String url = "https://jsonplaceholder.typicode.com/posts/1"; //Url adresimiz
  var cevap = await http.get(
    Uri.parse(url),
  ); //http kütüphanesini kullanarak Bilgilere ulaşmaya çalışıyoruzi
  if (cevap.statusCode == 200) {
    /*
    Bildiğimiz gibi bir çok hata kodu var websitelerinde 404 gibi gibi...
    Bunu internette araştırarak basit bir şekilde bulabilirsiniz 200 olumlu cevap demek diyebiliriz
    kısca şimdi burada if else yapısı kullanarak fonksiyonumuzu oluşturalım.

     Şimdi burada gelen  cevap olumlu ise bu işlemleri yap diyoruz. */

    /* Genel ve basit olarak alatmak gerekirse 
      return bir  post objesi oluşturuyor ama json'dan gelen bir post objesi yani
      yukarıda bizim yazdığımız method diyebiliriz.
       Daha sonra bu Post objesinin required bilgilerini tanımlamak için json dosyasının dönüşmesi gerekiyor.
       Bu dönüşümü yapmak için json.decode ( convert kütüphanesini burada kullanıyoruz. ) foksiyonunu kullanıyoruz.

      Json dosyasından bize bir çok bilgi gelir headerlar gibi ...
      Burada biz sadece body kısmını kullanmak istiyoruz yani bilgilerin
      bulunduğu kısmı . 
      Bunu return eden bir method geliştiriyoruz.

      */
    return Post.fromJson(json.decode(cevap.body));
  } else {
    return throw Exception("Hata ");
  }
  /*
    Şimdi bilgileri aldık bunları Obje olarak aktardık.
    Peki bunu widgetlara nasıl aktaracağız 
      o  zaman bizim FutureBuilder diye bir widgetımız var bunu
      kullanmamız gerekiyor.

    */
}
/*


*/

class Ders2 extends StatefulWidget {
  Ders2({Key? key}) : super(key: key);

  @override
  _Ders2State createState() => _Ders2State();
}

class _Ders2State extends State<Ders2> {
  late String _gelenText;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text("Genel Tekrar")),
          body: Center(
              /*
              Future builder kullanmak için
              yapmamız gereken future yollayan bir fonksiyon
              bir tanede builder kullanmak.
              Builder kullanırken (context,index) olarak elemanlar oluşturuduk.
              Şimdi burada o anlık bilgi o anlık gelen post  olarak
              düşünerek gendelde snapshot olarak dosyalar Future builder'a aktarılır.

            */
              child: FutureBuilder<Post>(
                  future: veriAl(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //Snapshot değişkeni eğer bilgi getiriyor ise.
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Gelen İD     : " +
                                snapshot.data!.id.toString()),
                            Text("Gelen userId : " +
                                snapshot.data!.userId.toString()),
                            Text("Gelen title  : " + snapshot.data!.title),
                            Text("Gelen body   : " + snapshot.data!.body),
                          ],
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  })),
        ));
  }
}
