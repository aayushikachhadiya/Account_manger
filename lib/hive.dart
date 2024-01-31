import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'controller.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);
  var box = await Hive.openBox('myBox');
  runApp(MaterialApp(home: hive1(),debugShowCheckedModeBanner: false,));
}
class hive1 extends StatefulWidget {
  const hive1({super.key});

  @override
  State<hive1> createState() => _hive1State();
}

class _hive1State extends State<hive1> {
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  Box box=Hive.box('myBox');
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Hive")),
    body:  Column(children: [
        TextField(
          controller: t1,
        ),
      TextField(
        controller: t2,
      ),
      ElevatedButton(onPressed: () {
        String name =t1.text;
        String contact=t2.text;
        controller c=controller(name, contact);
        box.add(c);
      }, child: Text("Add")),
      ElevatedButton(onPressed: () {
        
      }, child: Text("View"))
    ]),
    );
  }
}
