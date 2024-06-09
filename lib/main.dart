import 'package:flutter/material.dart';
import 'package:trab/themes/colors.dart';
import 'package:trab/view/home_screen.dart';
import 'package:trab/view/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:trab/provider/rest_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EventTicketRestProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Let\'s Ticket',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        // home: const MyHomePage(title: 'Home'),
        home: const HomeScreen());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreen(),
    );
  }
}
