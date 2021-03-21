import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roommates/Services/CommonWidgetMaker.dart';
import 'package:roommates/Services/Measurements.dart';

import 'Services/AuthService.dart';
import 'Styles.dart';
import 'Welcome.dart';

class ChatScreen extends StatefulWidget {
  User user;
  DocumentSnapshot channel;
  String talkingTo;
  ChatScreen(this.user,this.channel,this.talkingTo);
  @override
  _ChatScreenState createState() => _ChatScreenState(user,channel,talkingTo);
}

class _ChatScreenState extends State<ChatScreen> {

  User user;
  DocumentSnapshot channel;
  String talkingTo;
  _ChatScreenState(this.user,this.channel,this.talkingTo);
  TextEditingController searchController = TextEditingController();

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  color: Colors.amber,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: IconButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.arrow_back,color: Colors.black,size: 30,)
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(talkingTo,style: TextStyle(
                          fontSize: 20
                        ),),
                      )
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: channel.reference.collection('messages').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<Widget> messageList =<Widget>[];
                    List<DocumentSnapshot> sortedDocs = snapshot.data.docs;
                    sortedDocs.sort((DocumentSnapshot a,DocumentSnapshot b){
                     return a.get('timestamp').compareTo(b.get('timestamp'));
                    });
                    messageList.add(SizedBox(height: 20,));
                    for (DocumentSnapshot snap in sortedDocs){
                      if (snap.get('sentBy')==user.id){
                        messageList.add(Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,7,15,7),
                              child: Container(
                                width: uniWidth(context)*0.4,

                                decoration: BoxDecoration(
                                  color: turquoise,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(snap.get('message'),style: TextStyle(
                                    fontSize: 15
                                  ),),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      else {
                        messageList.add(
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15,7,0,7),
                              child: Container(
                                width: uniWidth(context)*0.4,
                                decoration: BoxDecoration(
                                    color: green,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(snap.get('message'),style: TextStyle(
                                      fontSize: 15
                                  ),),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }
                    return Expanded(
                      child: Container(
                        width: uniWidth(context)-30,
                        child: SingleChildScrollView(
                            child: Column(
                              children: messageList,
                            )
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.white,
                      // border: Border.all(color:Colors.black, width:1.0)
                  ),
                  height: 50,
                  width: uniWidth(context)-30,
                  child: Padding(
                    padding: const EdgeInsets.only(top:7.0),
                    child: TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (v){
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type your message",
                        suffixIcon: IconButton(
                            onPressed: (){
                              sendMessage();
                            },
                            icon: Icon(Icons.send,color: Colors.amber,)
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        contentPadding: EdgeInsets.only(left: 15, bottom: 2, top: 2, right: 15),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
  void sendMessage(){
    String message = searchController.text;
    searchController.text = "";
    channel.reference.collection('messages').add({
      "message":message,
      'sentBy':user.id,
      'timestamp':DateTime.now().millisecondsSinceEpoch
    });
  }
}
