import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    Key? key,
    required this.error,
  }) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "message : $error",
      ),
    );
  }
}
