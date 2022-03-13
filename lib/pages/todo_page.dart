import 'package:flutter/material.dart';
import 'package:flutter_forumavaliativo_consumindoapi/models/todolist_model.dart';
import 'package:flutter_forumavaliativo_consumindoapi/services/todo_service.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
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
        child: Column(
          children: <Widget>[
            TextField(
              controller: _todoTitleController,
              decoration: InputDecoration(
                  labelText: 'Title', hintText: 'Write Todo Title'),
            ),
            TextField(
              controller: _todoContentController,
              decoration: InputDecoration(
                  labelText: 'Content', hintText: 'Write Todo Content'),
            ),
            // TextField(
            //   controller: _todoDateController,
            //   decoration: InputDecoration(
            //     labelText: 'Date',
            //     hintText: 'Pick a Date',
            //     prefixIcon: InkWell(
            //       onTap: () {
            //         // _selectedTodoDate(context);
            //       },
            //       child: Icon(Icons.calendar_today),
            //     ),
            //   ),
            // ),
            // DropdownButtonFormField(
            //   value: _selectedValue,
            //   items: _categories,
            //   hint: Text('Category'),
            //   onChanged: (value) {
            //     setState(() {
            //       _selectedValue = value;
            //     });
            //   },
            // ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () => saveData(),
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
    );
  }

  //metodo postar dados!
  saveData() async {
    var todoObject = Post();

    todoObject.title = _todoTitleController.text;
    todoObject.content = _todoContentController.text;

    var _todoService = TodoService();
    var result = await _todoService.saveTodo(todoObject, context);

    if (result == true) {
      _showSuccessSnackBar(Text('Created'));
    }

    print(result);
  }
}
