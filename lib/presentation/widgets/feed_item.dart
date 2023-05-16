import 'dart:io';
import 'package:flutter/material.dart';
import 'package:news_app/data/models/news_feed.dart';
import 'package:transparent_image/transparent_image.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({
    Key? key,
    required this.newsFeed,
  }) : super(key: key);

  final NewsFeed newsFeed;


  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          newsFeed.imageUrl.isNotEmpty ? FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(newsFeed.imageUrl),
            fit: BoxFit.cover,
            height: 180,
            width: double.infinity,
          ) : Image.file(
            File(newsFeed.imageLocalUrl.toString()),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 180,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newsFeed.newsTitle,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(newsFeed.newsContent),
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
                      ),
                    ),
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
