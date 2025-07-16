import 'package:minorproject/authorization/authpage.dart';
import 'package:minorproject/dashboard/userlevelpages/Adoption/adopt.dart';
import 'package:minorproject/dashboard/userlevelpages/faq.dart';
import 'package:minorproject/registrationandsignup/home_page.dart';
import 'package:minorproject/dashboard/userlevelpages/Lostandfound/lostnfound.dart';
import 'package:minorproject/dashboard/userlevelpages/setting.dart';
import 'package:minorproject/dashboard/userlevelpages/Organizations/vet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NarBar extends StatefulWidget {
  const NarBar({super.key});

  @override
  State<NarBar> createState() => _NarBarState();
}

class _NarBarState extends State<NarBar> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Individual",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )),
            accountEmail: Text(user.email!,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("assets/images/profile.png"),
              ),
            ),
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
                color: Colors.deepPurple[300],
                // ignore: prefer_const_constructors
                image: DecorationImage(
                  image: const NetworkImage(
                    "https://wallpaperaccess.com/download/white-clouds-2130974",
                  ),
                  fit: BoxFit.cover,
                )),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home Menu"),
            // ignore: avoid_returning_null_for_void
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Adopt"),
            // ignore: avoid_returning_null_for_void
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Adopt()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text("Lost And Found"),
            // ignore: avoid_returning_null_for_void
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Search()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_hospital),
            title: const Text("Organization"),
            // ignore: avoid_returning_null_for_void
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Vet()));
            },
          ),
          const Divider(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            // ignore: avoid_returning_null_for_void
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Setting()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text("About us"),
            // ignore: avoid_returning_null_for_void
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Faq()));
            },
          ),
          const Divider(),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Sign out"),
              onTap: () {
                FirebaseAuth.instance.signOut();
              }),
        ],
      ),
    );
  }
}
