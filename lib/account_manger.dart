import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(home: account_manager(),));
}
class account_manager extends StatefulWidget {
  const account_manager({super.key});

  @override
  State<account_manager> createState() => _account_managerState();
}

class _account_managerState extends State<account_manager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Account manager"),
      ),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("myasset/splash.png"))),
      ),
    );
  }
}
