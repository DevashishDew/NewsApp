import 'package:flutter/material.dart';
import 'package:news_app/data/models/nested_data.dart';
import 'package:news_app/presentation/widgets/horizontal_list_widget.dart';
import 'package:news_app/presentation/widgets/single_banner_widget.dart';
import 'package:news_app/presentation/widgets/video_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class NestedListScreen extends StatefulWidget {
  const NestedListScreen({Key? key}) : super(key: key);

  @override
  State<NestedListScreen> createState() => _NestedListScreenState();
}

class _NestedListScreenState extends State<NestedListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: nestedData.length,
          itemBuilder: (_, index) {
            if (nestedData[index] is ImageComponent) {
              final imageData = nestedData[index] as ImageComponent;
              return SingleBannerWidget(imageData: imageData);
            } else if (nestedData[index] is VideoComp) {
              final videoComp = nestedData[index] as VideoComp;
              return  VideoWidget(url: videoComp.videoUrl,);
            } else if (nestedData[index] is HorizontalComponent) {
              final horizontalComp = nestedData[index] as HorizontalComponent;
              return HorizontalListWidget(horizontalComp: horizontalComp);
            } else if (nestedData[index] is ParaComponent) {
              final paraData = nestedData[index] as ParaComponent;
              return Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      paraData.title,
                      style: const TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: paraData.paraSubComponents.length,
                      itemBuilder: (_, index) => Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: FadeInImage(
                              placeholder: MemoryImage(kTransparentImage),
                              image: NetworkImage(
                                  paraData.paraSubComponents[index].imageUrl),
                              fit: BoxFit.cover,
                              height: 150,
                              width: double.infinity,
                            ),
                          ),
                          Text(
                            paraData.paraSubComponents[index].subcomponentTitle,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.deepPurpleAccent),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}

