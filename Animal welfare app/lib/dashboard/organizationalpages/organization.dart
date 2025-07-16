// ignore_for_file: must_be_immutable, library_private_types_in_public_api, no_logic_in_create_state, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//inbuilt dart packages
import 'package:minorproject/registrationandsignup/model.dart';
import 'package:minorproject/dashboard/organizationalpages/Adoption/adopt.dart';
import 'package:minorproject/dashboard/organizationalpages/Lostandfound/lostnfound.dart';
import 'package:minorproject/dashboard/organizationalpages/Organizations/vet.dart';
import 'package:minorproject/dashboard/organizationalpages/drawer.dart';
import 'package:minorproject/dashboard/organizationalpages/Socials/social.dart';
import 'package:minorproject/dashboard/organizationalpages/Request/request.dart';
import 'package:minorproject/dashboard/organizationalpages/Donation/donation.dart';
import 'package:minorproject/dashboard/organizationalpages/Message/message.dart';

class Organization extends StatefulWidget {
  String id;
  Organization({super.key, required this.id});
  @override
  _OrganizationState createState() => _OrganizationState(id: id);
}

class _OrganizationState extends State<Organization> {
  String id;
  var role;
  var email;
  UserModel loggedInUser = UserModel();

  _OrganizationState({required this.id});
  // ignore: unused_field
  final _user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users") //.where('uid', isEqualTo: user!.uid)
        .doc(id)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      const CircularProgressIndicator();
      setState(() {
        email = loggedInUser.email.toString();
        role = loggedInUser.role.toString();
        id = loggedInUser.uid.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Dashboard",
        home: Builder(builder: ((context) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
            drawer: const NarBar(),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 66, 108, 110),
              title: const Text('DashBoard'),
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  //request button
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 300.0,
                            height: 120.0,
                            child: InkWell(
                              child: Card(
                                  color: Colors.redAccent[100],
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40.0)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        Image.asset("assets/images/siren.png",
                                            width: 64.0),
                                        const SizedBox(height: 6.0),
                                        const Text("Request Queries",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            )),
                                      ]),
                                    ),
                                  )),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Request()),
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                  /*
                  //request button//
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 400.0,
                          height: 120.0,
                          child: InkWell(
                            child: Card(
                                color: Colors.white,
                                elevation: 6.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(children: [
                                      Image.asset("assets/images/siren.png",
                                          width: 64.0),
                                      const SizedBox(height: 2.0),
                                      const Text("REQUEST ",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                          )),
                                    ]),
                                  ),
                                )),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Request()),
                              );
                            },
                          )),
                    ],
                  ),
                  */
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                        child: Wrap(
                      spacing: 60.0,
                      runSpacing: 60.0,
                      children: [
                        SizedBox(
                            width: 120.0,
                            height: 120.0,
                            child: InkWell(
                              child: Card(
                                  color: Colors.white,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        Image.asset(
                                            "assets/images/adoption.png",
                                            width: 64.0),
                                        const SizedBox(height: 6.0),
                                        const Text("Adoption",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            )),
                                      ]),
                                    ),
                                  )),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Adopt()),
                                );
                              },
                            )),
                        SizedBox(
                            width: 120.0,
                            height: 120.0,
                            child: InkWell(
                              child: Card(
                                  color: Colors.white,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        Image.asset(
                                            "assets/images/donation.png",
                                            width: 64.0),
                                        const SizedBox(height: 6.0),
                                        const Text("Donation",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            )),
                                      ]),
                                    ),
                                  )),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Donation()),
                                );
                              },
                            )),
                        SizedBox(
                            width: 120.0,
                            height: 120.0,
                            child: InkWell(
                              child: Card(
                                  color: Colors.white,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        Image.asset("assets/images/search.png",
                                            width: 64.0),
                                        const SizedBox(height: 6.0),
                                        const Text("Lost And Found",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0,
                                            )),
                                      ]),
                                    ),
                                  )),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Search()),
                                );
                              },
                            )),
                        SizedBox(
                            width: 120.0,
                            height: 120.0,
                            child: InkWell(
                              child: Card(
                                  color: Colors.white,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        Image.asset("assets/images/vet.png",
                                            width: 64.0),
                                        const SizedBox(height: 6.0),
                                        const Text("Organization",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            )),
                                      ]),
                                    ),
                                  )),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Vet()),
                                );
                              },
                            )),
                        SizedBox(
                            width: 120.0,
                            height: 120.0,
                            child: InkWell(
                              child: Card(
                                  color: Colors.white,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        Image.asset("assets/images/chat.png",
                                            width: 64.0),
                                        const SizedBox(height: 6.0),
                                        const Text("Message",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            )),
                                      ]),
                                    ),
                                  )),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Message()),
                                );
                              },
                            )),
                        SizedBox(
                            width: 120.0,
                            height: 120.0,
                            child: InkWell(
                              child: Card(
                                  color: Colors.white,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        Image.asset(
                                            "assets/images/social-media.png",
                                            width: 64.0),
                                        const SizedBox(height: 6.0),
                                        const Text("Socials",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            )),
                                      ]),
                                    ),
                                  )),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Social()),
                                );
                              },
                            )),
                      ],
                    )),
                  )
                ],
              ),
            ),
          );
        })));
  }
}
