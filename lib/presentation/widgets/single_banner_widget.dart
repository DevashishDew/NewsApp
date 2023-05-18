import 'package:flutter/material.dart';
import 'package:news_app/data/models/nested_data.dart';
import 'package:transparent_image/transparent_image.dart';

class SingleBannerWidget extends StatelessWidget {
  const SingleBannerWidget({
    super.key,
    required this.imageData,
  });

  final ImageComponent imageData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(imageData.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Text(
              imageData.imageTitle,
              style:
              const TextStyle(fontSize: 20, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

