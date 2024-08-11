import 'package:flutter/material.dart';
import 'package:sansgen/utils/ext_string.dart';

Widget imageBook({
  required String image,
  required double height,
  required double width,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: image.isUrl
        ? Image.network(
            image,
            height: height,
            width: width,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Tampilkan placeholder jika terjadi kesalahan saat memuat gambar
              return Container(
                height: 160,
                width: 130,
                color: Colors.grey,
                child: const Center(
                  child: Icon(Icons.error),
                ),
              );
            },
          )
        : Container(
            // Tampilkan placeholder jika image bukan URL yang valid
            height: 160,
            width: 130,
            color: Colors.grey,
            child: const Center(
              child: Icon(Icons.image_not_supported),
            ),
          ),
  );
}
