import 'package:flutter/material.dart';
import 'package:flutter_forumavaliativo_consumindoapi/models/home_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoController {
  final String urlPost = 'https://adc-nodejs-api.herokuapp.com/create_posts/';
  Post _retTodo;
  //camada de negocio
  savetodoController(String title, String content, dynamic context) async {
    Post todoObject = Post();

    todoObject.title = title;
    todoObject.content = content;

    // var result = await todoObject;

    // if (result == true) {
    //   _showSuccessSnackBar(Text('Created'));
    // }

    saveTodoService(todoObject, context);
  }

  // camada de servico
  Future<Post> saveTodoService(Post post, dynamic context) async {
    try {
      final response =
          await http.post(await urlPost + post.title + post.content);
      if (response.statusCode == 200) {
        var descodeJson = jsonDecode(response.body);
        _retTodo = Post.fromJson(descodeJson);
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
    return _retTodo;
  }
  // read todos by category
  // readTodosByCategory(category) async {
  //   return await _repository.readDataByColumnName(
  //       'todos', 'category', category);
  // }
}
