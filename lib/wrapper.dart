import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart' as p;

import 'package:flutter/material.dart';
import 'package:taradventapp/screens/home/home.dart';
import 'package:taradventapp/screens/login/loginPage.dart';
import 'package:taradventapp/services.dart/databaseService.dart';
import 'package:taradventapp/shared/appBarStyle.dart';

class Wrapper extends StatefulWidget {
  final String? deepLink;

  const Wrapper({
    this.deepLink,
  });
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isinit = false;

  User? user;

  @override
  Widget build(BuildContext context) {
    print('here');
    setAppbarStyle(context);

    if (DatabaseService.advent == null) {
      return LoginPage();
    } else {
      return WillPopScope(
        onWillPop: () async => false,
        child: Home(),
      );
    }
  }
}
