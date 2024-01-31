import 'package:database/sql.dart';
import 'package:flutter/material.dart';

class view extends StatefulWidget {
  const view({super.key});

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  List l=[];
  bool temp = false;
  get_data()
  async {
    String qry="select * from Con";
    l=await Home.database!.rawQuery(qry);
    temp = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("View contect")),
      body:FutureBuilder(future: get_data(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
          {
            return ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text("${l[index]['name']}"),
                  subtitle: Text("${l[index]['contact']}"),
                  trailing: Wrap(children: [
                    IconButton(onPressed: () {
                      String qry="delete from Con where id=${l[index]['id']}";
                      Home.database!.rawDelete(qry);
                      setState(() {

                      });
                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Home(l[index]);
                      },));

                    }, icon: Icon(Icons.edit))
                  ],)
                  
                ),
              );
            },);
          }else
            {
              return CircularProgressIndicator();
            }
      },)
    );
  }
}
