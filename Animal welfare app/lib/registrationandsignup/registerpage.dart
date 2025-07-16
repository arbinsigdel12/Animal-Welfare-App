// ignore_for_file: prefer_const_constructors, constant_identifier_names, use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minorproject/dashboard/widgets/signin_button.dart';
import 'package:minorproject/registrationandsignup/model.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showloginPage;
  const RegisterPage({Key? key, required this.showloginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controller
  final _namecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;
  var options = [
    'Individual',
    'Organization',
  ];
  var _currentItemSelected = "Individual";
  var role = "Individual";

  //loading button
  bool loading = false;

  //new firebase add ons
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  //relatime database of firebase
  CollectionReference ref = FirebaseFirestore.instance.collection('Users');
  final referenceDatabase = FirebaseDatabase.instance.ref('Users');

  @override
  void dispose() {
    // ignore: todo
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _namecontroller.dispose();
    _phonecontroller.dispose();
    super.dispose();
  }

  Future signUp() async {
    //authenticate user only
    if (_formkey.currentState!.validate() & passwordConfirmed()) {
      setState(() {
        loading = true;
      });
      await _auth.createUserWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passwordcontroller.text.trim());

      //add user details to firebase function is created here and data is allocated below.
      addUserDetails(
        _namecontroller.text.trim(),
        _emailcontroller.text.trim(),
        int.parse(_phonecontroller.text.trim()),
        role.toString(),
      );
    }
  }

  bool passwordConfirmed() {
    if (_passwordcontroller.text.trim() ==
        _confirmpasswordcontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  //sending user details to firebase firestore
  Future addUserDetails(
      String name, String email, int phonenumber, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.name = name;
    userModel.email = email;
    userModel.uid = user!.uid;
    userModel.phonenumber = phonenumber;
    userModel.role = role;
    await firebaseFirestore
        .collection('Users')
        .doc(user.uid)
        .set(userModel.toMap());
    referenceDatabase.child(user.uid).set({
      'name': _namecontroller.text.toString(),
      'email': _emailcontroller.text.toString(),
      'phone': _phonecontroller.text.toString(),
      'role': userModel.role.toString(),
      'uid': userModel.uid.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formkey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    //hello
                    const Text(
                      'Hello There!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Register below with your details!',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 50),

                    //Name textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        controller: _namecontroller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple)),
                          hintText: 'Name',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    //Phone Number textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        controller: _phonecontroller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple)),
                          hintText: 'Phone Number',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(r"^[0-9]{10}$");
                          if (value!.isEmpty) {
                            return "Phone number cannot be empty";
                          }
                          if (!regex.hasMatch(value)) {
                            return ("please enter valid phone number");
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {},
                        keyboardType: TextInputType.phone,
                      ),
                    ),

                    const SizedBox(height: 10),

                    //email textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        controller: _emailcontroller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple)),
                          hintText: 'Email',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Enter a valid email");
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {},
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),

                    const SizedBox(height: 10),

                    //password textfielld
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        obscureText: _isObscure,
                        controller: _passwordcontroller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple)),
                          hintText: 'Password',
                          fillColor: Colors.grey[200],
                          filled: true,
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                        ),
                        validator: (value) {
                          RegExp regex =
                              RegExp(r'^[A-Za-z0-9!@#$%&_\><*~]{8,}$');
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          }
                          if (!regex.hasMatch(value)) {
                            return ("please enter valid password min. 8 character");
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {},
                      ),
                    ),

                    const SizedBox(height: 10),

                    //confirm password textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        obscureText: _isObscure2,
                        controller: _confirmpasswordcontroller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple)),
                          hintText: 'Confirm Password',
                          fillColor: Colors.grey[200],
                          filled: true,
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure2 = !_isObscure2;
                                });
                              }),
                        ),
                        validator: (value) {
                          if (_confirmpasswordcontroller.text !=
                              _passwordcontroller.text) {
                            return "Password did not match";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {},
                      ),
                    ),

                    const SizedBox(height: 10),

                    //select role text feild
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Expanded(
                        child: DropdownButtonFormField<String>(
                          icon: const Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.deepPurple,
                          ),
                          dropdownColor: Colors.deepPurple.shade50,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            border: UnderlineInputBorder(),
                            labelText: "Choose your Role",
                            prefixIcon: Icon(
                              Icons.accessibility_new_rounded,
                              color: Colors.deepPurple,
                            ),
                            fillColor: Colors.white,
                          ),
                          isDense: true,
                          isExpanded: false,
                          iconEnabledColor: Colors.black,
                          focusColor: Colors.black,
                          items: options.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            setState(() {
                              _currentItemSelected = newValueSelected!;
                              role = newValueSelected;
                            });
                          },
                          value: _currentItemSelected,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    /*
                    //sign up button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            signUp();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                              child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                        ),
                      ),
                    ),
                    */

                    //sign up button
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: LoginButton(
                          title: 'Sign Up',
                          loading: loading,
                          onTap: () {
                            signUp();
                          }),
                    ),

                    const SizedBox(height: 25),

                    //Already a member?Sign in now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'I am a member?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.showloginPage,
                          child: Text(
                            'Login now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
