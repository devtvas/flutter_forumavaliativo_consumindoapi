import 'package:flutter/material.dart';
import 'package:flutter_forumavaliativo_consumindoapi/controllers/home_controller.dart';
import 'package:flutter_forumavaliativo_consumindoapi/main.dart';
import 'package:flutter_forumavaliativo_consumindoapi/models/home_model.dart';
import 'package:intl/intl.dart';

import 'todo_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<Post>> _value;
  // List<Post> initialData = [];
  NumberFormat f = new NumberFormat("00");

  HomeController _homeController = HomeController();

  @override
  initState() {
    super.initState();
    _value = _homeController.getValue();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(
          title: Text("Doing Get"),
          leading: Icon(
            Icons.code,
            size: 30,
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _value = _homeController.getValue();
                });
              },
              icon: Icon(
                Icons.refresh,
                size: 30,
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: _value.asStream(),
            // initialData: initialData,
            builder: (context, snapshot) {
              print(snapshot.connectionState);

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Visibility(
                      visible: true,
                      child: Text(
                        'Forum Avaliativo',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    )
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: const Text('Error'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      // itemCount: snapshot.data.length,
                      // itemBuilder: (ctx, index) =>
                      itemCount: snapshot.data.length,
                      itemBuilder: (ctx, index) {
                        String string = snapshot.data[index].title;
                        String char = string.substring(0, 1);

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(child: Text(char)),
                              title: Text(
                                "Consumidor: ${snapshot.data[index].title}",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  "Bebida favorita: ${snapshot.data[index].content}"),
                              contentPadding: EdgeInsets.only(bottom: 20.0),
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(child: const Text('Empty data'));
                }
              } else {
                return Center(
                    child: Text('State: ${snapshot.connectionState}'));
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => new TodoView())),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
