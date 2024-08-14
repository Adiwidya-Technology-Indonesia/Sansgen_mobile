import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../keys/assets_icons.dart';

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
        child: image != null && image != ''
            ? Image.network(
                image!,
                height: height,
                width: width,
                fit: BoxFit.cover,
              )
            : Container(
                color: context.colorScheme.secondary.withOpacity(0.2),
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  KeysAssetsIcons.user,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.onSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
      ),
    );
  }
}
