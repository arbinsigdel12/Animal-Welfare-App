// ignore_for_file: must_be_immutable, camel_case_types, library_private_types_in_public_api

import 'package:minorproject/dashboard/organizationalpages/Message/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({super.key, required this.docid});

  @override
  _editnoteState createState() => _editnoteState();
}

class _editnoteState extends State<editnote> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  @override
  void initState() {
    title = TextEditingController(text: widget.docid.get('title'));
    super.initState();
  }

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
              widget.docid.reference.update({
                'title': title.text,
                'body': body.text,
              }).whenComplete(() {
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
          MaterialButton(
            splashColor: Colors.red[600],
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const Message()));
              });
            },
            child: const Text(
              "Delete",
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
                  hintText: 'title',
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
