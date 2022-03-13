import 'package:flutter/material.dart';
import 'package:flutter_forumavaliativo_consumindoapi/models/home_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoController {
  final String urlPost = 'https://adc-nodejs-api.herokuapp.com/create_posts/';
  Post _retTodo;
  dynamic _retSucesso;
  //camada de negocio
  savetodoController(String title, String content, dynamic context) async {
    Post todoObject = Post();

    todoObject.title = title;
    todoObject.content = content;

    // var result = await todoObject;

    // if (result == true) {
    //   _showSuccessSnackBar(Text('Created'));
    // }

    // saveTodoService(todoObject, context);
    saveTodoService(todoObject, context).then((value) {
      if (value == 'OK') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Salvo com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  // camada de servico
  Future<String> saveTodoService(Post post, dynamic context) async {
    try {
      final response = await http.post(
        await urlPost,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(post),
      );
      if (response.statusCode == 200) {
        // var descodeJson = jsonDecode(response.body);
        _retSucesso = response.reasonPhrase;
        // _retTodo = Post.fromJson(descodeJson);
        return _retSucesso;
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
    return _retSucesso;
  }
  // read todos by category
  // readTodosByCategory(category) async {
  //   return await _repository.readDataByColumnName(
  //       'todos', 'category', category);
  // }
}
