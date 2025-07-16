// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:minorproject/dashboard/userlevelpages/drawer.dart';
import 'package:flutter/material.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => FaqState();
}

class FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: const NarBar(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 66, 108, 110),
        title: const Text('Faq'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ExpansionTile(
                  backgroundColor: Colors.grey[700],
                  collapsedBackgroundColor: Colors.grey[700],
                  title: const Text(
                    'What does our app do?',
                  ),
                  children: [
                    const ListTile(
                      title: Text(
                          "Our app's primary focus is to provide immediate emergency services to any injured animal.Along with that, users can also put up animals for adoption and also view other animals putup for adoption."),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ExpansionTile(
                  backgroundColor: Colors.grey[700],
                  collapsedBackgroundColor: Colors.grey[700],
                  title: const Text(
                    'How does our app work?',
                  ),
                  children: [
                    const ListTile(
                      title: Text(
                          "Our app works by sharing current location of the injured animal along with it's images so that the rescuer's can come prepared."),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ExpansionTile(
                  backgroundColor: Colors.grey[700],
                  collapsedBackgroundColor: Colors.grey[700],
                  title: const Text(
                    'Why did we develop this app?',
                  ),
                  children: [
                    const ListTile(
                      title: Text(
                          'This app was developed with an intent to provide better life for animals, specially street animals and to promote the culture of adoption of such animals in Nepal.'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
