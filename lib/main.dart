import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/providers/contact_provider.dart';
import 'package:test_app/screens/signin_screen.dart';


void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContactProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'testApp',
      initialRoute: '/',
      routes: {
        '/': (ctx) => const SigninScreen(),
      },
    );
  }
}
