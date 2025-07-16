// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minorproject/dashboard/widgets/round_button.dart';
import 'package:get/get.dart';

class RegisterLost extends StatefulWidget {
  const RegisterLost({super.key});

  @override
  State<RegisterLost> createState() => _RegisterLostState();
}

class _RegisterLostState extends State<RegisterLost> {
  //form validations
  final _form = GlobalKey<FormState>();

  //textcontroller
  final _namecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _locationcontroller = TextEditingController();
  final _infocontroller = TextEditingController();

  //for image picker
  File? _image;
  final picker = ImagePicker();

  Future getImageGalley() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Get.snackbar(
          'No images selected',
          '',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(25),
          backgroundColor: Colors.deepPurple[100],
        );
        //print('No images selected');
      }
    });
  }

  //circular progress indicator
  bool loading = false;

  //relatime database of firebase
  final databaseRef = FirebaseDatabase.instance.ref('LostandFound');

  //firebase storage
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  void dispose() {
    // ignore: todo
    _namecontroller.dispose();
    _phonecontroller.dispose();
    _locationcontroller.dispose();
    _infocontroller.dispose();
    super.dispose();
  }

  //calling the below functions and sending the data to realtimedatabase and firebase storage
  Future lostDetails() async {
    if (_form.currentState!.validate()) {
      //for having same file name for both image and id of text
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      //firebase storage of image
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          // ignore: prefer_interpolation_to_compose_strings
          .ref('/LostandFoundImage/' + id);
      firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);
      await Future.value(uploadTask);
      var newUrl = await ref.getDownloadURL();
      //firebase realtime database
      databaseRef.child(id).set({
        'name': _namecontroller.text.toString(),
        'phone': int.parse(_phonecontroller.text.toString()),
        'location': _locationcontroller.text.toString(),
        'info': _infocontroller.text.toString(),
        'id': id,
        'image': newUrl.toString(),
      }).then((value) {
        //print('Listed as lost');
        Get.snackbar(
          'Listed as Lost',
          '',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(25),
          backgroundColor: Colors.deepPurple[100],
        );
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        print(error.toString());
        Get.snackbar(
          'Error',
          '',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(25),
          backgroundColor: Colors.deepPurple[100],
        );
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 66, 108, 110),
        title: Text('Register Lost'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //register details
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Register the details of the lost pet !',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  //imagefield
                  Center(
                    child: SizedBox(
                      height: 300,
                      width: 300,
                      child: Card(
                        elevation: 2,
                        shadowColor: Colors.black,
                        child: _image != null
                            ? Image.file(_image!.absolute)
                            : IconButton(
                                iconSize: 150,
                                icon: Icon(Icons.image),
                                color: Colors.purpleAccent[100],
                                onPressed: () {
                                  getImageGalley();
                                },
                              ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  //Name textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name of the pet';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.words,
                      controller: _namecontroller,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        hintText: 'Pet Name',
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  //location textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter last location';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.words,
                      controller: _locationcontroller,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        hintText: 'Last Seen Location',
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
                        icon: Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
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

                  SizedBox(height: 10),

                  //info textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some info about pet';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.sentences,
                      controller: _infocontroller,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.info,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Colors.deepPurple)),
                        hintText: 'Info',
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: RoundButton(
                      title: 'Register as Lost',
                      loading: loading,
                      onTap: () {
                        lostDetails();
                        setState(() {
                          loading = true;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
