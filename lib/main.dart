import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie/ui/HomeScreen.dart';
import 'package:movie/ui/appintro.dart';
import 'package:movie/ui/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: "Movie APP",
  home:checkPage(),
));


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

   navigationPage()async{
     await Future.delayed(const Duration(milliseconds: 500));
     Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigationPage();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor ,
      body: Center(
        child:Image.asset("assets/images/movies.jpg"),
      ),
    );
  }
}

bool firstRun;


class checkPage extends StatefulWidget {
  @override
  _checkPageState createState() => _checkPageState();
}

class _checkPageState extends State<checkPage> {


 Future checkFirstRun()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    bool firstRun=(prefs.getBool('firstRun') ?? true) ;
    if(!firstRun){
      SplashScreen();
    }
    else{

    }
  }


  @override
  void initState() {
    // TODO: implement initState
    checkFirstRun();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
