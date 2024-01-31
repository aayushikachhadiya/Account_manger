import 'dart:io';

import 'package:database/image_piker.dart';
import 'package:flutter/material.dart';

class view extends StatefulWidget {
  const view({super.key});

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  List<Map>l=[];
  List name=[];
  List t_name=[];
  File?file;
  bool s=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  get()
  {
       String sql="select * from login";
       image_piker.database!.rawQuery(sql).then((value) {
         l=value;
         for(int i=0;i<value.length;i++)
           {
                 name.add(value[i]['name']);
           }
         t_name=name;
         print(l);
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
        title: (s)?TextField(
          cursorColor: Colors.white,
          onChanged: (value) {
             name=t_name.where((element) => element.toString().startsWith(value)).toList();
             setState(() {

             });
          },
        ):Text("")
      ),
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context, index) {
        String img_path="${image_piker.dir!.path}/${l[index]['image']}";
        file=File(img_path);
          int index1=t_name.indexOf(name[index]);
         return Card(child: ListTile(
           title: Text("${l[index1]['name']}"),
           subtitle: Text("${l[index1]['contact']}"),
           leading: CircleAvatar(
             backgroundImage: FileImage(file!),
           ),
           trailing: Wrap(
             children: [
               IconButton(onPressed: () {
                 String qry =
                     "delete from login where id=${l[index1]['id']}";
                 image_piker.database!.rawDelete(qry);
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                   return view();
                 },));
                 setState(() {});
               }, icon: Icon(Icons.delete)),
               IconButton(onPressed: () {
                 Navigator.push(context, MaterialPageRoute(
                   builder: (context) {
                     return image_piker(l[index1]);
                   },
                 ));
               }, icon: Icon(Icons.edit))
             ],
           ),
         ),);
      },),
    );
  }
}
