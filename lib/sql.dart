

import 'package:database/view.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}
class Home extends StatefulWidget {
 static Database? database;
  Map ? m;
  Home([this.m]);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();

  get() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    Home.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE Con (id INTEGER PRIMARY KEY, name TEXT, contact TEXT,city TEXT)');

        });
    if(widget.m!=null){
      t1.text = widget.m!['name'];
      t2.text = widget.m!['contact'];
      t3.text = widget.m!['city'];
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();

  }
  Widget text(String str,TextEditingController t)
  {
    return TextField(
      controller: t,
      decoration: InputDecoration(hintText:str ,border: OutlineInputBorder()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: (widget.m!=null)?Text("update contact"):Text("add record")),
      body: Column(
        children: [
          text("Enter name", t1),
          text("Enter contect", t2),
          text("Enter city", t3),
          ElevatedButton(
              onPressed: () {
                String name=t1.text;
                String contact=t2.text;
                String city=t3.text;
               if(widget.m!=null)
                 {
                      String qry="update Con set name='$name',contact='$contact',city='$city' where id=${widget.m!['id']}";
                      Home.database!.rawUpdate(qry);
                 }else
                   {
                     String sql = "insert into Con values(null,'$name','$contact','${t3.text}')";
                     print(sql);
                     Home.database?.rawInsert(sql).then((value) {
                       print(value);
                     });
                   }
              },
              child: Text("add")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return view();
                },));
                setState(() {});
              },
              child: Text("View"))
        ],
      ),
    );
  }
}