import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sansgen/keys/assets_icons.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/utils/ext_string.dart';

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
        child: (image!.isUrl)
            ? CachedNetworkImage(
                imageUrl: image!,
                height: height,
                width: width,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: height,
                  width: width,
                  color: Colors.grey,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: context.colorScheme.secondary.withOpacity(0.2),
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    KeysAssetsIcons.user,
                    width: width,
                    height: height,
                    colorFilter: ColorFilter.mode(
                      context.colorScheme.onSecondary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              )
            : Container(
                color: context.colorScheme.secondary.withOpacity(0.2),
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  KeysAssetsIcons.user,
                  width: width,
                  height: height,
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
