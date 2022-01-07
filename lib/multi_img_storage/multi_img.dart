import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'uploadtask_listtile_common_widget.dart';






class UploadMultipleImageDemo extends StatefulWidget {


  final String title = 'Firebase Storage';

  @override
  UploadMultipleImageDemoState createState() => UploadMultipleImageDemoState();
}

class UploadMultipleImageDemoState extends State<UploadMultipleImageDemo> {
  //
  String? _path;

//  Map<String, String>? _paths;
  List<PlatformFile>?   _paths;
  String? _extension;
  FileType? _pickType;
  bool _multiPick = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<firebase_storage.UploadTask> _tasks = <firebase_storage.UploadTask>[];

  @override
  void initState() {
    // TODO: implement initState
  //  getFireStorageData();
  //  listExample();
    super.initState();
  }


    // Future<void> listExample() async {
    //   firebase_storage.ListResult  result = (await firebase_storage
    //       .FirebaseStorage.instance
    //       .ref()
    //       .listAll());
    //
    //   _tasks = result as List<firebase_storage.UploadTask>;
    //
    // }




  void openFileExplorer() async {
    print("openFileExplorer --- _pickType --->$_pickType");
    print("openFileExplorer --- _extension --->$_extension");
    try {
      _paths = null;
      if (_multiPick) {
        print("openFileExplorer --- _pickType$_multiPick --->$_pickType");
        _paths = (await FilePicker.platform.pickFiles(
          type: _pickType!,
          allowMultiple: _multiPick,

          onFileLoading: (FilePickerStatus status) => print(status),
          // allowedExtensions: (_extension?.isNotEmpty ?? false)
          //     ? _extension?.replaceAll(' ', '').split(',')
          //     : null,
        ))
            ?.files;
      } else {
        _paths = (await FilePicker.platform.pickFiles(
          type: _pickType!,
          onFileLoading: (FilePickerStatus status) => print(status),
          // allowedExtensions: (_extension?.isNotEmpty ?? false)
          //     ? _extension?.replaceAll(' ', '').split(',')
          //     : null,
        ))
            ?.files;
      }
      print("singlr img *****$_paths");
      print("singlr img *****${_paths![0].name}");
      print("singlr img *****${_paths![0].path}");
      uploadToFirebase();
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
  }


  uploadToFirebase() {
    if (_multiPick) {
      // _paths!.forEach((fileName, filePath) => {upload(fileName, filePath)});
      _paths!.forEach((element) {
        print("uploadToFirebase **** *${element.name}");
        upload(element.name, element.path);
      });
    } else {
      String fileName = _paths![0].name;
      String filePath = _paths![0].path!;
      upload(fileName, filePath);
    }
  }

  upload(fileName, filePath) async {
    _extension = fileName
        .toString()
        .split('.')
        .last;

    firebase_storage.Reference storageRef =
    FirebaseStorage.instance.ref().child(fileName);
    final firebase_storage.UploadTask uploadTask = storageRef.putFile(
      File(filePath),
      firebase_storage.SettableMetadata(
        contentType: '$_pickType/$_extension',
      ),
    );
    setState(() {
      _tasks.add(uploadTask);
    });
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    // prefs.setString("test", )
  }

  dropDown() {
    return DropdownButton<dynamic>(
      hint: const Text('Select'),
      value: _pickType,
      items: const <DropdownMenuItem>[
        DropdownMenuItem(
          child: Text('Audio'),
          value: FileType.audio,
        ),
        DropdownMenuItem(
          child: Text('Image'),
          value: FileType.image,
        ),
        DropdownMenuItem(
          child: Text('Video'),
          value: FileType.video,
        ),
        DropdownMenuItem(
          child: Text('Any'),
          value: FileType.any,
        ),
      ],
      onChanged: (value) =>
          setState(() {
            _pickType = value;
          }),
    );
  }

  // String _bytesTransferred(StorageTaskSnapshot snapshot) {
  //   return '${snapshot.bytesTransferred}/${snapshot.totalByteCount}';
  // }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    _tasks.forEach((firebase_storage.UploadTask task) {
      final Widget tile = UploadTaskListTile(
        task: task,
        onDismissed: () async {
          ///Delete_in_firebase_storage
          await FirebaseStorage.instance.ref()
              .child(task.snapshot.ref.name)
              .delete();

          print("UploadTaskListTile ~~ 1 ~~${task.snapshot.ref.name}");
          setState(() => _tasks.remove(task));
        },
        onDownload: () => downloadFile(task.snapshot.ref),
      );
      children.add(tile);
    });

    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              dropDown(),
              SwitchListTile.adaptive(
                title: const Text(
                    'Pick multiple files', textAlign: TextAlign.left),
                onChanged: (bool value) => setState(() => _multiPick = value),
                value: _multiPick,
              ),
              OutlineButton(
                onPressed: () => openFileExplorer(),
                child: const Text("Open file picker"),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Flexible(
                child: ListView(
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> downloadFile(firebase_storage.Reference ref) async {
    final String url = await ref.getDownloadURL();


    final http.Response downloadData = await http.get(Uri.parse(url));
    final Directory systemTempDir = Directory.systemTemp;
    final File tempFile = File('${systemTempDir.path}/tmp.jpg');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.create();
    //  firebase_storage.DownloadTask task = ref.writeToFile(tempFile);
    // final int byteCount = (await task.future).totalByteCount;
    var bodyBytes = downloadData.bodyBytes;
    final String name = await ref.name;
    final String path = await ref.fullPath;
    print(
      'Success!\nDownloaded $name \nUrl: $url'
          '\npath: $path ',
      // '\nBytes Count :: $byteCount',
    );
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Image.memory(
          bodyBytes,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

