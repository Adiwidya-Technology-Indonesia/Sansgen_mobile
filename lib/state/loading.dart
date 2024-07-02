import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:sansgen/utils/ext_context.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          LoadingBouncingGrid.square(
            borderColor: context.colorScheme.tertiary,
            borderSize: 3.0,
            size: 60.0,
            backgroundColor: context.colorScheme.surface,
            duration: const Duration(milliseconds: 1000),
          ),
          Text(
            "Loading ...",
            style: context.xTextTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
