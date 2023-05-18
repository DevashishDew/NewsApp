
import 'package:flutter/material.dart';
import 'package:news_app/data/models/nested_data.dart';
import 'package:transparent_image/transparent_image.dart';

class HorizontalListWidget extends StatelessWidget {
  const HorizontalListWidget({
    super.key,
    required this.horizontalComp,
  });

  final HorizontalComponent horizontalComp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: horizontalComp.horizontalsubcomp.length,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(horizontalComp
                      .horizontalsubcomp[index].imageUrl),
                  fit: BoxFit.cover,
                  height: 100,
                  width: 120,
                ),
              ),
              Text(
                horizontalComp.horizontalsubcomp[index].title,
                style: const TextStyle(
                    fontSize: 20, color: Colors.deepPurpleAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}