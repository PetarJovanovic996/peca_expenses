import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:peca_expenses/firebase_options.dart';
import 'package:peca_expenses/main/my_app.dart';

// // done: Define theme in a separate file

// done: Good practice is to have main.dart only contain main method
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// done: Extract MyApp to separate file
