// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minorproject/dashboard/userlevelpages/drawer.dart';
import 'package:minorproject/dashboard/widgets/round_button.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  //form validations
  final _form = GlobalKey<FormState>();

  //textcontroller
  final _infocontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _placemarkController = TextEditingController();

  //circular progress indicator
  bool loading = false;

  //relatime database of firebase
  final databaseRef = FirebaseDatabase.instance.ref('RequestHelp');

  //firebase storage
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  void dispose() {
    // ignore: todo
    _phonecontroller.dispose();
    _infocontroller.dispose();
    _longitudeController.dispose();
    _longitudeController.dispose();
    _placemarkController.dispose();
    super.dispose();
  }

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
        print('No images selected');
      }
    });
  }

  //get location details
  Future<void> _getLocation() async {
    setState(() {
      loading = true;
    });
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      _latitudeController.text = position.latitude.toString();
      _longitudeController.text = position.longitude.toString();
      _placemarkController.text =
          "${placemarks[0].street!}, ${placemarks[0].locality!}";
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to get location.'),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  //calling the below functions and sending the data to realtimedatabase and firebase storage
  Future requestDetails() async {
    if (_form.currentState!.validate()) {
      //for having same file name for both image and id of text
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      //firebase storage of image
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          // ignore: prefer_interpolation_to_compose_strings
          .ref('/RequestImage/' + id);
      firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);
      await Future.value(uploadTask);
      var newUrl = await ref.getDownloadURL();
      //firebase realtime database
      databaseRef.child(id).set({
        'phone': int.parse(_phonecontroller.text.toString()),
        'info': _infocontroller.text.toString(),
        'id': id,
        'image': newUrl.toString(),
        'animal': animal.toString(),
        'injury': injury.toString(),
        'location': _placemarkController.text.toString(),
      }).then((value) {
        //print('Listed as lost');
        Get.snackbar(
          'Help request Posted',
          '',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(25),
          backgroundColor: Colors.deepPurple[100],
        );
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        //print(error.toString());
        Get.snackbar(
          'Error occured',
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

  //animal type drop down
  var options = [
    'Dog',
    'Cat',
    'Cattle',
    'Birds',
    'Others',
  ];
  var _currentItemSelected = "Dog";
  var animal = "Dog";

  //injury type drop down
  var injuries = [
    'Peck',
    'Bite',
    'Stomped',
  ];
  var _injurySelected = "Peck";
  var injury = "Bite";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      drawer: const NarBar(),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: const Text('Request Immediate help'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),

                //animal type field
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
                        labelText: "Animal Type",
                        icon: Icon(
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
                          animal = newValueSelected;
                        });
                      },
                      value: _currentItemSelected,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                //injury type field
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
                        labelText: "Type of Injury",
                        icon: Icon(
                          Icons.accessibility_new_rounded,
                          color: Colors.deepPurple,
                        ),
                        fillColor: Colors.white,
                      ),
                      isDense: true,
                      isExpanded: false,
                      iconEnabledColor: Colors.black,
                      focusColor: Colors.black,
                      items: injuries.map((String dropDownStringItem) {
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
                          _injurySelected = newValueSelected!;
                          injury = newValueSelected;
                        });
                      },
                      value: _injurySelected,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                //description on enjury
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
                        color: Colors.deepPurple,
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

                SizedBox(height: 10),

                //contact details field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: _phonecontroller,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.deepPurple,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
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

                //getlocation text feild
                //description on enjury
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some info about pet';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.sentences,
                    controller: _latitudeController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.info,
                        color: Colors.deepPurple,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.deepPurple)),
                      hintText: 'Latitude',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                //description on enjury
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some info about pet';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.sentences,
                    controller: _longitudeController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.info,
                        color: Colors.deepPurple,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.deepPurple)),
                      hintText: 'longitude',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                //description on enjury
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some info about pet';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.sentences,
                    controller: _placemarkController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.info,
                        color: Colors.deepPurple,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.deepPurple)),
                      hintText: 'Placemark',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                SizedBox(height: 20),
                //submit button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: RoundButton(
                    title: 'Get Location',
                    loading: loading,
                    onTap: () {
                      setState(() {
                        loading = true;
                      });
                      _getLocation();
                    },
                  ),
                ),

                SizedBox(height: 20),
                //submit button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: RoundButton(
                    title: 'Request Now',
                    loading: loading,
                    onTap: () {
                      setState(() {
                        loading = true;
                      });
                      requestDetails();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
