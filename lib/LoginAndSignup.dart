import 'package:flutter/material.dart';
import 'package:roommates/Login.dart';
import 'package:roommates/Services/CommonWidgetMaker.dart';
import 'package:roommates/Signup.dart';
import 'package:roommates/Styles.dart';

import 'Services/Measurements.dart';

class LoginAndSignup extends StatefulWidget {
  @override
  _LoginAndSignupState createState() => _LoginAndSignupState();
}

class _LoginAndSignupState extends State<LoginAndSignup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: makeAppBar("Login"),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
                image:bgImage,
                border: Border.all(color:Colors.black,width:5)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              //    InkWell(
              //      onTap: (){
              //        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              //      },
              //      child: Container(
              //       decoration: BoxDecoration(
              //
              //          color: turquoise,
              //          // borderRadius: BorderRadius.all(Radius.circular(8)),
              //          border: Border.all(color: Colors.black,width: 1.0)
              //        ),
              //       width: uniWidth(context)-30 ,
              //       height: 60,
              //       child: Center(
              //         child:Text("LOGIN",style:TextStyle(
              //         fontSize: 22
              //        ))
              //      )
              //  ),
              //    ),
              // SizedBox(height: 20,),
              //   InkWell(
              //     child: Container(
              //         decoration: BoxDecoration(
              //             color: green,
              //             borderRadius: BorderRadius.all(Radius.circular(8)),
              //             border: Border.all(color: Colors.black,width: 1.0)
              //         ),
              //         width: uniWidth(context)-30 ,
              //         height: 60,
              //         child: Center(
              //             child:Text("SIGNUP",style:TextStyle(
              //                 fontSize: 22
              //             ))
              //         )
              //     ),
              //   ),
                Text("Login To Explore",style: TextStyle(
                  fontSize: 22
                ),),
                SizedBox(height: 20,),
                   InkWell(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                     },
                     child: Container(
                      decoration: BoxDecoration(
                         gradient:gradient,
                         borderRadius: BorderRadius.all(Radius.elliptical(100,50)),
                         border: Border.all(color: Colors.black,width: 1.0)
                       ),
                      width: uniWidth(context)*0.6 ,
                      height: 60,
                      child: Center(
                        child:Text("Login",style:TextStyle(
                        fontSize: 22
                       ))
                     )
                 ),
                   ),
                SizedBox(height:20),
                Text("OR",style: TextStyle(
                  fontSize: 22,
                  // color:Colors.white
                ),),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          gradient:gradient,
                          borderRadius: BorderRadius.all(Radius.elliptical(100,50)),
                          border: Border.all(color: Colors.black,width: 1.0)
                      ),
                      width: uniWidth(context)*0.6 ,
                      height: 60,
                      child: Center(
                          child:Text("Sign Up",style:TextStyle(
                              fontSize: 22
                          ))
                      )
                  ),
                ),
                SizedBox(height:20),
                Text("Sign Up To Start",style: TextStyle(
                    fontSize: 22
                ),),
              ],
            ),
          ),
        ),
      )
    );
  }
}
