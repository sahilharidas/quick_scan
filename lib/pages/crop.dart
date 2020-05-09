import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class Crop extends StatefulWidget {

  //Crop({Key key, @required this.picture}) : super(key: key);

  @override
  _CropState createState() => _CropState();
}

class _CropState extends State<Crop> {

  double ang = 0.0;

  @override
  Widget build(BuildContext context) {
    final File picture = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop and Rotate'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/save', arguments: {'image': picture, 'angle': ang});
            },
            icon: Icon(Icons.check_circle),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Transform.rotate(
                angle: ang,
                child: Image.file(
                  picture,
                  fit: BoxFit.fill,
                  //width: double.maxFinite,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.rotate_left, size: 60,),
                    Text('Rotate Left'),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    ang -= math.pi / 2;
                  });
                },
              ),
              FlatButton(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.rotate_right, size: 60,),
                    Text('Rotate Right'),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    ang += math.pi / 2;
                  });
                },
              ),
              FlatButton(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.crop, size: 60,),
                    Text('Crop'),
                  ],
                ),
                onPressed: () {
                  ang -= math.pi / 2;
                  },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
