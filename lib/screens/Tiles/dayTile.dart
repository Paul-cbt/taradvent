import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:taradvent/models/adventCase.dart';
import 'package:taradvent/services.dart/databaseService.dart';
import 'package:taradvent/shared/constants.dart';

class DayTile extends StatefulWidget {
  final AdventCase adventCase;
  const DayTile({super.key, required this.adventCase});

  @override
  State<DayTile> createState() => _DayTileState();
}

class _DayTileState extends State<DayTile> {
  bool isOpended = false;
  bool isLocked = false;

  @override
  void initState() {
    isLocked = !(DateTime.now().day >= widget.adventCase.day &&
        DateTime.now().month == 12);
    isOpended = widget.adventCase.isOpeneded;
    super.initState();
  }

  void openCase() async {
    await DatabaseService().openDay(widget.adventCase.day);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return NeumorphicButton(
            style: NeumorphicStyle(
                color: isOpended ? green : red,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(0)),
                lightSource: LightSource.bottomRight,
                intensity: 0.4),
            padding: EdgeInsets.zero,
            onPressed: () {
              double aspectRatio = constraints.maxWidth / constraints.maxHeight;
              Navigator.of(context).push(PageRouteBuilder(
                opaque: false,
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.1),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height - 40,
                              maxWidth: MediaQuery.of(context).size.width),
                          child: AspectRatio(
                            aspectRatio: aspectRatio,
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              return SizedBox(
                                height: constraints.maxHeight,
                                width: constraints.maxHeight,
                                child: Hero(
                                  tag: widget.adventCase.day,
                                  child: FlipCard(
                                    onFlip: () {
                                      if (!isLocked) {
                                        if (!isOpended) {
                                          openCase();
                                          HapticFeedback.heavyImpact();
                                        }
                                        setState(() {
                                          isOpended = !isOpended;
                                        });
                                      } else {
                                        HapticFeedback.heavyImpact();
                                      }
                                    },
                                    front: Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: widget.adventCase.day == 14
                                              ? pink
                                              : red,
                                        ),
                                        child: Center(
                                          child: Text(
                                            widget.adventCase.day.toString(),
                                            style: TextStyle(
                                                color: white,
                                                fontFamily: 'QuickSand',
                                                fontSize: (constraints
                                                                .maxHeight <
                                                            constraints.maxWidth
                                                        ? constraints.maxHeight
                                                        : constraints
                                                            .maxWidth) /
                                                    2.6),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    back: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: isLocked
                                          ? Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    widget.adventCase.day == 14
                                                        ? pink
                                                        : red,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      widget.adventCase.day ==
                                                              14
                                                          ? Icons.favorite
                                                          : Icons.lock,
                                                      color: white,
                                                      size: (constraints
                                                                      .maxHeight <
                                                                  constraints
                                                                      .maxWidth
                                                              ? constraints
                                                                  .maxHeight
                                                              : constraints
                                                                  .maxWidth) /
                                                          2.6,
                                                    ),
                                                    if (widget.adventCase.day ==
                                                        14)
                                                      Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: Text(
                                                          'Not yet mon bébé <3',
                                                          style: TextStyle(
                                                              color: white),
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(
                                              color: widget.adventCase.day == 14
                                                  ? pink
                                                  : green,
                                              child: Center(
                                                child: SingleChildScrollView(
                                                  child: Text(
                                                    widget.adventCase.text
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: white,
                                                        fontFamily: 'QuickSand',
                                                        fontSize: 20),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ));
            },
            child: Hero(
              tag: widget.adventCase.day,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  color: isOpended
                      ? widget.adventCase.day == 14
                          ? pink
                          : green
                      : red,
                  child: Center(
                    child: Text(
                      widget.adventCase.day.toString(),
                      style: TextStyle(
                          color: white,
                          fontFamily: 'QuickSand',
                          fontSize:
                              (constraints.maxHeight < constraints.maxWidth
                                      ? constraints.maxHeight
                                      : constraints.maxWidth) /
                                  2.6),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
