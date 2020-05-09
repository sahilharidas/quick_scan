import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:getflutter/getflutter.dart';
import 'package:quickscan/services/file_utils.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  File imageFile;
  final myController = TextEditingController();
  List<File> files;

  Future<void> openGallery() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    if (imageFile != null) {
      Navigator.pushNamed(context, '/crop', arguments: imageFile);
    }
  }

  Future<void> openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    if (imageFile != null) {
      Navigator.pushNamed(context, '/crop', arguments: imageFile);
    }
  }

  Widget listFiles() {
    if (files.length > 0) {
      return ListView.builder(
          itemCount: files.length,
          itemBuilder: (BuildContext context, int index) {

            File f = files[index];
            //Image filePreview = f.openRead().toString();
            String fileName = '$f'.substring(
                '$f'.lastIndexOf('/') + 1, '$f'.length - 1);
            print(fileName);
            String fileSize = '${((files[index].lengthSync() / (10.24 * 1024))
                .round() / 100)} MB';
            String fileModified = '${files[index].lastModifiedSync()}';
            fileModified = fileModified.substring(0, fileModified.length - 7);

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/view', arguments: {'file': f, 'name': fileName});
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
//                        leading: GFAvatar(
//                          shape: GFAvatarShape.standard,
//                          size: 70,
//                          backgroundColor: Colors.amberAccent,
//                        ),
                        title: Text('$fileName'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 6,),
                            Text('$fileSize'),
                            Text('$fileModified'),
                            Row(
                              children: <Widget>[
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.grey[600],),
                                  onPressed: () {
                                    return showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Center(child: Text('Delete')),
                                            content: Text(
                                                'The document cannot be recovered once deleted. Are you sure?'
                                            ),
                                            actions: [
                                              FlatButton(
                                                child: Text('No'),
                                                onPressed: () {
                                                  Navigator.of(context, rootNavigator: true).pop();
                                                },
                                              ),
                                              FlatButton(
                                                child: Text('Yes'),
                                                onPressed: () {
                                                  setState(() {
                                                    files.remove(f);
                                                    f.delete();
                                                  });
                                                  Navigator.of(context, rootNavigator: true).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        }
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.grey[600],),
                                  onPressed: () {
                                    return showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Enter new name...'),
                                            content: TextField(
                                              controller: myController,
                                            ),
                                            actions: [
                                              FlatButton(
                                                  child: Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context, rootNavigator: true).pop();
                                                },
                                              ),
                                              FlatButton(
                                                  child: Text('Confirm'),
                                                onPressed: () async {
                                                      Navigator
                                                          .pushReplacementNamed(
                                                          context, '/');
                                                      await FileUtils
                                                          .renameFile(
                                                          files[index],
                                                          myController.text);
                                                      myController.text = '';
//                                                  Navigator.of(context, rootNavigator: true).pop();
                                                      setState(() {});
                                                    }
                                              ),
                                            ],
                                          );
                                        }
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.share, color: Colors.grey[600],),
                                  onPressed: () async {
                                    final ByteData bytes = await rootBundle.load(f.path);
                                    Share.file(fileName, Path.basename(f.path), bytes.buffer.asUint8List(), 'application/pdf');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      );
    } else {
      return Center(
        child: CircleAvatar(
          radius: 50,
          child: Icon(
              Icons.picture_as_pdf,
            size: 75,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    files = ModalRoute.of(context).settings.arguments;
    //files = files.sublist(1, 4);
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick Scanner'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Options',
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue[400],
              ),
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            )
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: Icon(Icons.camera_alt),
              label: 'Camera',
              onTap: () {
                openCamera();
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.image),
              label: 'Gallery',
              onTap: () {
                openGallery();
              }
          ),
        ],
      ),
      body: Container(
        child:  listFiles()
      ),
    );
  }
}
