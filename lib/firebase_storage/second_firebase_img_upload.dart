//Caution: Only works on Android & iOS platforms
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

//void main() => runApp(MyApp());


final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);

class UploadingImageToFirebaseStorage extends StatefulWidget {
  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

class _UploadingImageToFirebaseStorageState
    extends State<UploadingImageToFirebaseStorage> {
  File? _imageFile;
  bool? isLoading = false;

  double? _progress;
  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    print("Upload Done ----0");
    // setState(() {
    //   isLoading = true;
    // });

    print("Upload Done --- 1");
    String fileName = basename(_imageFile!.path);
    firebase_storage.Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);


    uploadTask.snapshotEvents.listen((event) {
      print("Upload -- indicator --bytesTransferred- ${event.bytesTransferred.toDouble()}");
      print("Upload -- indicator --bytesTransferred- ${event}");
     // print("Upload -- indicator --- ${event.}");
      setState(() {
     //   isLoading = true;
        _progress =
           ( event.bytesTransferred.toDouble() / event.totalBytes.toDouble());
        print("Upload -- indicator --- ${_progress.toString()}");
      });
      if (event.state == TaskState.success) {
        // _progress = null;
      //  Fluttertoast.showToast(msg: 'File added to the library');
        print("File added to the library");
      }
    }).onError((error) {
      // do something to handle error
    });

    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
      print("Upload Done --- 2");
    });
    taskSnapshot.ref.getDownloadURL()
        .then(
          (value) {
            print("Done: $value");
            setState(() {
    _progress = null;
              isLoading = false;
            });

          }
    );
  }



  @override
  Widget build(BuildContext context) {
    print("asfsdavd -->>$_progress");
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    colors: [orange, yellow],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Uploading Image to Firebase Storage",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child:
                          _imageFile != null
                              ?   isLoading! ?const Center(child:  CircularProgressIndicator()):
                          InkWell(
                              onTap:pickImage,
                              child: Image.file(_imageFile!))
                              : FlatButton(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 50,
                            ),
                            onPressed: pickImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_progress != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: LinearProgressIndicator(
                      value: _progress,
                      minHeight: 2.0,
                      color: Colors.red,
                    ),
                  ),
                uploadImageButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [yellow, orange],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () => uploadImageToFirebase(context),
              child: Text(
                "Upload Image",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}