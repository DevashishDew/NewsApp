import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
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
                  Text(body + body + body + body + body),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
