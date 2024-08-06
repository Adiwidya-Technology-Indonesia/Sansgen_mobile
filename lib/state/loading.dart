
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: Colors.grey,
          ),
          Gap(10),
          Text(
            "Loading ...",
          ),
        ],
      ),
    );
  }
}
