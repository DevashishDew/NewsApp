class NewsFeed {
  final String imageUrl;
  final String imageLocalUrl;
  final String newsTitle;
  final String newsContent;
  final String videoUrl;

  NewsFeed({
    required this.imageUrl,
    required this.imageLocalUrl,
    required this.newsTitle,
    required this.newsContent,
    required this.videoUrl,
  });
}

final dummyNewsFeed = [
  NewsFeed(
    imageUrl:
        'https://farm2.staticflickr.com/1533/26541536141_41abe98db3_z_d.jpg',
    imageLocalUrl:
        'https://farm2.staticflickr.com/1533/26541536141_41abe98db3_z_d.jpg',
    newsTitle: 'News Title',
    newsContent: 'fvmnflnlfkb blfnbfnbfb fbnfbfbf bf bof',
    videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
  ),
  NewsFeed(
    imageUrl:
    'https://farm2.staticflickr.com/1533/26541536141_41abe98db3_z_d.jpg',
    imageLocalUrl:
    'https://farm2.staticflickr.com/1533/26541536141_41abe98db3_z_d.jpg',
    newsTitle: 'News Title',
    newsContent: 'fvmnflnlfkb blfnbfnbfb fbnfbfbf bf bof',
    videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
  ),
];
