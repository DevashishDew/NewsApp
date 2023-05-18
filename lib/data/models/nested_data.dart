abstract class NestedData {}

class ImageComponent extends NestedData {
  ImageComponent(this.imageTitle, this.imageUrl);

  final String imageTitle;
  final String imageUrl;
}

class ParaComponent extends NestedData {
  ParaComponent(this.title, this.paraSubComponents);

  final String title;
  final List<ParaSubComponents> paraSubComponents;
}

class ParaSubComponents {
  final String subcomponentTitle;
  final String imageUrl;

  ParaSubComponents(this.subcomponentTitle, this.imageUrl);
}

class HorizontalComponent extends NestedData {
  final List<HorizontalSubComponent> horizontalsubcomp;

  HorizontalComponent(this.horizontalsubcomp);
}

class HorizontalSubComponent {
  HorizontalSubComponent(this.title, this.imageUrl);

  final String title;
  final String imageUrl;
}

class VideoComp extends NestedData {
  final String videoUrl;

  VideoComp(this.videoUrl);
}

final List<NestedData> nestedData = [
  ImageComponent('imageTitle',
      'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg'),
  VideoComp(
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
  HorizontalComponent([
    HorizontalSubComponent('Title',
        'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
    HorizontalSubComponent('Title',
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg'),
    HorizontalSubComponent('Title',
        'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
    HorizontalSubComponent('Title',
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg'),
    HorizontalSubComponent('Title',
        'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
  ]),
  ParaComponent(
    'ParaTitle',
    [
      ParaSubComponents('Subtitle',
          'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
      ParaSubComponents('Subtitle',
          'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
      ParaSubComponents('Subtitle',
          'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
      ParaSubComponents('Subtitle',
          'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
      ParaSubComponents('Subtitle',
          'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
      ParaSubComponents('Subtitle',
          'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
      ParaSubComponents('Subtitle',
          'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
      ParaSubComponents('Subtitle',
          'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
      ParaSubComponents('Subtitle',
          'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
      ParaSubComponents('Subtitle',
          'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
      ParaSubComponents('Subtitle',
          'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
      ParaSubComponents('Subtitle',
          'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
    ],
  ),
];
