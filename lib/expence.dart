import 'package:database/trip1.dart';
import 'package:database/trip_mamber.dart';
import 'package:flutter/material.dart';

class expence extends StatefulWidget {
  Map m;
  Map previous_data;
  expence(this.m, this.previous_data);

  @override
  State<expence> createState() => _expenceState();
}

class _expenceState extends State<expence> {
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();
  List l=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  get()
  async {
    t2.text =
    "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
    String qry="select * from expence_info where m_id=${widget.m['id']}";
    l= await trip1.database!.rawQuery(qry);
    setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.m['name']}"),
      backgroundColor: Colors.indigo,
      ),
      body: WillPopScope(child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Container(
                  color: Colors.grey.shade200,
                  child: Text("date",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                )),

            Expanded(
                child: Container(
                  color: Colors.grey.shade200,
                  child: Text("Particluar",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                )),
            Expanded(
                child: Container(
                  color: Colors.grey.shade200,
                  child: Text("Amount",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                )),
          ],
        ),
        Expanded(child: Container(
          child: ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${l[index]["date"]}",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo)),
                      Text("${l[index]["name"]}",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo)),
                      Text("${l[index]["amount"]}",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo)),
                    ]),
              ),
            );
          },),
        )),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    Container(alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Add expence",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        color: Colors.indigo,
                        height: 50,
                        width: double.infinity),
                    TextField(
                      controller: t2,
                      decoration: InputDecoration(
                        labelText: "Date",
                      ),
                    ),
                    TextField(
                      controller: t1,
                      decoration: InputDecoration(
                        labelText: "expence name",
                      ),
                    ),

                    TextField(
                      controller: t3,
                      decoration: InputDecoration(
                        labelText: "Amount",
                      ),
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
                              String name = t1.text;
                              String amount = t3.text;
                              String sql =
                                  "INSERT INTO expence_info VALUES(null,'$name','$amount','${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}','${widget.m['id']}')";
                              print(sql);
                              trip1.database!.rawInsert(sql)
                                  .then((value) {
                                print(value);
                              });
                              Navigator.pop(context);
                              get();
                              setState(() {});
                              t1.text = "";
                              t3.text = "";
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
      ]), onWillPop: ()async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return trip_mamber(widget.previous_data);
        },),);
        return true;
      },),
    );
  }
}
