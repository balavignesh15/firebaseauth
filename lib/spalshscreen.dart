import 'package:flutter/material.dart';



class spalsh extends StatefulWidget {
  final Widget? child;
  const spalsh({super.key, required this.child});

  @override
  State<spalsh> createState() => _spalshState();
}

class _spalshState extends State<spalsh> {

  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 2),(){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> widget.child!), (route) => false);
    },
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Welcome")),
    );
  }
}
