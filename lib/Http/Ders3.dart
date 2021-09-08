import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListApiKullanma extends StatefulWidget {
  ListApiKullanma({Key? key}) : super(key: key);

  @override
  ListApiKullanmaState createState() => ListApiKullanmaState();
}

class Post {
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

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json['body']);
  }
}

Future<List<Post>> _gonderiGetir() async {
  String url = "https://jsonplaceholder.typicode.com/posts"; //Url adresimiz
  var response = await http.get(
    Uri.parse(url),
  );

  if (response.statusCode == 200) {
    //return Gonderi.fromJsonMap(json.decode(response.body));
    return (json.decode(response.body) as List)
        .map((tekGonderiMap) => Post.fromJson(tekGonderiMap))
        .toList();
  } else {
    throw Exception("Baglanamadık ${response.statusCode}");
  }
}

class ListApiKullanmaState extends State<ListApiKullanma> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Liste olarak bilgi alma"),
          ),
          body: Center(
            child: FutureBuilder(
                future: _gonderiGetir(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].title.toString()),
                        subtitle: Text(snapshot.data![index].body.toString()),
                        trailing: CircleAvatar(
                          child: Text(snapshot.data![index].id.toString()),
                        ),
                        leading: CircleAvatar(
                          child: Text(snapshot.data![index].userId.toString()),
                        ),
                      );
                    });
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          )),
    );
  }
}
