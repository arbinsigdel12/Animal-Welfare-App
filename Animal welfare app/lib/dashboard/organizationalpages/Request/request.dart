// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
//import 'package:minorproject/dashboard/organizationalpages/drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => RequestState();
}

class RequestState extends State<Request> {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('RequestHelp');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      //drawer: const NarBar(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 66, 108, 110),
        title: const Text('Request'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder:
                      (BuildContext context, snapshot, animation, index) {
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //imagedisplay
                              Row(
                                children: [
                                  //image section
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage.assetNetwork(
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.50,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .30,
                                        placeholder: 'assets/images/siren.png',
                                        image: snapshot
                                            .child('image')
                                            .value
                                            .toString()),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  //details section
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            height: 50,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      ref
                                                          .child(snapshot
                                                              .child('id')
                                                              .value
                                                              .toString())
                                                          .remove();
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        //name field
                                        Text(
                                          snapshot
                                              .child('animal')
                                              .value
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 107, 106, 106),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        //breed field
                                        Text(
                                          snapshot
                                              .child('injury')
                                              .value
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 107, 106, 106),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),

                                        //location field
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              size: 15,
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot
                                                    .child('location')
                                                    .value
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 107, 106, 106),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        //call and message button
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () async {
                                                    final phonenumeber =
                                                        snapshot
                                                            .child('phone')
                                                            .value
                                                            .toString();
                                                    final url =
                                                        'tel:$phonenumeber';
                                                    launch(url);
                                                  },
                                                  icon: const Icon(
                                                    Icons.phone,
                                                    color: Colors.green,
                                                    size: 30,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 20),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () async {
                                                    final phonenumeber =
                                                        snapshot
                                                            .child('phone')
                                                            .value
                                                            .toString();
                                                    final url =
                                                        'tel:$phonenumeber';
                                                    launch(url);
                                                  },
                                                  icon: const Icon(
                                                    Icons.message,
                                                    color: Colors.orange,
                                                    size: 30,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              //info display
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.info,
                                      color: Colors.purple[100],
                                      size: 15,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        snapshot.child('info').value.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 107, 106, 106),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
