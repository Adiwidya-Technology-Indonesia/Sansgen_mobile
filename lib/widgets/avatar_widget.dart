import 'package:flutter/material.dart';
import 'package:sansgen/utils/ext_context.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.image,
    this.width = 80,
    this.height = 80,
    this.radius = 70,
    this.heightPlus = 10,
  });

  final String? image;
  final double? height;
  final double? heightPlus;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: image != null
            ? Image.network(
                image!,
                height: height,
                width: width,
                fit: BoxFit.cover,
              )
            : Icon(
                Icons.person_pin,
                size: height! + heightPlus!,
                color: context.colorScheme.error,
              ),
      ),
    );
  }
}
