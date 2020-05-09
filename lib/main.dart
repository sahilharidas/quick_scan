import 'package:flutter/material.dart';
import 'package:quickscan/pages/home.dart';
import 'package:quickscan/pages/settings.dart';
import 'package:quickscan/pages/crop.dart';
import 'package:quickscan/pages/filter.dart';
import 'package:quickscan/pages/save.dart';
import 'package:quickscan/pages/loading.dart';
import 'package:quickscan/pages/viewer.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/':  (context) => Loading(),
    '/home': (context) => Home(),
    '/settings': (context) => Settings(),
    '/crop': (context) => Crop(),
    '/filter': (context) => Filter(),
    '/save': (context) => Save(),
    '/view': (context) => Viewer(),
  },
));