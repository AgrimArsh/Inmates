import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roommates/ChatScreen.dart';
import 'package:roommates/Services/CommonWidgetMaker.dart';
import 'package:roommates/Services/Measurements.dart';

import 'Services/AuthService.dart';
import 'Styles.dart';
import 'Welcome.dart';

class ChatHome extends StatefulWidget {
  User user;
  ChatHome(this.user);
  @override
  _ChatHomeState createState() => _ChatHomeState(user);
}

class _ChatHomeState extends State<ChatHome> {

  User user;
  List<Widget> widgetList = <Widget>[];
  _ChatHomeState(this.user);
  TextEditingController searchController = TextEditingController();

  @override
  void initState(){
    super.initState();
    generateChats();
  }
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
                child: Column(
                  children: <Widget>[
                    SizedBox(height:15),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white,
                          border: Border.all(color:Colors.black, width:1.0)
                      ),
                      width: uniWidth(context)-130,
                      child: TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (v){
                          generateChats();
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Search For Contacts",
                          suffixIcon: Icon(Icons.search),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.only(left: 15, bottom: 2, top: 2, right: 15),
                        ),
                      ),
                    ),
                    SizedBox(height:30)
                  ]+widgetList,
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
  void generateChats()async{
    widgetList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('channels').get();
    for (DocumentSnapshot snapshot in querySnapshot.docs){
      if (snapshot.id.contains(user.id) &&(snapshot.get('Name1').toString().toLowerCase().contains(searchController.text.toLowerCase())||snapshot.get('Name2').toString().toLowerCase().contains(searchController.text.toLowerCase()))){
        String chosenName = snapshot.get('Name1')!=user.snapshot.get('name')?snapshot.get('Name1'):snapshot.get('Name2');
        String chosenImage= snapshot.get('Image1')!=user.snapshot.get('image')?snapshot.get('Image1'):snapshot.get('Image2');
        widgetList.add(InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(user, snapshot,chosenName)));
          },
          child: Container(
            height:70,
            width: uniWidth(context)*0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.black,width: 3)
            ),
            child: ListTile(
              leading: CircleAvatar(
               radius: 25,
               backgroundImage: NetworkImage(chosenImage),
              ),
              title: Text(chosenName),
            ),
          ),
        ));
        widgetList.add(SizedBox(height: 15,));
      }
    }
    setState(() {

    });
  }
}
