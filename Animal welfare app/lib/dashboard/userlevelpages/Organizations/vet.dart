// ignore_for_file: sized_box_for_whitespace

import 'package:minorproject/dashboard/organizationalpages/drawer.dart';
import 'wedo.dart';
import 'package:flutter/material.dart';
import 'howtohelp.dart';

class Vet extends StatefulWidget {
  const Vet({super.key});

  @override
  State<Vet> createState() => VetState();
}

class VetState extends State<Vet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NarBar(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple[300],
        title: const Text('Partners'),
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          //heading
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'SNEHA CARE',
              style: TextStyle(fontSize: 30),
            ),
          ),
          SizedBox(
            child: Image.asset(
              'assets/images/download.png',
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(height: 10),

          //What we do
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'WHAT WE DO',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 3),

          //horizontal listview
          Container(
            height: 220,
            child: Expanded(
                child: ListView(
              scrollDirection: Axis.horizontal,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Whatwedo(
                  wedolistImage: 'assets/images/4.jpg',
                  wedolistName: 'DOG MANAGEMENT',
                ),
                Whatwedo(
                  wedolistImage: 'assets/images/5.jpg',
                  wedolistName: 'FARM ANIMAL WELFARE',
                ),
                Whatwedo(
                  wedolistImage: 'assets/images/7.jpg',
                  wedolistName: 'PLANT BASED DIET',
                ),
                Whatwedo(
                  wedolistImage: 'assets/images/1.jpg',
                  wedolistName: 'ANIMAL IN DISASTER',
                ),
              ],
            )),
          ),

          //How to help
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'HOW TO HELP',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 3),

          //horizontal listview
          Container(
            height: 220,
            child: Expanded(
                child: ListView(
              scrollDirection: Axis.horizontal,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Howtohelp(
                  howtolistImage: 'assets/images/2.jpg',
                  howtolistName: 'DONATE NOW',
                ),
                Howtohelp(
                  howtolistImage: 'assets/images/3.jpg',
                  howtolistName: 'ADOPT',
                ),
                Howtohelp(
                  howtolistImage: 'assets/images/8.jpg',
                  howtolistName: 'SPONSER',
                ),
                //Howtohelp(
                // howtolistImage: 'assets/6.jpg',
                //  howtolistName: 'VOLUNTEER',
                //),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
