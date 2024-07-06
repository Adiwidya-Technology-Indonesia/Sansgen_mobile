import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:gap/gap.dart';
import 'package:sansgen/utils/ext_context.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
        color: context.colorScheme.tertiary,
        size: 60,
      ),
    );
  }
}
