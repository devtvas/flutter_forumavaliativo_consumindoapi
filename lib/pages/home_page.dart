import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_forumavaliativo_consumindoapi/src/models/todolist_model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List list = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Forum Avaliativo"),
          leading: Icon(
            Icons.code,
            size: 30,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: getRequest(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) => Card(
                    child: ListTile(
                      title: Text(snapshot.data[index].title),
                      // subtitle: Text(snapshot.data[index].sId),
                      subtitle: Text(snapshot.data[index].createdAt),
                      contentPadding: EdgeInsets.only(bottom: 20.0),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  //metodo get
  Future<List<Post>> getRequest() async {
    list = [];
    String url = "https://adc-nodejs-api.herokuapp.com/list_posts";
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    for (var singleUser in responseData['post']) {
      Post post = await Post(
        sId: singleUser["_id"],
        title: singleUser["title"],
        content: singleUser["content"],
        createdAt: singleUser["createdAt"],
      );
      //Adding user to the list.
      list.add(post);
    }
    return list.cast();
  }
}
