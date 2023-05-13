import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsItem extends StatelessWidget {
  NewsItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(body),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.share,
                          color: Colors.blue,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.thumb_up,
                          color: Colors.blue,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
