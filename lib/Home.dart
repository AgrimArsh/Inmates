import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roommates/Home2.dart';
import 'package:roommates/Profile.dart';
import 'package:roommates/Services/Measurements.dart';

import 'ChatHome.dart';
import 'Services/AuthService.dart';
import 'Styles.dart';

class Home extends StatefulWidget {
  User user;
  Home(this.user);
  @override
  _HomeState createState() => _HomeState(user);
}

class _HomeState extends State<Home> {
  User user;
  _HomeState(this.user);

  Widget widgets = Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
  PageController controller = PageController(
    initialPage: 0
  );

  @override
  void initState(){
    super.initState();
    makeList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
             image: bgImage,
             border: Border.all(color: Colors.black,width: 5)
        ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>Profile(user)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle
                        ),
                        height: 60,
                        width: 60,
                        child: Center(
                          child: Icon(Icons.people,size: 30,),
                        ),
                      ),
                    ),
                    Container(
                      height:50,
                      width:164,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 2)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height:50,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              // borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child:Center(
                              child: Text("All",style: TextStyle(
                                fontSize: 22
                              ),),
                            )
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home2(user)));
                            },
                            child: Container(
                              height:50,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                                child:Center(
                                  child: Text("Liked",style: TextStyle(
                                      fontSize: 22
                                  ),),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatHome(user)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle
                        ),
                        height: 60,
                        width: 60,
                        child: Center(
                          child: Icon(Icons.chat,size: 30,),
                        ),
                      ),
                    ),
                    // FloatingActionButton(onPressed: (){},child: Icon(Icons.chat),backgroundColor:Colors.amber,)
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  height: uniHeight(context)*0.9,
                    width: uniWidth(context)-30,
                    child: widgets
                )
              ],
            ),
          ),
       )
      )
     )
    );
  }
  void makeList() async{
    List widgetList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').where('id',isNotEqualTo: user.id).get();
    for (DocumentSnapshot snapshot in querySnapshot.docs){
      print(snapshot.get('id'));
      if(!user.snapshot.get('likedPeople').contains(snapshot.get('id'))&&!snapshot.get('likedPeople').contains(snapshot.id)){
        widgetList.add(
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                // Note: Sensitivity is integer used when you don't want to mess up vertical drag
                int sensitivity = 8;
                if (details.delta.dx > sensitivity) {
                  like(snapshot,controller);
                } else if(details.delta.dx < -sensitivity){
                  dislike(controller);
                }
              },
              child: Container(
          height: uniHeight(context)*0.9,
          width: uniWidth(context)-30,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: InkWell(
                    onTap: ()async{
                      await showDialog(
                          context: context,
                          builder: (context){
                            return Container(
                              child: Center(
                                child: Container(
                                  width: uniWidth(context)-60,
                                  height: 600,
                                  decoration: BoxDecoration(
                                      gradient: gradient
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: uniWidth(context)-60,
                                      height: uniHeight(context)*0.5,
                                      decoration: BoxDecoration(
                                          image: bgImage,
                                          border: Border.all(color: Colors.black,width: 3)
                                      ),
                                      constraints: BoxConstraints.expand(),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(height:20),
                                              Text("Information",style: TextStyle(
                                                  fontSize: 22
                                              ),),
                                              SizedBox(height:20),
                                              Container(
                                                width: uniWidth(context),
                                                height: 200,
                                                child: Image.network(snapshot.get('image'),fit: BoxFit.cover,),
                                              ),
                                              SizedBox(height:20),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text("ID:",style: TextStyle(fontSize: 22),),
                                                    Container(
                                                      width: uniWidth(context)*0.4,
                                                      child: Center(child: Text(snapshot.get('id'),style: TextStyle(fontSize: 22,color: Colors.white),)),),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height:10),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text("Name:",style: TextStyle(fontSize: 22),),
                                                    Container(
                                                      width: uniWidth(context)*0.4,
                                                      child: Center(child: Text(snapshot.get('name'),style: TextStyle(fontSize: 22,color: Colors.white),)),),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height:10),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text("Gender:",style: TextStyle(fontSize: 22),),
                                                    Container(
                                                      width: uniWidth(context)*0.4,
                                                      child: Center(child: Text(snapshot.get('gender'),style: TextStyle(fontSize: 22,color: Colors.white),)),),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height:10),
                                              Container(
                                                height: 2,
                                                color: Colors.black,
                                              ),
                                              SizedBox(height:10),
                                              Text("Personal Details",style: TextStyle(
                                                fontSize: 22
                                              ),),
                                              SizedBox(height: 10,),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Hobbies:",style: TextStyle(fontSize: 22),),
                                                    SizedBox(width: 5,),
                                                    Container(
                                                      width: uniWidth(context)*0.4,
                                                      child: Center(child: Text(snapshot.get('hobbies'),style: TextStyle(fontSize: 22,color: Colors.white),)),),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height:10),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text("Major:",style: TextStyle(fontSize: 22),),
                                                    Container(
                                                      width: uniWidth(context)*0.4,
                                                      child: Center(child: Text(snapshot.get('major'),style: TextStyle(fontSize: 22,color: Colors.white),)),),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height:10),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text("Year:",style: TextStyle(fontSize: 22),),
                                                    Container(
                                                      width: uniWidth(context)*0.4,
                                                      child: Center(child: Text(snapshot.get('year'),style: TextStyle(fontSize: 22,color: Colors.white),)),),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height:10),
                                              Container(
                                                height: 2,
                                                color: Colors.black,
                                              ),
                                              SizedBox(height:10),
                                              Text("Preferences",style: TextStyle(
                                                  fontSize: 22
                                              ),),
                                              SizedBox(height: 10,),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Text("Building:",style: TextStyle(fontSize: 22),),
                                                    Container(
                                                      width: uniWidth(context)*0.4,
                                                      child: Center(child: Text(snapshot.get('building'),style: TextStyle(fontSize: 22,color: Colors.white),)),),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height:10),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                        width: uniWidth(context)*0.38,
                                                        child: Text("No. Of People:",style: TextStyle(fontSize: 22),)
                                                    ),
                                                    Container(
                                                      width: uniWidth(context)*0.2,
                                                      child: Center(child: Text(snapshot.get('people'),style: TextStyle(fontSize: 22,color: Colors.white),)),),
                                                  ],
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
                            );
                          }
                      );
                    },
                    child: Container(
                      height: uniHeight(context)*0.45,
                      width: uniWidth(context)-60,
                      decoration: BoxDecoration(
                        border: Border.all(color:Colors.black,width: 4.5)
                      ),
                      child: Image(
                        height: uniHeight(context)*0.45,
                        width: uniWidth(context)-60,
                        image: NetworkImage(snapshot.get('image')),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height:30),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(snapshot.get('name'),style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height:10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(snapshot.get('gender'),style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: snapshot.get('gender').toString().toLowerCase().contains('f')?Colors.pink[400]:Colors.blue
                  ),),
                ),
                SizedBox(height:10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Year:" +snapshot.get('year'),style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                SizedBox(height:30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        dislike(controller);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle
                        ),
                        height: 60,
                        width: 60,
                        child: Center(
                          child: Icon(Icons.cancel_outlined,size: 30,color: Colors.white,),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle
                      ),
                      height: 60,
                      width: 60,
                      child: Center(
                        child: Icon(Icons.whatshot,size: 30,),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        like(snapshot, controller);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle
                        ),
                        height: 60,
                        width: 60,
                        child: Center(
                          child: Icon(Icons.check_circle_outline,size: 30,color: Colors.white,),
                        ),
                      ),
                    )
                  ],
                )
              ],
          ),
        ),
            ));
      }
    }
    widgets = PageView.builder(
      controller: controller,
      physics: NeverScrollableScrollPhysics(),
      allowImplicitScrolling: false,
      itemBuilder: (context,index){
        index = index%widgetList.length;
        return widgetList[index];
      },
      // itemCount: widgetList.length,
    );
    setState(() {

    });
  }
  void like(DocumentSnapshot snapshot,PageController controller) async {
    print('Like');
    controller.nextPage(duration: Duration(milliseconds:500),curve: Curves.linear);
    Fluttertoast.showToast(msg: 'Liked',gravity: ToastGravity.CENTER,backgroundColor: Colors.green);
    await user.snapshot.reference.update({
      'likedPeople':FieldValue.arrayUnion([snapshot.reference])
    });
    DocumentSnapshot snapshot2 = await FirebaseFirestore.instance.collection('users').doc(user.id).get();
    user = User(snapshot2.get('id'),snapshot2.get('password'),snapshot: snapshot2);

    setState(() {

    });
    makeList();

  }
  void dislike(PageController controller){
    print('Dislike');
    Fluttertoast.showToast(msg: 'Disliked',gravity: ToastGravity.CENTER,backgroundColor: Colors.red);
    controller.nextPage(duration: Duration(milliseconds:500),curve: Curves.linear,);
  }
}
