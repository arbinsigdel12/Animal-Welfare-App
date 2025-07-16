// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:minorproject/authorization/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:minorproject/dashboard/organizationalpages/Donation/donation.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PashuApp());
}

class PashuApp extends StatelessWidget {
  const PashuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_e9bd4cd6b15c43058f0d79cd3c617bc2",
        builder: (context, navigatorKey) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            theme: ThemeData(
                primaryColor: const Color(0xFF56328c),
                appBarTheme: const AppBarTheme(
                  color: Color(0xFF56328c),
                )),
            title: 'Khalti Payment',
            home: const MainPage(),
          );
        });
  }
}
