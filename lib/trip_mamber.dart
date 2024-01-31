import 'package:database/expence.dart';
import 'package:database/image_piker.dart';
import 'package:database/trip1.dart';
import 'package:flutter/material.dart';

class trip_mamber extends StatefulWidget {
  Map? m;

  trip_mamber([this.m]);

  @override
  State<trip_mamber> createState() => _trip_mamberState();
}

class _trip_mamberState extends State<trip_mamber> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  List l = [];
  List sum = [];
  int cnt = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  int t = 0;
  List amount = [];

  get() async {
    String qry = "SELECT * FROM member where t_id=${widget.m!['id']}";
    l = await trip1.database!.rawQuery(qry);
    amount = List.filled(l.length, 0);
    for (int i = 0; i < l.length; i++) {
      String sum_amount = "SELECT SUM(amount) FROM expence_info where m_id=${l[i]['id']}";
      sum = await trip1.database!.rawQuery(sum_amount);
      if(sum[0]['SUM(amount)']!=null){
        amount[i] = sum[0]['SUM(amount)'];
      }
    }
    int sums = 0;
    int s = 0;
    for (int i = 0; i < amount.length; i++) {
      if (amount[i] != null) {
        s = amount[i];
        sums += s;
        t = sums;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.m!['name']}-${t}"),
        backgroundColor: Colors.indigo,
      ),

      body: Column(children: [
        Expanded(
            flex: 5,
            child: Container(
                child: ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return expence(l[index], widget.m!);
                      },
                    ));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                          "${l[index]['name']}-${(amount[index] != null) ? amount[index] : "0"}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      trailing: Text("${l[index]['contect']}"),
                      subtitle: Row(children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            height: 70,
                            child: Text(
                                "Gived money\n ${(amount[index] != null) ? amount[index] : "0"}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            height: 70,
                            child: Text("Expence\n ${(t / l.length).toInt()}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 70,
                            child: Text(
                              "Total\n${amount[index]-(t/l.length).toInt()}",
                                style: TextStyle(
                                    fontSize: 15, color: (0>amount[index]-(t/l.length).toInt())?Colors.red:Colors.green)
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              },
            ))),
        Expanded(flex: 1, child: Text("")),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Add new Trip member",
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
                        labelText: "member name",
                      ),
                    ),
                    TextField(
                      controller: t2,
                      decoration: InputDecoration(
                        labelText: "contect number",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      fontSize: 20, color: Colors.indigo)),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.indigo, width: 2)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              String name = t1.text;
                              String contect = t2.text;
                              String sql =
                                  "INSERT INTO member VALUES(null,'$name','$contect','${widget.m!['id']}')";
                              print("memeber=$sql");
                              trip1.database!.rawInsert(sql).then((value) {
                                print(value);
                              });
                              Navigator.pop(context);
                              get();
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
                                      fontSize: 20, color: Colors.white)),
                              decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.indigo, width: 2)),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            );
          },
          child: Container(
            margin: EdgeInsets.only(left: 320, bottom: 20),
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.indigo, borderRadius: BorderRadius.circular(30)),
            child:
                Text("+", style: TextStyle(color: Colors.white, fontSize: 30)),
          ),
        )
      ]),
      // floatingActionButton: FloatingActionButton(mini: true,child: Icon(Icons.add),onPressed: () {
      //
      // },),
    );
  }
}
