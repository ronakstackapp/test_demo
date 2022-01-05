import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

String? imageUrl;

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}
class _ImageUploadState extends State<ImageUpload> {
  bool isImg =false;


  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
      print("image----->>${image.path}");
      var file = File(image.path);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _firebaseStorage.ref()
            .child('images/imageName')
            .putFile(file).whenComplete(() => print("Done------------>>>>"));
        var downloadUrl = await snapshot.ref.getDownloadURL();
        print("image-----downloadUrl>>$downloadUrl");
        setState(() {
          imageUrl = downloadUrl;
          isImg = false;
          Navigator.pop(context);
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Upload Image',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                // height: 350,
                //   width: 350,
                height: 150,
                  width: 150,
                  margin: const EdgeInsets.all(15),
                  padding:const  EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.white),
                    boxShadow: const[
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        spreadRadius: 2,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child:
                  isImg ? const Center(child:  CircularProgressIndicator()) :
                  (imageUrl != null)
                      ? Image.network(imageUrl!)
                      : Image.network('https://i.imgur.com/sUFH1Aq.png')
              ),
              const SizedBox(height: 20.0,),
              RaisedButton(
                child:const  Text("Upload Image", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                onPressed: (){
                  uploadImage();
                  setState(() {
                    isImg = true;
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side:const BorderSide(color: Colors.blue)
                ),
                elevation: 5.0,
                color: Colors.blue,
                textColor: Colors.white,
                padding:const EdgeInsets.fromLTRB(15, 15, 15, 15),
                splashColor: Colors.grey,
              ),
            ],
          ),
        ),
      ),);
  }
}
