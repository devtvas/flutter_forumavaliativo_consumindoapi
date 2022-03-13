import 'package:flutter/material.dart';
import 'package:flutter_forumavaliativo_consumindoapi/controllers/home_controller.dart';
import 'package:flutter_forumavaliativo_consumindoapi/models/home_model.dart';

import 'todo_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<Post>> _value;
  List<Post> initialData = [];
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
            future: _value,
            // initialData: initialData,
            builder:
                (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
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
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TodoView())),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
