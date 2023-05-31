import 'package:flutter/material.dart';
import 'package:httpwebview/ui/pages/home_page.dart';
import 'create_user_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("http", style: TextStyle(color: Colors.black))),
      body: const HomePage(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateUserScreen())).then((value) => setState(() {}))),
    );
  }
}