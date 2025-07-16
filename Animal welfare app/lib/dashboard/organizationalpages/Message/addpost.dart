// ignore_for_file: must_be_immutable, camel_case_types

import 'package:minorproject/dashboard/organizationalpages/Message/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class addnote extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('posts');

  addnote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 66, 108, 110),
        actions: [
          MaterialButton(
            splashColor: Colors.red[600],
            onPressed: () {
              ref.add({'title': title.text, 'body': body.text}).whenComplete(
                  () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const Message()));
              });
            },
            child: const Text(
              "Save",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: title,
                expands: true,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          /*
          Expanded(
            flex: 15,
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: body,
                expands: true,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Body',
                ),
              ),
            ),
          ),
          */
        ],
      ),
    );
  }
}
