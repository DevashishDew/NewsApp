import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsScreen extends  StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  late File imagefile;

  Future<File?> _getImage(ImageSource source) async {
    final bool isGranted = await _requestPermission();
    if (!isGranted) {
      return null;
    }
    final ImagePicker _picker =   ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        imagefile =  File(image.path);
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
        )
    );

    if (croppedfile != null) {
      imagefile = croppedfile;
      setState(() { });
    } else{
      print("Image is not cropped.");
    }
  }

  _saveImage() async{
    Uint8List bytes = await imagefile.readAsBytes();
    var result = await ImageGallerySaver.saveImage(
        bytes,
        quality: 80,
        name: "my_mage.jpg"
    );
    if(result["isSuccess"] == true){
      print("Image saved successfully.");
    } else{
      print(result["errorMessage"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top:30),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                imagepath != "" ? Image.file(imagefile) :
                Container(
                  child: const Text("No Image selected."),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //open button ----------------
                    ElevatedButton(
                        onPressed: (){
                          _getImage(ImageSource.gallery);
                        },
                        child: const Text("Open Image")
                    ),

                    //crop button --------------------
                    imagepath != "" ? ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        onPressed: (){
                          _cropImage();
                        },
                        child: const Text("Crop Image")
                    ): Container(),

                    //save button -------------------
                    imagepath != "" ? ElevatedButton(
                        onPressed: () async {
                          Uint8List bytes = await imagefile.readAsBytes();
                          var result = await ImageGallerySaver.saveImage(
                              bytes,
                              quality: 60,
                              name: "new_mage.jpg"
                          );
                          print(result);
                          if(result["isSuccess"] == true){
                            print("Image saved successfully.");
                          }else{
                            print(result["errorMessage"]);
                          }
                        },
                        child: const Text("Save Image")
                    ): Container(),

                  ],

                )
              ],
            ),
          ),
        )
    );
  }
}

Future<bool> _requestPermission() async {
  Map<Permission, PermissionStatus> result =
  await [Permission.storage, Permission.camera].request();
  if (result[Permission.storage] == PermissionStatus.granted &&
      result[Permission.camera] == PermissionStatus.granted) {
    return true;
  }
  return false;
}