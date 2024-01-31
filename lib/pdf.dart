import 'dart:io';
import 'dart:math';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

void main()
{
  runApp(MaterialApp(home: pdf(),debugShowCheckedModeBanner: false,));
}
class pdf extends StatefulWidget {
  const pdf({super.key});

  @override
  State<pdf> createState() => _pdfState();
}

class _pdfState extends State<pdf> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  get()
  async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(onPressed: () async {
        final PdfDocument document = PdfDocument();
        final PdfPage page = document.pages.add();
        page.graphics.drawString("Hello", PdfStandardFont(PdfFontFamily.helvetica, 15),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)
        ),
         bounds: const Rect.fromLTWH(0, 0, 150, 20));
        //     final PdfPage second = document.pages.add();
        // second.graphics.drawString("World", PdfStandardFont(PdfFontFamily.helvetica, 15),
        //   brush: PdfSolidBrush(PdfColor(0, 0, 0)
        //   ),
        // );

        var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS) +
            '/pdf';
        print(path);

        Directory dir=Directory(path);
        if(!await dir.exists())
          {
            dir.create();
          }
        File f=File("${dir.path}/mypdf${Random().nextInt(100)}.pdf");
        f.writeAsBytes(await document.save());
        OpenFile.open(f.path);
        document.dispose();
        setState(() {

        });
      },child:Text("Submit")),
    );
  }
}
