// ignore_for_file: sized_box_for_whitespace, deprecated_member_use, prefer_const_constructors

import 'package:minorproject/dashboard/organizationalpages/drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Social extends StatefulWidget {
  const Social({super.key});

  @override
  State<Social> createState() => SocialState();
}

class SocialState extends State<Social> {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var card1 = Column(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            height: 120,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Center(
                child: ListTile(
                  dense: false,
                  leading: IconButton(
                      onPressed: () {
                        const url = 'https://www.snehacare.org/';
                        launch(url);
                      },
                      icon: Icon(Icons.public, size: 30, color: Colors.blue)),
                  title: Text(
                    "Sneha's Care",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    "Contact: 9808645023",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        launch('tel:9808645023');
                      },
                      icon: Icon(Icons.phone, size: 30, color: Colors.green)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    var card2 = Column(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            height: 120,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Center(
                child: ListTile(
                  dense: false,
                  leading: IconButton(
                      onPressed: () {
                        const url =
                            'https://www.facebook.com/people/Mahanagar-Animal-Research-Center/100065176403590/?paipv=0&eav=AfapftZu2nzeRMMBqF1T7RVzWD8iytM9YOu45Tth8couhaXFCx3NUcQp20SWLz6uXSY&_rdr/';
                        launch(url);
                      },
                      icon: Icon(Icons.public, size: 30, color: Colors.blue)),
                  title: Text(
                    "Mahanagar Animal Research Center",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    "Contact: 9851059873",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        launch('tel:9851059873');
                      },
                      icon: Icon(Icons.phone, size: 30, color: Colors.green)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    var card3 = Column(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            height: 120,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: ListTile(
                dense: false,
                leading: IconButton(
                    onPressed: () {
                      const url = 'https://www.facebook.com/animalsinnepal/';
                      launch(url);
                    },
                    icon: Icon(Icons.public, size: 30, color: Colors.blue)),
                title: Text(
                  "Shree's Animal Rescue",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  "Contact: 9841344997",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                trailing: IconButton(
                    onPressed: () {
                      launch('tel:9841344997');
                    },
                    icon: Icon(Icons.phone, size: 30, color: Colors.green)),
              ),
            ),
          ),
        ),
      ],
    );
    var card4 = Column(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            height: 150,
            child: Card(
              elevation: 9,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Center(
                child: ListTile(
                  dense: false,
                  leading: IconButton(
                      onPressed: () {
                        const url = 'https://www.streetdogcare.org/';
                        launch(url);
                      },
                      icon: Icon(Icons.public, size: 30, color: Colors.blue)),
                  title: Text(
                    "Street Dog Care",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    "Contact: 9841075383",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        launch('tel:9841075383');
                      },
                      icon: Icon(Icons.phone, size: 30, color: Colors.green)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    var card5 = Column(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            height: 150,
            child: Card(
              elevation: 9,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Center(
                child: ListTile(
                  dense: false,
                  leading: IconButton(
                      onPressed: () {
                        const url = 'https://katcentre.org.np/';
                        launch(url);
                      },
                      icon: Icon(Icons.public, size: 30, color: Colors.blue)),
                  title: Text(
                    "Kathmandu Animal Treatment Centre",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    "Contact: 9843810363",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        launch('tel:9843810363');
                      },
                      icon: Icon(Icons.phone, size: 30, color: Colors.green)),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: const NarBar(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 66, 108, 110),
        title: const Text('Socials'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              card1,
              Container(
                height: 20,
                width: double.infinity,
              ),
              card2,
              Container(
                height: 20,
                width: double.infinity,
              ),
              card3,
              Container(
                height: 20,
                width: double.infinity,
              ),
              card4,
              Container(
                height: 20,
                width: double.infinity,
              ),
              card5,
            ],
          ),
        ),
      ),
    );
  }
}
