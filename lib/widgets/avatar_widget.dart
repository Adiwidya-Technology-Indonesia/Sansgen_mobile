import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

// import 'package:octo_image/octo_image.dart';
import 'package:sansgen/model/image_hash.dart';
import 'package:sansgen/utils/ext_context.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.imageHash,
    this.width = 80,
    this.height = 80,
    this.radius = 70,
    this.heightPlus = 10,
  });

  final ImageHash? imageHash;
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
        child: imageHash != null
            ? OctoImage(
                image: CachedNetworkImageProvider(
                  imageHash!.imageUrl,
                  cacheKey: imageHash!.imageUrl,
                ),
                // placeholderBuilder: OctoPlaceholder.blurHash(
                //   'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                // ),
                progressIndicatorBuilder: (context, progress) {
                  // double? value;
                  // var expectedBytes = progress?.expectedTotalBytes;
                  // if (progress != null && expectedBytes != null) {
                  //   value = progress.cumulativeBytesLoaded / expectedBytes;
                  // }
                  return Card(
                    margin: const EdgeInsets.all(0),
                    color: context.colorScheme.secondary,
                  );
                },
                errorBuilder: OctoError.icon(color: context.colorScheme.error),
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
