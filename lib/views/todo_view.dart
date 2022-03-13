import 'package:flutter/material.dart';
import 'package:flutter_forumavaliativo_consumindoapi/controllers/todo_controller.dart';

class TodoView extends StatefulWidget {
  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  TodoController _todoController = TodoController();

  var _todoTitleController = TextEditingController();

  var _todoContentController = TextEditingController();

  var _todoDateController = TextEditingController();

  var _selectedValue;

  var _categories = List<DropdownMenuItem>();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // _loadCategories();
  }

  // _loadCategories() async {
  //   var _categoryService = CategoryService();
  //   var categories = await _categoryService.readCategories();
  //   categories.forEach((category) {
  //     setState(() {
  //       _categories.add(DropdownMenuItem(
  //         child: Text(category['name']),
  //         value: category['name'],
  //       ));
  //     });
  //   });
  // }

  DateTime _dateTime = DateTime.now();

  // _selectedTodoDate(BuildContext context) async {
  //   var _pickedDate = await showDatePicker(
  //       context: context,
  //       initialDate: _dateTime,
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime(2100));

  //   if (_pickedDate != null) {
  //     setState(() {
  //       _dateTime = _pickedDate;
  //       _todoDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
  //     });
  //   }
  // }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Doing Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _todoTitleController,
                  decoration: InputDecoration(
                      labelText: 'Consumidor',
                      hintText: 'Escreva aqui seu nome'),
                ),
                TextField(
                  controller: _todoContentController,
                  decoration: InputDecoration(
                      labelText: 'Bebida',
                      hintText: 'Nome da sua cerveja preferida'),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () => _todoController.savetodoController(
                      _todoTitleController.text,
                      _todoContentController.text,
                      context),
                  // onPressed: () {},
                  color: Colors.blue,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
