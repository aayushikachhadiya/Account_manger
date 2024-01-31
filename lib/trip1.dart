 import 'package:database/trip_mamber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main()
 {
   runApp(MaterialApp(home: trip1(),debugShowCheckedModeBanner: false,));
 }
 class trip1 extends StatefulWidget {
  static Database ?database;
   const trip1({super.key});

   @override
   State<trip1> createState() => _trip1State();
 }

 class _trip1State extends State<trip1> {
   TextEditingController t1=TextEditingController();
   TextEditingController t2=TextEditingController();
  List <Map> l=[];
  List <Map> li=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    t2.text =
    "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

  }
  get()
  async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'tour_infos.db');
// open the database
   trip1.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE tourinfo (id INTEGER PRIMARY KEY, name TEXT, start_date TEXT, end_date TEXT)');
          await db.execute(
              'CREATE TABLE member (id INTEGER PRIMARY KEY, name TEXT, contect TEXT, t_id INTEGER)');
          await db.execute(
              'CREATE TABLE expence_info (id INTEGER PRIMARY KEY, name TEXT, amount TEXT,date TEXT, m_id INTEGER)');
        });
    String qry="SELECT * FROM tourinfo";
    l= await trip1.database!.rawQuery(qry);
    String sql="SELECT * FROM member";
    li= await trip1.database!.rawQuery(sql);
print(li);
    setState(() {

    });
  }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text("Trip manger"),
         backgroundColor: Colors.indigo,
       ),
       body: Column(
         children: [
          Expanded(child: Container(
            child:ListView.builder(itemCount: l.length,itemBuilder: (context, index) {

              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return trip_mamber(l[index]);
                  },));
                },
                child: Card(
                  child: ListTile(
                    title: Text("${l[index]['name']}"),
                    trailing: Text("${l[index]['start_date']}"),
                  ),
                ),
              );
            },)
          )),
           Expanded(flex: 1,child: Text("")),
           InkWell(
             onTap: () {
               showDialog(
                   context: context,
                   builder: (context) {
                 return AlertDialog(
                   actions: [
                     Container(alignment: Alignment.center,
                         margin: EdgeInsets.only(bottom: 10),
                         child: Text("Add new Trip",
                             style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold)),
                         color: Colors.indigo,
                         height: 50,
                         width: double.infinity),
                     TextField(
                       controller: t1,
                       decoration: InputDecoration(
                         labelText: "Trip name",
                       ),
                     ),
                     TextField(
                       controller: t2,
                     ),
                     Row(
                       mainAxisAlignment:
                       MainAxisAlignment.spaceEvenly,
                       children: [
                         Expanded(
                           child: InkWell(
                             onTap: () {
                               Navigator.pop(context);
                               setState(() {});
                             },
                             child: Container(
                               alignment: Alignment.center,
                               margin: EdgeInsets.all(5),
                               height: 40,
                               width: double.infinity,
                               child: Text("Cancle",
                                   style: TextStyle(
                                       fontSize: 20,
                                       color: Colors.indigo)),
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius:
                                   BorderRadius.circular(20),
                                   border: Border.all(
                                       color: Colors.indigo,
                                       width: 2)),
                             ),
                           ),
                         ),
                         Expanded(
                           child: InkWell(
                             onTap: () {
                               get();
                               String name = t1.text;
                               String sql =
                                   "INSERT INTO tourinfo VALUES(null,'$name','${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}','${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}')";
                               print(sql);
                               trip1.database!.rawInsert(sql)
                                   .then((value) {
                                 print(value);
                               });
                               Navigator.pop(context);
                               setState(() {});
                               t1.text = "";
                             },
                             child: Container(
                               alignment: Alignment.center,
                               margin: EdgeInsets.all(5),
                               height: 40,
                               width: double.infinity,
                               child: Text("Save",
                                   style: TextStyle(
                                       fontSize: 20,
                                       color: Colors.white)),
                               decoration: BoxDecoration(
                                   color: Colors.indigo,
                                   borderRadius:
                                   BorderRadius.circular(20),
                                   border: Border.all(
                                       color: Colors.indigo,
                                       width: 2)),
                             ),
                           ),
                         )
                       ],
                     )
                   ],
                 );
               },);
             },
             child: Container(
               margin: EdgeInsets.only(left: 320,bottom: 20),
               height: 50,
               width: 50,
               alignment: Alignment.center,
               decoration: BoxDecoration( color: Colors.indigo,borderRadius: BorderRadius.circular(30)),
               child: Text("+",style: TextStyle(color: Colors.white,fontSize: 30)),
             ),
           )
         ],
       ),
     );
   }
 }
