// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:minorproject/dashboard/widgets/round_button.dart';

//import 'adoptionmodel.dart';

class CreateAdoption extends StatefulWidget {
  const CreateAdoption({super.key});

  @override
  State<CreateAdoption> createState() => _CreateAdoptionState();
}

class _CreateAdoptionState extends State<CreateAdoption> {
  //form validations
  final _form = GlobalKey<FormState>();

  //textcontroller
  final _namecontroller = TextEditingController();
  final _gendercontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _breedcontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _locationcontroller = TextEditingController();
  final _infocontroller = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future getImageGalley() async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (PickedFile != null) {
        _image = File(PickedFile.path);
      } else {
        print('No images selected');
      }
    });
  }

  //circular progress indicator
  bool loading = false;

  //firestore and firebase
  //final _auth = FirebaseAuth.instance;

  //relatime database of firebase
  final databaseRef = FirebaseDatabase.instance.ref('Adoptions');

  //firebase storage
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  void dispose() {
    // ignore: todo
    _namecontroller.dispose();
    _gendercontroller.dispose();
    _phonecontroller.dispose();
    _breedcontroller.dispose();
    _agecontroller.dispose();
    _locationcontroller.dispose();
    _infocontroller.dispose();
    super.dispose();
  }

  //calling the below functions and sending the data to realtimedatabase and firebase storage
  Future adoptionDetails() async {
    if (_form.currentState!.validate()) {
      //for having same file name for both image and id of text
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      //firebase storage of image
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          // ignore: prefer_interpolation_to_compose_strings
          .ref('/AdoptionsImage/' + id);
      firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);
      await Future.value(uploadTask);
      var newUrl = await ref.getDownloadURL();
      //firebase realtime database
      databaseRef.child(id).set({
        'name': _namecontroller.text.toString(),
        'gender': _gendercontroller.text.toString(),
        'phone': int.parse(_phonecontroller.text.toString()),
        'breed': _breedcontroller.text.toString(),
        'age': int.parse(_agecontroller.text.toString()),
        'location': _locationcontroller.text.toString(),
        'info': _infocontroller.text.toString(),
        'id': id,
        'image': newUrl.toString(),
      }).then((value) {
        print('Adoption Listed');
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        print(error.toString());
        setState(() {
          loading = false;
        });
      });
    }
  }

  /*
  Future postUp() async {
    //authenticate user only
    if (_form.currentState!.validate()) {
      //show a loading circle
      showDialog(
        context: context,
        builder: (context) {
          return Center();
        },
      );
      //add pet details to firebase function is created here and data is allocated below.
      adoptionDetails(
        _namecontroller.text.trim(),
        _phonecontroller.text.trim(),
        _breedcontroller.text.trim(),
        int.parse(_agecontroller.text.trim()),
        _locationcontroller.text.trim(),
        _infocontroller.text.trim(),
      );
    }
    //pop the loading screen
    Navigator.of(context).pop();
  }

  //sending adoptions details to firebase
  Future adoptionDetails(String name, String phonenumber, String breed, int age,
      String location, String info) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    AdoptionModel adoptionModel = AdoptionModel();
    adoptionModel.name = name;
    adoptionModel.age = age;
    adoptionModel.breed = breed;
    adoptionModel.phonenumber = phonenumber as int?;
    adoptionModel.location = location;
    adoptionModel.info = info;
    await firebaseFirestore
        .collection('Adoptions')
        .doc(user?.uid)
        .set(adoptionModel.toMap());
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: const Text('Post out an Adoption'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _form,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'Post the details of the pet that you want to list out on adoption!',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

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
                          icon: const Icon(Icons.info),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple)),
                          hintText: 'Pet Name',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    //Gender textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter gender of the pet';
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                        controller: _gendercontroller,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.info_rounded),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple)),
                          hintText: 'Gender of the Pet',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    //Age textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the age of the pet';
                          }
                          return null;
                        },
                        controller: _agecontroller,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.numbers),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple)),
                          hintText: 'Pet Age',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),

                    const SizedBox(height: 10),

                    //Breed textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter breed of the pet';
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                        controller: _breedcontroller,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.info_rounded),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple)),
                          hintText: 'Pet Breed type',
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
                          icon: const Icon(Icons.phone_android),
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

                    //location textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your location';
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                        controller: _locationcontroller,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.location_city),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple)),
                          hintText: 'Your Location',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

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
                          icon: const Icon(Icons.info_sharp),
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

                    const SizedBox(height: 10),

                    //select image field
                    InkWell(
                      onTap: () {
                        getImageGalley();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: _image != null
                            ? Image.file(_image!.absolute)
                            : const Center(child: Icon(Icons.image)),
                      ),
                    ),

                    const SizedBox(height: 10),

                    //Postdetails button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: RoundButton(
                        title: 'Post Now',
                        loading: loading,
                        onTap: () {
                          setState(() {
                            loading = true;
                          });
                          adoptionDetails();
                        },
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
