import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Modules/Dashboard/view/homepage.dart';
import 'docdata.dart';



class AuthService {
  var docdata = DocData();
  CreateUser( data,context) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email']!,
        password: data['password']!,
      );
      await docdata.addUser(data);
      Get.off(Homepage());
      print("User created: ${credential.user?.uid}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User created successfully!"), backgroundColor: Colors.green),
      );
    }  catch (e) {
      print("Unexpected error: $e");
    }
  }

  login(data,context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data['email']!,
        password: data['password']!,
      );
      Get.off(Homepage());
      await docdata.addUser(data);
      print("Login successful: ${credential.user?.uid}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login successful!"), backgroundColor: Colors.green),
      );
    } catch (e) {
      print("Unexpected login error: $e");
    }
  }
}
