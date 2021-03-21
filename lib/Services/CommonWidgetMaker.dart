import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:roommates/Styles.dart';

GradientAppBar makeAppBar(name){
  return GradientAppBar(
    // actions: actionWidgetList,
    // leading: IconButton(
    //   icon: Icon(Icons.menu,size: 30,color: Colors.white,),
    //   onPressed: (){
    //     // _fileListKey.currentState.openDrawer();
    //   },
    // ),
    centerTitle: true,
    gradient: gradient,
    title: Text(name.toString().toUpperCase(),style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Colors.white
    ),),
  );
}