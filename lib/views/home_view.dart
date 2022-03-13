import 'package:flutter/material.dart';
import 'package:flutter_forumavaliativo_consumindoapi/controllers/home_controller.dart';

import 'todo_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController _homeController = HomeController();

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
            future: _homeController.readTodos(),
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
              .push(MaterialPageRoute(builder: (context) => TodoView())),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
