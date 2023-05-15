import 'package:flutter/material.dart';
import 'package:news_app/data/models/my_posts.dart';
import 'package:news_app/data/network/http_service.dart';
import 'package:news_app/presentation/screens/news_details_screen.dart';
import 'package:news_app/presentation/widgets/news_item.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  int _page = 0;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  List<MyPosts> _posts = [];

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 350) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      HttpService().fetchPosts(_page).then((value) {
        if (value.isNotEmpty) {
          setState(() {
            _posts.addAll(value);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
        setState(() {
          _isLoadMoreRunning = false;
        });
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    HttpService().fetchPosts(_page).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          print(value.toString());
          _posts = value;
          _isFirstLoadRunning = false;
        });
      }
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return _isFirstLoadRunning
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _posts.length,
                  controller: _controller,
                  itemBuilder: (_, index) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => NewsDetailsScreen(
                            imageUrl:
                                'https://farm2.staticflickr.com/1533/26541536141_41abe98db3_z_d.jpg',
                            title: _posts[index].title ?? '',
                            body: _posts[index].body ?? '',
                          ),
                        ),
                      );
                    },
                    child: NewsItem(
                      imageUrl:
                          'https://farm2.staticflickr.com/1533/26541536141_41abe98db3_z_d.jpg',
                      title: _posts[index].title ?? '',
                      body: _posts[index].body ?? '',
                    ),
                  ),
                ),
              ),
              if (_isLoadMoreRunning == true)
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 40),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (_hasNextPage == false)
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  color: Colors.amber,
                  child: const Center(
                    child: Text('All content fetched'),
                  ),
                ),
            ],
          );
  }
}
