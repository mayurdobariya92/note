import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/first.dart';

void main()
{
  runApp(MaterialApp(home: splish(),debugShowCheckedModeBanner: false,));
}
class splish extends StatefulWidget {
  const splish({Key? key}) : super(key: key);

  @override
  State<splish> createState() => _splishState();
}

class _splishState extends State<splish> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gonext();
  }
  gonext()
  async {
       await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return one();
    },));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.greenAccent,),
            SizedBox(height: 10,),
            Text("Loading........."),
          ],
        ),
      ),


    );
  }
}
