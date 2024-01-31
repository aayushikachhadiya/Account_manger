import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: music(),
    debugShowCheckedModeBanner: false,
  ));
}

class music extends StatelessWidget {
  const music({super.key});

  @override
  Widget build(BuildContext context) {
    double a=10;
    double h=MediaQuery.of(context).size.height;
    double status_bar=MediaQuery.of(context).padding.top;
    double app_bar=kToolbarHeight;
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.red,
                  )),
              PopupMenuButton(
                color: Colors.red,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("One"),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text("Two"),
                    value: 2,
                  ),
                  PopupMenuItem(
                    child: Text("Three"),
                    value: 3,
                  )
                ],
              )
            ],
            bottom: TabBar(
              isScrollable: true,
              dividerColor: Colors.red,
              indicatorColor: Colors.red,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  child: Text("Songs", style: TextStyle(fontSize: 20)),
                ),
                Tab(
                  child: Text("Artists", style: TextStyle(fontSize: 20)),
                ),
                Tab(
                  child: Text("Albums", style: TextStyle(fontSize: 20)),
                ),
                Tab(
                  child: Text("Playlists", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.black,
          body:Column(children: [
            InkWell(onTap: () {
              showModalBottomSheet(isScrollControlled: true,context: context, builder: (context) {
                return Container(
                  height: h-app_bar,
                  color: Colors.black87,
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 300,
                      height: 300,
                     decoration: BoxDecoration(  color: Colors.black54,borderRadius: BorderRadius.circular(20)),
                     child: IconButton(onPressed: () {

                     },icon: Icon(Icons.music_note,size: 200,color: Colors.grey,)),
                    ),
                    Container(
                      child: StatefulBuilder(
                        builder: (context, setState1) {
                          return Slider(
                            activeColor: Colors.red,
                            inactiveColor: Colors.black,
                            min: 0,
                            max: 30,
                            value: a,
                            onChanged: (value) {
                              a = value;
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(child: Container(
                      alignment: Alignment.center,
                      child: Text("AUD-2023080",style: TextStyle(fontSize: 20,color: Colors.white)),
                    )),
                    Expanded(
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                 Expanded(child: Container(
                   child:      IconButton(onPressed: () {

                   }, icon: Icon(Icons.arrow_right,color: Colors.red,size: 60,)),
                 )),
                      Expanded(child: Container(child:   IconButton(onPressed: () {

                      }, icon: Icon(Icons.play_circle,color: Colors.red,size: 70,)),)),
              Expanded(child: Container(
                child:         IconButton(onPressed: () {

                }, icon: Icon(Icons.arrow_left_outlined,color: Colors.red,size: 60,)),
              ))
                      ],),
                    ),
                  Expanded(child: Text("")),
                  Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                    Expanded(child: Container(
                      child: IconButton(onPressed: () {

                      },icon: Icon(Icons.menu,color: Colors.white,)),
                    )),
                    Expanded(child: Container(
                      child: IconButton(onPressed: () {

                      },icon: Icon(Icons.favorite_border,color: Colors.white,)),
                    )),
                    Expanded(child: Container(
                      child: IconButton(onPressed: () {

                      },icon: Icon(Icons.autorenew_sharp,color: Colors.white,)),
                    )),
                    Expanded(child: Container(
                      child: IconButton(onPressed: () {

                      },icon: Icon(Icons.more_horiz,color: Colors.white,)),
                    ))
                  ],))
                  ]),
                );
              },);
            },
              child: Container(
                color: Colors.white,
                height: 70,
                alignment: Alignment.center,
                width: double.infinity,
                child: Text("Songs",style: TextStyle(color: Colors.black,fontSize: 20)),
              ),
            )
          ]),
        ));
  }
}
