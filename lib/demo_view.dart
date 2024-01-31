import 'dart:io';
import 'package:database/demo.dart';
import 'package:database/image_piker_view.dart';
import 'package:flutter/material.dart';

class demo_view extends StatefulWidget {
  const demo_view({super.key});

  @override
  State<demo_view> createState() => _demo_viewState();
}

class _demo_viewState extends State<demo_view> {
  File?file;
  List l=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  bool s=false;
  List name=[];
  List t_name=[];
  get()
  async {

    String select="select * from Test";
     demo.database!.rawQuery(select).then((value) {
      l=value;
      for(int i=0;i<value.length;i++)
      {
        name.add(value[i]['name']);
      }
      t_name=name;
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            s=!s;
            setState(() {
            });

          }, icon: (s)?Icon(Icons.close):Icon(Icons.search))

        ],
        title:(s)?TextField(
          cursorColor: Colors.white,
          onChanged: (value) {
          name=t_name.where((element) => element.toString().startsWith(value)).toList();
            setState(() {
            });
          },
        ):Text("")
      ),
      body: ListView.builder(itemCount:name.length,
        itemBuilder: (context, index) {
        String image="${demo.dir!.path}/${l[index]['image']}";
        file=File(image);
        int index1=t_name.indexOf(name[index]);
          return Card(child: ListTile(
            title: Text("${l[index1]['name']}"),
            subtitle: Text("${l[index1]['contect']}"),
            leading: CircleAvatar(
              backgroundImage: FileImage(file!),
            ),
            trailing: Wrap(
              children: [
                IconButton(onPressed: () {
                  String dele="delete from Test where id=${l[index1]['id']} ";
                  demo.database!.rawUpdate(dele);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return demo_view();
                  },));

                  setState(() {});
                }, icon: Icon(Icons.delete)),
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return demo(l[index1]);
                  },));

                }, icon: Icon(Icons.edit))
              ],
            ),
          ),);
        },),
    );
  }
}
