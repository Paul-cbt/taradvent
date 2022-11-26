import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:taradventapp/shared/constants.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 60,
        child: LoadingIndicator(
          indicatorType: Indicator.orbit,
          colors: [green, beige],
          strokeWidth: 2,
        ),
      ),
    );
  }
}
