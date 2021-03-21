import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roommates/Services/CommonWidgetMaker.dart';
import 'package:roommates/Services/Measurements.dart';

import 'Services/AuthService.dart';
import 'Styles.dart';
import 'Welcome.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool hiddenPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: gradient
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    image:bgImage,
                    border: Border.all(color:Colors.black,width:5)
                ),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: gradient,
                      border: Border.all(color: Colors.black,width: 3)
                    ),
                    height: 350,
                    width: uniWidth(context)-70 ,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height:30),
                          Text("LOGIN",style:TextStyle(
                              fontSize: 22,
                            fontWeight: FontWeight.bold
                          )),
                          SizedBox(height: 30,),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: Colors.white,
                                border: Border.all(color:Colors.black, width:1.0)
                            ),
                            width: uniWidth(context)-130,
                            child: TextFormField(
                              controller: idController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "College ID",
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.only(left: 15, bottom: 2, top: 2, right: 15),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: Colors.white,
                                border: Border.all(color:Colors.black, width:1.0)
                            ),
                            width: uniWidth(context)-130,
                            child: TextFormField(
                              controller: passController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 15, bottom: 2, top: 2, right: 15),
                                  suffixIcon: InkWell(
                                    onTap: (){
                                      setState((){
                                        hiddenPass = !hiddenPass;
                                      });
                                    },
                                    child: Icon(hiddenPass?Icons.visibility:Icons.visibility_off,color:Colors.black),
                                  )
                              ),
                              obscureText: hiddenPass,
                            ),
                          ),
                          SizedBox(height: 30,),
                          InkWell(
                            onTap: () async{
                              dynamic answer = await FirebaseAuthService.login(idController.text, passController.text,);
                              if (answer is User){
                                Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>Welcome(answer)),(Route<dynamic> route)=>false);
                              }
                              else {
                                Fluttertoast.showToast(msg: answer,toastLength: Toast.LENGTH_LONG,);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: Colors.black)
                              ),
                              width:(uniWidth(context)-80)/2,
                              height: 65,
                              child: Center(child: Text("SUBMIT",style: TextStyle(fontSize: 25),)),
                            ),
                          ),
                        ],

                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8,8,0,0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.black,size: 25,)
                  ),
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
