// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Whatwedo extends StatelessWidget {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final String wedolistImage;
  final String wedolistName;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  Whatwedo({
    required this.wedolistImage,
    required this.wedolistName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.grey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(wedolistImage),
            ),

            //name
            Text(
              wedolistName,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('VIEW MORE'),

                // ignore: avoid_unnecessary_containers
                Container(
                    child: ElevatedButton.icon(
                  onPressed: () {
                    const url = 'https://www.snehacare.org/what-we-do/';
                    launch(url);
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                  label: const Text(
                    '',
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
