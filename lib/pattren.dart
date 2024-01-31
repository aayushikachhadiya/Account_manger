import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()
{
  runApp(MaterialApp(home: pattren(),debugShowCheckedModeBanner: false,));
}
class pattren extends StatefulWidget {
  static SharedPreferences ?prefs;

  @override
  State<pattren> createState() => _pattrenState();
}

class _pattrenState extends State<pattren> {
  bool p=false;
  @override
 initState()  {
    // TODO: implement initState
    super.initState();
    new Future.delayed(Duration.zero, () {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("set a patttren "),
              actions: [
               TextButton(onPressed: () {
                 p=true;
                 get();
                 Navigator.pop(context);
                 setState(() {
                 });
               }, child: Text("Set"))
              ],
            );
          });
    });

  }
  String matchs="";
  get()
  async {
    pattren.prefs = await SharedPreferences.getInstance();
    matchs=pattren.prefs!.getString("pin") ?? "";
    print(match);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(6, 50, 120, 12),
      ),
     backgroundColor: Color.fromRGBO(6, 50, 120, 12),
     body: (p==true)?Column(
       children: [
        Expanded(child: Container(
          child:  PatternLock(
            // color of selected points.
            selectedColor: Colors.white,
            // radius of points.
            pointRadius: 8,
            // whether show user's input and highlight selected points.
            showInput: true,
            // count of points horizontally and vertically.
            dimension: 3,
            // padding of points area relative to distance between points.
            relativePadding: 0.7,
            // needed distance from input to point to select point.
            selectThreshold: 25,
            // whether fill points.
            fillPoints: true,
            // callback that called when user's input complete. Called if user selected one or more points.
            onInputComplete: (List<int> input) {
              print("pattern is ${input.join()}");
              pattren.prefs!.setString("pin",  input.join());
            },
          ),
        )),
        Expanded(child:  Center(
          child: TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return match();
            },));
          },child: Text("Set")),
        ))
       ],
     ):Text("")
    );
  }
}
class match extends StatefulWidget {
  const match({super.key});

  @override
  State<match> createState() => _matchState();
}

class _matchState extends State<match> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  String matchs="";
  get()
  {
    matchs=pattren.prefs!.getString("pin") ?? "";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:PatternLock(
        // color of selected points.
        selectedColor: Colors.black,
        // radius of points.
        pointRadius: 8,
        // whether show user's input and highlight selected points.
        showInput: true,
        // count of points horizontally and vertically.
        dimension: 3,
        // padding of points area relative to distance between points.
        relativePadding: 0.7,
        // needed distance from input to point to select point.
        selectThreshold: 25,
        // whether fill points.
        fillPoints: true,
        // callback that called when user's input complete. Called if user selected one or more points.
        onInputComplete: (List<int> input) {
          print("pattern is ${input.join()}");
          if(matchs==input.join())
            {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: Text("Welcome"),
                );

              },);
            }
        }
      ),
    );
  }
}

