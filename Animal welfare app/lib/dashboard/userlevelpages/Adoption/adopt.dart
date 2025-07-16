// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:minorproject/dashboard/userlevelpages/Adoption/petdetails.dart';
import 'package:minorproject/dashboard/userlevelpages/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class Adopt extends StatefulWidget {
  const Adopt({super.key});

  @override
  State<Adopt> createState() => AdoptState();
}

class AdoptState extends State<Adopt> {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Adoptions');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: const NarBar(),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: const Text('Adoption'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: (() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateAdoption()),
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
                                          0.50,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .30,
                                      placeholder: 'assets/images/adoption.png',
                                      image: snapshot
                                          .child('image')
                                          .value
                                          .toString()),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                //delete section
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
                                            .child('breed')
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

                                      //gender field
                                      Text(
                                        snapshot
                                            .child('gender')
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
                                      Row(
                                        children: [
                                          Text(
                                            snapshot
                                                .child('age')
                                                .value
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 107, 106, 106),
                                            ),
                                          ),
                                          const Text(
                                            ' years old.',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 107, 106, 106),
                                            ),
                                          ),
                                        ],
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
                                          Text(
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
                                        ],
                                      ),
                                      const SizedBox(height: 10),

                                      //call and message button
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              final phonenumeber = snapshot
                                                  .child('phone')
                                                  .value
                                                  .toString();
                                              final url = 'tel:$phonenumeber';
                                              launch(url);
                                            },
                                            icon: const Icon(
                                              Icons.phone,
                                              color: Colors.green,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              final phonenumeber = snapshot
                                                  .child('phone')
                                                  .value
                                                  .toString();
                                              final url = 'sms:$phonenumeber';
                                              launch(url);
                                            },
                                            icon: const Icon(
                                              Icons.message,
                                              color: Colors.orange,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),

                            const SizedBox(height: 10),

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
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            /*
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SizedBox(
                  width: 500,
                  height: 100,
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: StreamBuilder(
                        stream: ref.onValue,
                        builder:
                            (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                          if (!snapshot.hasData) {
                            return const Text('loading');
                          } else {
                            Map<dynamic, dynamic> map =
                                snapshot.data!.snapshot.value as dynamic;
                            List<dynamic> list = [];
                            list.clear();
                            list = map.values.toList();
                            return ListView.builder(
                              itemCount: snapshot.data!.snapshot.children.length,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                  title: Text(list[index]['name']),
                                  subtitle: Text(list[index]['gender']),
                                );
                              }),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            */

            /*
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                defaultChild: const Text('Loading'),
                itemBuilder: (context, snapshot, animation, index) {
                  return ListTile(
                    title: Text(snapshot.child('name').value.toString()),
                    subtitle: Text(snapshot.child('age').value.toString()),
                  );
                },
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}
