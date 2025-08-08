import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:payzone/logo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PayZone());
}

class PayZone extends StatelessWidget {
  const PayZone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: logo(),
    );
  }
}
