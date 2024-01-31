import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

void main()
{
  runApp(MaterialApp(home: share(),debugShowCheckedModeBanner: false,));
}
class share extends StatefulWidget {
  const share({super.key});

  @override
  State<share> createState() => _shareState();
}

class _shareState extends State<share> {
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permission();
  }
  permission()
  async {

    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
      print(statuses[Permission.location]);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Column(children: [
      WidgetsToImage(child:   Container(
        height: 100,
        width: 100,
        child: Image(image: AssetImage("myasset/int_a_tinder_b.png")),
      ), controller: controller),
        ElevatedButton(onPressed: () async {
           bytes = await controller.capture();
           var path = await ExternalPath. getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/aayushi";
           Directory dir=Directory(path);
           if (!await dir.exists()) {
             dir.create();
           }
           print(path);
           String imag_name =
               "${Random().nextInt(1000)}myimage.jpg";//
           File file = File("${dir.path}/${imag_name}");
           await file.writeAsBytes(bytes!);
           Share.shareXFiles([XFile('${file.path}')],
               text: 'Great picture');// /storage/emulated/0/Download
        }, child: Text("Submit"))
      ],)
    );
  }
}
