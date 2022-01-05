import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadTaskListTile extends StatelessWidget {
  const UploadTaskListTile(
      {Key? key, this.task, this.onDismissed, this.onDownload})
      : super(key: key);

  final firebase_storage.UploadTask? task;
  final VoidCallback? onDismissed;
  final VoidCallback? onDownload;



  String _bytesTransferred(firebase_storage.TaskSnapshot? snapshot) {
    return '${snapshot!.bytesTransferred}/${snapshot.totalBytes}';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<firebase_storage.TaskSnapshot>(
      stream: task!.snapshotEvents,
      builder: (BuildContext context,
          AsyncSnapshot<firebase_storage.TaskSnapshot> asyncSnapshot) {
        Widget subtitle;
        firebase_storage.TaskSnapshot? event = asyncSnapshot.data;
        firebase_storage.TaskState? state = event?.state;
        if (asyncSnapshot.hasData) {

          // final StorageTaskEvent event = asyncSnapshot.data;
          // final StorageTaskSnapshot snapshot = event.snapshot;
          subtitle = Text('$state: ${_bytesTransferred(event)} bytes sent');
        } else {
          subtitle = const Text('Starting...');
        }
        return Dismissible(
          dragStartBehavior: DragStartBehavior.start,
          background: Container(
            alignment: AlignmentDirectional.centerEnd,
            color: Colors.red,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
          key: Key(task.hashCode.toString()),
          onDismissed: (_) => onDismissed!(),
          child: ListTile(
            title: Text('Upload Task #${task.hashCode}'),
            subtitle: subtitle,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (state == firebase_storage.TaskState.running)
                  IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: task!.pause,
                  ),
                if (state == firebase_storage.TaskState.running)
                  IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: task!.cancel,
                  ),
                if (state == firebase_storage.TaskState.paused)
                  IconButton(
                    icon: const Icon(Icons.file_upload),
                    onPressed: task!.resume,
                  ),
                if (state == firebase_storage.TaskState.success)
                  IconButton(
                    icon: const Icon(Icons.file_download),
                    onPressed: onDownload,
                  ),
                // if (state == firebase_storage.TaskState.success)
                //   IconButton(
                //     icon: const Icon(Icons.link),
                //     onPressed: onDownloadLink,
                //   ),
              ],
            ),
          ),
        );
      },
    );
  }
}