import 'dart:io';
import 'dart:math';
import 'package:database/demo_view.dart';
import 'package:email_validator/email_validator.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main()
{
  runApp(MaterialApp(home: demo(),debugShowCheckedModeBanner: false,));
}
class demo extends StatefulWidget {
  static Database ?database;
static Directory? dir;

Map ?m;
demo([this.m]);
  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  File? file;
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();
  TextEditingController t4=TextEditingController();
  String city="surat";
  String gendar="";
  bool t=false;
  String new_image="";
  bool error_name=false;
  bool error_email=false;
  bool error_password=false;
  bool error_contect=false;
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

      var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+'/aayushi';
      demo.dir=Directory(path);
      if(! await demo.dir!.exists())
        {
          demo.dir!.create();
        }
    }
    if(widget.m!=null)
      {
        t1.text=widget.m!['name'];
        t2.text=widget.m!['contect'];
        t3.text=widget.m!['email'];
        t4.text=widget.m!['password'];
        city=widget.m!['city'];
        gendar=widget.m!['gendar'];
        new_image=widget.m!['image'];
        String new_path="${demo.dir!.path}/${new_image}";
        file=File(new_path);
        setState(() {

        });
      }

  }
  data()
  async {
// Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'image'
        '.db');
// open the database
    demo.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, contect TEXT,email TEXT,password TEXT,gendar TEXT,city TEXT,image TEXT)');
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
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
                errorText: (error_email)?"enter email":null,
                label: Text("entre email"),
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
                child: (t==true)?Image.file(File(image!.path)):(file!=null)?Image.file(File(file!.path)):null,
              )
          ),
          ElevatedButton(onPressed: () {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text("choose any one"),
                actions: [
                  Row(children: [
                    ElevatedButton(onPressed: () async {
                     image=await picker.pickImage(source: ImageSource.gallery);
                      t=true;
                      print(image!.path);
                      Navigator.pop(context);
                      setState(() {

                      });

                    }, child: Text("camera")),
                    ElevatedButton(onPressed: () async {
                      image = await picker.pickImage(source: ImageSource.gallery);
                      t=true;
                      Navigator.pop(context);
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
          String email=t3.text;
          String contect=t2.text;
          String password=t4.text;
          if(name=="")
            {
              error_name=true;
            }
          else
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

        if(!error_name &&! error_contect && ! error_email && ! error_password )
          {
            if(widget.m!=null)
            {
              if(image!=null)
              {
                File file1 =File("${demo.dir!.path}/${new_image}");
                file1.delete();
                new_image="${Random().nextInt(100)}.jpg";
                File f=File("${demo.dir!.path}/${new_image}");
                f.writeAsBytes(await image!.readAsBytes());
                String update="update Test set name='$name',contect='$contect',"
                    "email='$email',password='$password',gendar='$gendar',city='$city',image='$new_image' where id=${widget.m!['id']}";
                demo.database!.rawUpdate(update);
                setState(() {

                });
              }

            }else{
                if(image!=null)
                  {
                    String image_name="${Random().nextInt(100)}image.jpg";
                    file=File("${demo.dir!.path}/${image_name}");
                    file!.writeAsBytes(await image!.readAsBytes());
                    print("FilePath:${file!.path}");
                    print("ImagePath:${image!.path}");
                    String insert="insert into Test values(null,'$name','$contect','$email','$password','$gendar','$city','$image_name')";
                    demo.database!.rawInsert(insert);
                    print(insert);
                  }

            }
          }
          setState(() {

          });
        }, child: Text("Submit")),
        ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return demo_view();
          },));

        }, child: Text("View"))
      ]),
    );
  }
}
