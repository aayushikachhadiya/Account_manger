import 'dart:io';
import 'dart:math';
import 'package:email_validator/email_validator.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:path/path.dart';

import 'image_piker_view.dart';

void main()
{
  runApp(MaterialApp(home: image_piker(),debugShowCheckedModeBanner: false,));
}
class image_piker extends StatefulWidget {
  static Database ?database;
  static Directory ?dir;
  Map? m;
  image_piker([this.m]);

  @override
  State<image_piker> createState() => _image_pikerState();
}

class _image_pikerState extends State<image_piker> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  bool t=false;
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();
  TextEditingController t4=TextEditingController();
  String gendar="";
  File? file;
  String city="surat";
  String new_image="";
  String image_name="";
  bool error_name=false;
  bool error_contect=false;
  bool error_email=false;
  bool error_password=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    data();

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
    var path_dir = await ExternalPath
        .getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS) +
        '/ayushi';
    image_piker.dir = Directory(path_dir);
    if (!await image_piker.dir!.exists()) {
      image_piker.dir!.create();
    }

    if(widget.m!=null)
    {
      t1.text=widget.m!['name'];
      t2.text=widget.m!['contact'];
      t3.text=widget.m!['email'];
      t4.text=widget.m!['password'];
      gendar=widget.m!['gendar'];
      city=widget.m!['city'];
      // new_image=widget.m!['image'];
      String new_path="${image_piker.dir!.path}/${widget.m!['image']}";
      file=File(new_path);
      print("upadte+${file}");
      setState(() {});
    }
  }

    data()
    async {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'demo.db');
      image_piker.database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            await db.execute(
                'CREATE TABLE login (id INTEGER PRIMARY KEY, name TEXT, contact TEXT,email TEXT,password TEXT,gendar Text,city Text,image TEXT)');
          });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Login"),backgroundColor: Colors.black),
      body: Column(children: [
        Container(
          margin: EdgeInsets.all(10),
          child:   TextField(onTap: () {
          },
            controller: t1,
            decoration: InputDecoration(
              errorText: (error_name)?"enter name":null,
                label: Text("entre name"),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
            ),
          ),
        ),
       Container(margin: EdgeInsets.all(10),
         child:  TextField(
           controller: t2,
           decoration: InputDecoration(
               errorText: (error_contect)?"enter contect":null,
               label: Text("entre contect"),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
           ),
         ),
       ),
      Container(margin: EdgeInsets.all(10),
        child:  TextField(
          controller: t3,
          decoration: InputDecoration(
              label: Text("entre email"),
              errorText: (error_email)?"enter email":null,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
          ),
        ) ,
      ),
      Container(margin: EdgeInsets.all(10),
        child:  TextField(
        controller: t4,
        decoration: InputDecoration(
            errorText: (error_password)?"enter password":null,
            label: Text("entre password"),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
        ),
      ),),
        SizedBox(height: 10,),

        Row(children: [
          Text("select gendar : ",style: TextStyle(fontSize: 15,color: Colors.black),),
          Text("Male",style: TextStyle(fontSize: 15,color: Colors.black),),
          Radio(value: "male", groupValue: gendar, onChanged: (value) {
           gendar=value!;
            setState(() {

            });
          },),
          Text("Female",style: TextStyle(fontSize: 15,color: Colors.black),),
          Radio(value: "female", groupValue: gendar, onChanged: (value) {
            gendar=value!;
            setState(() {

            });
          },)
        ],),
        DropdownButton(value: city,items: [
          DropdownMenuItem(child: Text("Surat"),value: "surat",),
          DropdownMenuItem(child: Text("Vapi"),value: "Vapi",),
          DropdownMenuItem(child: Text("Bharuch"),value: "Bharuch",),
          DropdownMenuItem(child: Text("Vadodra"),value:"Vadodra",),
          DropdownMenuItem(child: Text("Kamrej"),value: "Kamrej",),
          DropdownMenuItem(child: Text("Ahmedabad"),value: "Ahmedabad",),
        ], onChanged: (value) {
          city=value!;
          setState(() {

          });

        },),
        Row(children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(5),
              color: Colors.grey,
              height: 100,
              width: 100,
              child:(t ==true)?Image.file(File(image!.path)):(file!=null)?Image.file(File(file!.path)):null,
            )
          ),
          ElevatedButton(onPressed: () {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text("choose any one"),
                actions: [
                  Row(children: [
                   ElevatedButton(onPressed: () async {
                     image = await picker.pickImage(source: ImageSource.camera);
                     t=true;
                     Navigator.pop(context);
                     // await file.writeAsBytes(bytes!);
                     setState(() {

                     });

                   }, child: Text("camera")),
                    ElevatedButton(onPressed: () async {
                      t=true;
                      image = await picker.pickImage(source: ImageSource.gallery);
                      Navigator.pop(context);
                      // await file.writeAsBytes(bytes!);
                      setState(() {

                      });
                    }, child: Text("Gallery"))
                  ],)
                ],
              );
            },);
          }, child: Text("Chosse")),
         
        ],),
        ElevatedButton(onPressed: () async {
          String name=t1.text;
          String contect=t2.text;
          String email=t3.text;
          String password=t4.text;

          if(name=="")
            {
              error_name=true;
            }else
              {
                error_name=false;
              }
          String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
          RegExp regExp = new RegExp(patttern);
          if(contect=="" || !regExp.hasMatch(contect))
            {
              error_contect=true;
            }else
              {
                error_contect=false;
              }
          if(password=="")
            {
              error_password=true;
            }else
              {
                error_password=false;
              }
          if(email.trim()=="" || !EmailValidator.validate(email.trim()) )
            {
                error_email=true;
            }else
              {
                error_email=false;
              }
          setState(() {

          });
         if(!error_name && !error_email && !error_password && !error_contect )
           {
             print("hello");
             if(widget.m!=null)
             {
               print("Good");
                if(image!=null)
               {
                 print("Good1");
                 File file1=File("${image_piker.dir!.path}/${new_image}");
                 file1.delete();
                 new_image= "${Random().nextInt(1000)}myimage.jpg";
                 File f = File("${image_piker.dir!.path}/${new_image}");
                 f.writeAsBytes(await image!.readAsBytes());
                 String update="update login set name='$name',contact='$contect',email='$email',password='$password',gendar='$gendar',"
                     "city='$city',image='$new_image' where id=${widget.m!['id']}";
                 image_piker.database!.rawUpdate(update);
                 print(update);
                 setState(() {

                 });
                }
             }else
             {
               image_name =
               "${Random().nextInt(1000)}myimage.jpg";
               file = File("${image_piker.dir!.path}/${image_name}");
               file!.writeAsBytes(await image!.readAsBytes());
               print("FilePath:${file!.path}");
               print("ImagePath:${image!.path}");
               String qry="insert into login values(null,'$name','$contect','$email','$password','$gendar','$city','$image_name')";
               image_piker.database!.rawQuery(qry);
               print(qry);
             }
           }
          setState(() {

          });
        }, child: Text("Submit")),
        ElevatedButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return view();
          },));
        }, child: Text("View"))
      ]),
    );
  }
}
