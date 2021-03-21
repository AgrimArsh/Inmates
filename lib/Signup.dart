import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roommates/Services/CommonWidgetMaker.dart';
import 'package:roommates/Services/Measurements.dart';

import 'Services/AuthService.dart';
import 'Styles.dart';
import 'Welcome.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController hobbiesController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  TextEditingController buildingController = TextEditingController();
  TextEditingController peopleController = TextEditingController();

  String currentBox;

  bool hiddenPass = false;
  bool hiddenPass1 = false;
  bool loading = false;

  File image;

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
                    height: 400,
                    width: uniWidth(context)-70 ,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height:30),
                          Text("Create An Account",style:TextStyle(
                              fontSize: 20,
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
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: Colors.white,
                                border: Border.all(color:Colors.black, width:1.0)
                            ),
                            width: uniWidth(context)-130,
                            child: TextFormField(
                              controller: confirmPassController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Confirm Password",
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 15, bottom: 2, top: 2, right: 15),
                                  suffixIcon: InkWell(
                                    onTap: (){
                                      setState((){
                                        hiddenPass1 = !hiddenPass1;
                                      });
                                    },
                                    child: Icon(hiddenPass1?Icons.visibility:Icons.visibility_off,color:Colors.black),
                                  )
                              ),
                              obscureText: hiddenPass1,
                            ),
                          ),
                          SizedBox(height: 30,),
                          Container(height:3,color:Colors.black,width: uniWidth(context)-70 ,),
                          SizedBox(height: 20,),
                          Text("Personal Details",style:TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          )),
                          SizedBox(height:30),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: Colors.white,
                                border: Border.all(color:Colors.black, width:1.0)
                            ),
                            width: uniWidth(context)-130,
                            child: TextFormField(
                              controller: nameController,
                              autofillHints: [AutofillHints.givenName],
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Full Name",
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
                              controller: genderController,
                              autofillHints: [AutofillHints.gender],
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Gender",
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
                              controller: hobbiesController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Hobbies",
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
                              controller: majorController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Major",
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
                              controller: yearController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Year Of Study",
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 15, bottom: 2, top: 2, right: 15),

                              ),
                            ),
                          ),
                          SizedBox(height:30),
                          Container(height:3,color:Colors.black,width: uniWidth(context)-70 ,),
                          SizedBox(height: 20,),
                          Text("Preferences",style:TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          )),
                          SizedBox(height:30),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: Colors.white,
                                border: Border.all(color:Colors.black, width:1.0)
                            ),
                            width: uniWidth(context)-130,
                            child: TextFormField(
                              controller: buildingController,
                              // autofillHints: [AutofillHints.bu],
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Building",
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
                              controller: peopleController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "No. Of People In Room",
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.only(left: 15, bottom: 2, top: 2, right: 15),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          InkWell(
                            onTap: () async {
                              FilePickerResult result = await FilePicker.platform.pickFiles(type:FileType.image,allowMultiple: false,allowCompression: false);
                              if(result != null) {
                                List<File> files = result.paths.map((path) => File(path)).toList();
                                image = files[0];
                                setState((){});
                              }
                            },
                            child: Container(
                              height: 40,
                              color: Colors.grey[500],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Pick An Image"),
                              ),
                            ),
                          ),
                          SizedBox(height:20,),
                          Text("PS:Add a picture of something you love",style:TextStyle(
                            fontSize: 16
                          )),
                          SizedBox(height:20),
                          image!=null?Container(
                            height: 300,
                            child: Image.file(image,fit: BoxFit.cover,),
                          ):Container(),
                          SizedBox(height:20),
                          InkWell(
                            onTap: () async{
                              setState(() {
                                loading = true;
                              });
                              dynamic answer = await FirebaseAuthService.signUp(idController.text, passController.text, nameController.text,genderController.text,hobbiesController.text,majorController.text,yearController.text,buildingController.text,peopleController.text,image);
                              setState(() {
                                loading = false;
                              });
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
                              height: 55,
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
          ),
          Center(
            child: loading?CircularProgressIndicator():Container(),
          )
        ],
      ),
    );
  }
}
