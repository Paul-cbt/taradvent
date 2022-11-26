import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taradvent/screens/home/home.dart';
import 'package:taradvent/services.dart/databaseService.dart';
import 'package:taradvent/shared/constants.dart';
import 'package:taradvent/shared/loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = true;
  String? code;
  String errorText = '';

  @override
  void initState() {
    checkLocalCode();
    super.initState();
  }

  Future linkCode() async {
    bool result = await DatabaseService().getAdvent(code!);
    if (result == false) {
      setState(() {
        errorText = 'Invalid Advent code :(';
        isLoading = false;
      });
    } else {
      print('valid code, pushing home');
      Navigator.of(context).pushReplacement(CupertinoPageRoute(
        builder: (context) => const Home(),
      ));
    }
  }

  void checkLocalCode() async {
    print('checking local code');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('code') != null) {
      code = prefs.getString('code')!;
      print('checking local code $code');

      linkCode();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: red,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: isLoading
            ? Loading()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(),
                  Spacer(),
                  Text(
                    'Welcome !',
                    style: TextStyle(
                        color: white, fontFamily: 'QuickSand', fontSize: 35),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'enter your advent code and you\'re in!',
                    style: TextStyle(
                        color: white, fontFamily: 'QuickSand', fontSize: 13),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: Pinput(
                      length: 4,
                      onCompleted: (String value) {
                        setState(() {
                          code = value;
                          isLoading = true;
                        });
                        linkCode();
                      },
                      defaultPinTheme: PinTheme(
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(3)),
                        height: 45,
                        width: 30,
                      ),
                    ),
                  ),
                  Spacer(),
                  if (errorText.isNotEmpty)
                    Text(
                      errorText,
                      style: TextStyle(fontSize: 20, color: white),
                    ),
                  Spacer(),
                  Image.asset(
                    kIsWeb ? 'christmas-tree.png' : 'assets/christmas-tree.png',
                    height: MediaQuery.of(context).size.height / 2,
                  )
                ],
              ),
      ),
    );
  }
}
