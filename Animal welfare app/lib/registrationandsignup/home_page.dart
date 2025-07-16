// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//self built resources
import 'package:minorproject/registrationandsignup/model.dart';
import 'package:minorproject/dashboard/userlevelpages/user.dart';
import 'package:minorproject/dashboard/organizationalpages/organization.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();
  @override
  Widget build(BuildContext context) {
    return const Control();
  }
}

class Control extends StatefulWidget {
  const Control({super.key});

  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  //final _auth = FirebaseAuth.instance;
  _ControlState();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  //var name;
  var role;
  var id;
  //var email;
  //var phonenumber;

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("Users") //.where('uid', isEqualTo: user!.uid)
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      setState(() {
        //name = loggedInUser.name.toString();
        //email = loggedInUser.email.toString();
        role = loggedInUser.role.toString();
        id = loggedInUser.uid.toString();
        //phonenumber = loggedInUser.phonenumber?.toInt();
      });
    });
  }

  routing() {
    if (role == 'Individual') {
      return Individual(
        id: user!.uid,
      );
    } else {
      return Organization(
        id: user!.uid,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return routing();
  }
}
