import 'package:flutter/material.dart';
import 'package:news_app/data/models/news_feed.dart';
import 'package:news_app/presentation/screens/add_new_news.dart';
import 'package:news_app/presentation/widgets/feed_item.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  List<NewsFeed> newsList = dummyNewsFeed;

  void _goToAddNewsScreen() async {
    final newsFeed = await Navigator.of(context)
        .push<NewsFeed>(MaterialPageRoute(builder: (ctx) => const AddNewsScreen()));

    if (newsFeed != null) {
      setState(() {
        newsList.insert(0,newsFeed);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (_, index) => FeedItem(newsFeed: newsList[index]),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: ElevatedButton(
            onPressed: _goToAddNewsScreen,
            child: Text('Add'),
          ),
        ),
      ],
    );
  }
}
