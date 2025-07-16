import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SearchOption extends StatefulWidget {
  const SearchOption({super.key});

  @override
  State<SearchOption> createState() => _SearchOptionState();
}

class _SearchOptionState extends State<SearchOption> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref('Adoptions');
    final searchController = TextEditingController();
    //String search = '';
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                  ),
                  child: TextFormField(
                    controller: searchController,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search for animals',
                        prefixIcon: Icon(
                          Icons.search,
                        )),
                    onChanged: (String text) {
                      search = text;
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  String temptitle =
                      snapshot.child('location').value.toString();
                  String tempTitle = snapshot.child('breed').value.toString();
                  if (searchController.text.isEmpty) {
                    return Container();
                  } else if (temptitle.toLowerCase().contains(
                          searchController.text.toLowerCase().toLowerCase()) ||
                      tempTitle.toLowerCase().contains(
                          searchController.text.toLowerCase().toLowerCase())) {
                    return Expanded(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: FadeInImage.assetNetwork(
                                              fit: BoxFit.cover,
                                              width:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.50,
                                              height:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .30,
                                              placeholder:
                                                  'assets/images/adoption.png',
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: 50,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 100.0),
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
                                                    .child('name')
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 107, 106, 106),
                                                    ),
                                                  ),
                                                  const Text(
                                                    ' years old.',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.phone,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.info,
                                            color: Colors.purple[100],
                                            size: 15,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              snapshot
                                                  .child('info')
                                                  .value
                                                  .toString(),
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
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
