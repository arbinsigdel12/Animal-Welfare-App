// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:minorproject/dashboard/userlevelpages/drawer.dart';
import 'package:minorproject/dashboard/userlevelpages/Lostandfound/registerlost.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:url_launcher/url_launcher.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search> {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('LostandFound');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: const NarBar(),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300], //rgba(66,108,110,255)
        title: const Text('Lost & Found '),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: (() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterLost()),
              );
            }),
          ),
        ],
      ),
      body: Padding(
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
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .30,
                                      placeholder: 'assets/images/search.png',
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //name field
                                      Text(
                                        snapshot.child('name').value.toString(),
                                        style: const TextStyle(
                                          fontSize: 30,
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
                                          Icon(
                                            Icons.location_on,
                                            size: 20,
                                            color: Colors.deepPurple[300],
                                          ),
                                          Text(
                                            snapshot
                                                .child('location')
                                                .value
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 107, 106, 106),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
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
                                                  final phonenumeber = snapshot
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
                                          SizedBox(width: 20),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  final phonenumeber = snapshot
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
                                ),
                                const SizedBox(height: 10),
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
                                        color:
                                            Color.fromARGB(255, 107, 106, 106),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //*name display
                            /*Text(
                              snapshot.child('name').value.toString(),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),*/
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
    );
  }
}
