import 'package:flutter_forumavaliativo_consumindoapi/models/home_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController {
  String urlGet = "https://adc-nodejs-api.herokuapp.com/list_posts";

  List list = [];

  // read todos
  Future<List<Post>> readTodos() async {
    list = [];
    final response = await http.get(urlGet);
    final responseData = json.decode(response.body);
    for (var singleUser in responseData['post']) {
      Post post = await Post(
        sId: singleUser["_id"],
        title: singleUser["title"],
        content: singleUser["content"],
        createdAt: singleUser["createdAt"],
      );
      //Adding to the list.
      list.add(post);
    }
    return list.cast();
  }
}
