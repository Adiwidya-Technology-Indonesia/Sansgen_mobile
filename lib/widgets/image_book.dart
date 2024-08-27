import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sansgen/utils/ext_string.dart';

Widget imageBook({
  required String image,
  required double height,
  required double width,
  required double radius,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: image.isUrl
        ? CachedNetworkImage(
            imageUrl: image,
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
              // Tampilkan placeholder jika image bukan URL yang valid
              height: height,
              width: width,
              color: Colors.grey,
              child: const Center(
                child: Icon(Icons.image_not_supported),
              ),
            ),
          )
        : Container(
            // Tampilkan placeholder jika image bukan URL yang valid
            height: height,
            width: width,
            color: Colors.grey,
            child: const Center(
              child: Icon(Icons.image_not_supported),
            ),
          ),
  );
}
