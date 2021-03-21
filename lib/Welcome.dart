import 'package:flutter/material.dart';
import 'package:roommates/Home.dart';
import 'package:roommates/Services/AuthService.dart';
import 'package:roommates/Services/Measurements.dart';
import 'package:roommates/Styles.dart';

class Welcome extends StatefulWidget {
  User user;
  Welcome(this.user);
  @override
  _WelcomeState createState() => _WelcomeState(user);
}

class _WelcomeState extends State<Welcome> {
  User user;
  _WelcomeState(this.user);
  @override
  void initState(){
    super.initState();
    nextPage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: InkWell(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(user)));
          },
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: bgImage,
                border: Border.all(color: Colors.black,width: 5)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Welcome',style: TextStyle(fontSize: 40),),
                  SizedBox(height: 20,),
                  Text('To',style: TextStyle(fontSize: 40),),
                  SizedBox(height: 20,),
                  Text('Inmates',style: TextStyle(fontSize: 40),),
                  SizedBox(height: 20,),
                  Text('Swipe Right To Match',style: TextStyle(fontSize: 25),),
                  SizedBox(height:20),
                  Container(
                    width: uniWidth(context)*0.7,
                      height:70,
                      child: Image(image:AssetImage('images/greenArrow.png'),fit: BoxFit.fitWidth,)
                  ),
                  SizedBox(height: 20,),
                  Text('Swipe Left For Next',style: TextStyle(fontSize: 25),),
                  SizedBox(height:20),
                  Container(
                    width: uniWidth(context)*0.7,
                      height:70,
                      child: Image(image:AssetImage('images/redArrow.png'),fit: BoxFit.fitWidth,)
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void nextPage() async {
    await Future.delayed(Duration(seconds:5));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(user)));
  }
}
