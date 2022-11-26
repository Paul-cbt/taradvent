import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taradventapp/services.dart/authService.dart';
import 'package:taradventapp/wrapper.dart';
import 'firebase_options.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    Widget app = const TaradventApp();
    runApp(app);
  }, (error, stack) {});
}

//flutter pub run build_runner build --delete-conflicting-outputs

class TaradventApp extends StatefulWidget {
  const TaradventApp({super.key});

  @override
  State<TaradventApp> createState() => _TaradventAppState();
}

class _TaradventAppState extends State<TaradventApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taradvent',
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => Wrapper()},
    );
  }
}
