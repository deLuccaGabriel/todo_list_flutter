import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Todo-List",
        home: const MyHome(),
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.blueAccent),
        ));
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }
}

class MyHomeState extends State<MyHome> {
  final TextEditingController taskController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                    controller: taskController,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black87,
                    ),
                    decoration: const InputDecoration(
                        hintText: "Type a new task here",
                        hintStyle: TextStyle(fontSize: 22),
                        errorStyle: TextStyle(fontSize: 16)),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Task field cannot be empty!";
                      }
                    },
                  )),
                  Container(
                    margin: const EdgeInsets.only(left: 22),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[300],
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        debugPrint("Click");
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _tasks.add(taskController.text);
                          });
                          debugPrint(taskController.text);
                          taskController.clear();
                        } else {
                          debugPrint("Task field cannot be empty!");
                        }
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      _tasks.removeAt(index);
                    });
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(_tasks[index]),
                    ),
                  ),
                );
              },
              itemCount: _tasks.length,
            ))
          ],
        ),
      ),
    );
  }
}
