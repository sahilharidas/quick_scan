import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class Viewer extends StatefulWidget {
  @override
  _ViewerState createState() => _ViewerState();
}

class _ViewerState extends State<Viewer> {
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    final File picture = args['file'];
    final String fileName = args['name'];
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text(fileName),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        elevation: 0,
        actions: <Widget>[
        ],
      ),
      path: picture.path,
//      body: Center(
//        child: Image.file(
//          picture,
//          fit: BoxFit.cover,
//          height: double.infinity,
//          width: double.infinity,
//        ),
//      ),
    );
  }
}
