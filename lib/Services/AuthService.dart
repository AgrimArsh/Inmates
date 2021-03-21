

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roommates/LoginAndSignup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService {
  static Future<dynamic> login(String id, String pass) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
        'users').where("id", isEqualTo: id).get();
    if (querySnapshot.docs.isEmpty) {
      return 'Account with ID does not exist';
    }
    DocumentSnapshot snapshot = querySnapshot.docs[0];
    if (snapshot.get('password') != pass) {
      return "Incorrect Password";
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id','value');
    prefs.setString('pass',pass);
    prefs.setString('snap', snapshot.data().toString());
    return User(id, pass, snapshot: snapshot);
  }

  static Future<dynamic> update(String id, String pass, String name,
      String gender, String hobbies, String major, String year, String building,
      String people,File picture) async {
    Reference ref2 = FirebaseStorage.instance.ref().child(id);
    await ref2.delete();
    Reference ref = FirebaseStorage.instance.ref().child(id);
    await ref.putFile(picture);
    String url = await ref.getDownloadURL();
    FirebaseFirestore.instance.collection('users').doc(id).update({
      'password': pass,
      'name': name,
      'gender': gender,
      'hobbies': hobbies,
      'major': major,
      'year': year,
      'building': building,
      'people': people,
      'image': url,
    });
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(id).get();
    return User(id,pass,snapshot: snapshot);
  }

  static Future<dynamic> signUp(String id, String pass, String name,
      String gender, String hobbies, String major, String year, String building,
      String people, File picture) async {
    Reference ref = FirebaseStorage.instance.ref().child(id);
    await ref.putFile(picture);
    String url = await ref.getDownloadURL();
    FirebaseFirestore.instance.collection('users').doc(id).set({
      'id': id,
      'password': pass,
      'name': name,
      'gender': gender,
      'hobbies': hobbies,
      'major': major,
      'year': year,
      'building': building,
      'people': people,
      'image': url,
      'likedPeople': [],
      'chattingWith':[],
    });
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(id).get();
    return User(id,pass,snapshot: snapshot);
  }
  static void signOut(context)async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginAndSignup()), (route) => false);
  }
}


class User {
  String id;
  String pass;
  DocumentSnapshot snapshot;

  User(this.id,this.pass,{this.snapshot});
}