import 'package:flutter/material.dart';
import 'package:flutter_forumavaliativo_consumindoapi/models/todolist_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoService {
  String urlGet = "https://adc-nodejs-api.herokuapp.com/list_posts";
  final String urlPost = 'https://adc-nodejs-api.herokuapp.com/create_posts/';
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

  // create todos
  Future<Post> saveTodo(Post post, dynamic context) async {
    try {
      final response =
          await http.post(await urlPost + post.title + post.content);
      if (response.statusCode == 200) {
        var descodeJson = jsonDecode(response.body);
        dynamic _retTodo = Post.fromJson(descodeJson);
        return _retTodo;
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error 404'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error ao enviar Mensagem! ${e}'),
        ),
      );
    }
  }
  // read todos by category
  // readTodosByCategory(category) async {
  //   return await _repository.readDataByColumnName(
  //       'todos', 'category', category);
  // }
}
