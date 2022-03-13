import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_forumavaliativo_consumindoapi/models/todolist_model.dart';
import 'package:flutter_forumavaliativo_consumindoapi/services/todo_service.dart';
import 'package:http/http.dart' as http;

import 'todo_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _todoService = TodoService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Doing Get"),
          leading: Icon(
            Icons.code,
            size: 30,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: _todoService.readTodos(),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TodoPage())),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
