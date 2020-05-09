import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quickscan/services/file_utils.dart';

class Save extends StatefulWidget {
  @override
  _SaveState createState() => _SaveState();
}

class _SaveState extends State<Save> {@override

  List<File> pictures = List<File>();
  double ang = 0;
  final myController = TextEditingController(text: DateTime.now().toString());

  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    pictures.add(args['image']);
    ang = args['angle'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Save'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              FileUtils.savePDF(pictures, myController.text, ang);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: Icon(Icons.check_circle),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Text('File Name:'),
          TextField(
            controller: myController,
          ),
          Flexible(
            child: ListView.builder(
              itemCount: pictures.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Transform.rotate(
                      child: Image.file(pictures[index]),
                      angle: ang
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
