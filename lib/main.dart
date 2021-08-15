import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  List<String>? todo;
  // save todo
  saveTODO() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> lstTodo = [];
    if(todo != null){
      lstTodo.addAll(todo!);
    }
    lstTodo.add(textEditingController.text);
    prefs.setStringList('rean_it_todo', lstTodo);
    clearTextField();
    getTODO();

  }
  getTODO() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todo = prefs.getStringList('rean_it_todo');
      if(todo == null ){
        todo = [];
      }
    });
  }

  clearTextField(){
    textEditingController.text = '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTODO();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: "Todo"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextButton(onPressed: () {
                saveTODO();
              }, child: Text("Save")),
            ),
            Text(
              "List Todo",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            // show todo
            // Text(todo == null ? "No todo available" : todo!),
           Container(
             height: 300,
             width: double.infinity,
             child:  ListView.builder(
               itemCount: todo == null ? 0 :  todo!.length,
               itemBuilder: (context,index){
                 return Card(
                   child: ListTile(
                     title: Text(todo![index]),
                   ),
                 );
               },
             ),
           ),
          ],
        ),
      ),
    );
  }
}
