// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:httpwebview/core/https/user_https.dart';
import 'package:httpwebview/core/models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
    future: UserHttp().listOfUsers(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child:  CircularProgressIndicator());
      }
      if(!snapshot.hasData && snapshot.hasError) {
        return const Center(child:  CircularProgressIndicator());
      }
      return ListView(
        children: snapshot.data!.map((e) => itemCategory(e, context)).toList(),
      );
    },
  );
}

Widget itemCategory(User data, BuildContext context) {
  return ListTile(
    title: Text(data.name ?? ""),
    trailing: GestureDetector(onTap: () => _showCupertinoDialog(data, context),
    child:  const Icon(Icons.more_horiz)),
  );
}
 
 void _showCupertinoDialog(User data, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text('Delete User?'),
        content: const Text('Cannot restored if you select yes'),
        actions: [
          TextButton(
            onPressed: () async {
              var resp = await UserHttp().deleteUsers(data.id!);
              if (resp) {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Succes Delete User");
                setState(() {});
              }
            },
          child: const Text('Yes')),
          TextButton(onPressed:  () => Navigator.pop(context), child: const Text('No')),
        ],
      );
    });
 }
}