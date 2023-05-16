import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:news_app/data/models/news_feed.dart';
import 'package:permission_handler/permission_handler.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({super.key});

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  String title = "";
  late File imagefile;

  Future<bool> _requestPermission() async {
    Map<Permission, PermissionStatus> result =
        await [Permission.storage, Permission.camera].request();
    if (result[Permission.storage] == PermissionStatus.granted &&
        result[Permission.camera] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<File?> _getImage(ImageSource source) async {
    final bool isGranted = await _requestPermission();
    if (!isGranted) {
      return null;
    }
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        imagefile = File(image.path);
        imagepath = image.path;
      });
    }
    return null;
  }

  _cropImage() async {
    File? croppedfile = await ImageCropper().cropImage(
        sourcePath: imagepath,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Image Cropper',
          toolbarColor: Colors.deepPurpleAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedfile != null) {
      imagefile = croppedfile;
      imagepath = croppedfile.path;
      setState(() {});
    } else {
      print("Image is not cropped.");
    }
  }

  _saveImage() async {
    Uint8List bytes = await imagefile.readAsBytes();
    var result = await ImageGallerySaver.saveImage(bytes,
        quality: 80, name: getRandomString(8));
    if (result["isSuccess"] == true) {
      print("Image saved successfully.");
      _saveNewsandGoBack(result["filePath"]);
    } else {
      print(result["errorMessage"]);
    }
  }

  Future<bool> _saveNewsandGoBack(String localImageUrl) async {
    const filePrefix = 'file:///';
    if (localImageUrl.startsWith(filePrefix)) {
      localImageUrl = localImageUrl.replaceAll(filePrefix, '');
    }
    Navigator.of(context).pop(NewsFeed(
      imageUrl: '',
      imageLocalUrl: localImageUrl,
      newsTitle: title,
      newsContent: '',
      videoUrl: '',
    ));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  maxLength: 80,
                  maxLines: 5,
                  minLines: 1,
                  decoration: const InputDecoration(
                      label: Text('Title'), border: OutlineInputBorder()),
                  onChanged: (value) {
                    title = value!;
                  },
                ),
                imagepath != ""
                    ? Image.file(
                        imagefile,
                        width: double.infinity,
                        height: 250,
                      )
                    : Container(
                        child: const Text("No Image selected."),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //open button ----------------
                    ElevatedButton(
                        onPressed: () {
                          _getImage(ImageSource.gallery);
                        },
                        child: const Text("Open Image")),

                    //crop button --------------------
                    imagepath != ""
                        ? ElevatedButton(
                            onPressed: () {
                              _cropImage();
                            },
                            child: const Text("Crop Image"))
                        : Container(),

                    //save button -------------------
                    imagepath != ""
                        ? ElevatedButton(
                            onPressed: _saveImage,
                            child: const Text("Save Image"))
                        : Container(),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
