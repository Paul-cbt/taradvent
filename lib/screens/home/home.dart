import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taradvent/models/advent.dart';
import 'package:taradvent/screens/Tiles/dayTile.dart';
import 'package:taradvent/services.dart/authService.dart';
import 'package:taradvent/services.dart/databaseService.dart';
import 'package:taradvent/shared/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Advent advent;
  int tapCounter = 0;
  @override
  void initState() {
    advent = DatabaseService.advent!;
    super.initState();
  }

  void closeAll() async {
    await DatabaseService().closeAll();
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: red.withOpacity(1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      tapCounter++;
                      if (tapCounter > 10) {
                        closeAll();
                        tapCounter = 0;
                      }
                    },
                    child: Text(
                      advent.title,
                      style: TextStyle(
                          color: white, fontFamily: 'QuickSand', fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.1),
              child: Column(
                children: [
                  SizedBox(
                    height: 1,
                  ),
                  StaggeredGrid.count(
                    crossAxisCount: 5,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    children: homeCellSizes.keys.map((e) {
                      print('building $e');
                      return StaggeredGridTile.count(
                          crossAxisCellCount: homeCellSizes[e]![0],
                          mainAxisCellCount: homeCellSizes[e]![1],
                          child: DayTile(
                              adventCase: advent.adventCases
                                  .firstWhere((element) => element.day == e)));
                    }).toList(),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
            SafeArea(
                child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'from ${advent.fromWho}',
                    style: TextStyle(color: white, fontFamily: 'QuickSand'),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      AuthService().signOut();
                      DatabaseService.advent = null;
                      DatabaseService.code = null;
                      var prefs = await SharedPreferences.getInstance();
                      prefs.clear();

                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          color: white,
                        ),
                        Text(
                          'Exit',
                          style:
                              TextStyle(color: white, fontFamily: 'QuickSand'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
