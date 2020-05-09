import 'dart:io';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {

  File picture;

  @override
  Widget build(BuildContext context) {
    final File picture = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Filter'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/save', arguments: picture);
            },
            icon: Icon(Icons.check_circle),
          ),
        ],
      ),
      body: Center(
        child: Image.file(
          picture,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
