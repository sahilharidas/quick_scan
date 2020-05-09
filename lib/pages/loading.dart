import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quickscan/services/file_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quickscan/services/FileObj.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupFiles() async {
    List<File> files = await FileUtils.getFiles;
    Navigator.pushReplacementNamed(context, '/home', arguments: files);
  }

  @override
  void initState() {
    super.initState();
    setupFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: Center(
          child: SpinKitCubeGrid(
            color: Colors.white,
            size: 80.0,
          ),
      )
    );
  }
}
