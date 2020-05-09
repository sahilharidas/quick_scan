import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickscan/services/FileObj.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math' as math;

class FileUtils {

  static Future<List<FileSystemEntity>> get getFiles async {
    //final directory = await getApplicationDocumentsDirectory();
    final directory = new Directory(await getFilePath);
    List<FileSystemEntity> _images = directory.listSync(recursive: true, followLinks: false);
    //print(_images);

    List<File> files = List<File>();
    for (int i = 0; i < _images.length; i++) {
      if (_images[i] is File && ((_images[i].toString().contains('.pdf')))) {
        File f = _images[i] as File;
        files.add(f);
        //files.add(new FileObj(name: f.toString(), size: f.lengthSync(), time: f.lastModifiedSync().toIso8601String()));
      }
    }
    return files;
  }

  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    Directory rootDir = new Directory('${directory.path}/Documents');
    if (!rootDir.existsSync()) {
      await rootDir.create(recursive: true);
    }
    return rootDir.path;
  }

  static Future<void> saveFile(File image, String name) async {
    final path = await getFilePath;
    final fileName = name;
    final File newImage = await image.copy('$path/$fileName.png');
  }

  static Future<Widget> openPDF(File file) async {
    final pdf = pw.Document();
    final image = PdfImage.file(
      pdf.document,
      bytes: file.readAsBytesSync(),
    );

    pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(image),
          ); // Center
        })); // Page
  }

  static Future<void> savePDF(List<File> pictures, String name, double angle) async {
    final path = await getFilePath;
    final fileName = name;
    final pdf = pw.Document();
    final file = File('$path/$fileName.pdf');

    for (File picture in pictures) {
      final image = PdfImage.file(
        pdf.document,
        bytes: picture.readAsBytesSync(),
      );

      pdf.addPage(pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Transform.rotate(
                child: pw.Image(
                    image,
                  fit: pw.BoxFit.fill,
                ),
                  angle: -angle,
              ),
            ); // Center
          })); // Page
    }

    await file.writeAsBytes(pdf.save());
  }

  static Future<void> renameFile(File f, String fileName) async {
    final path = await getFilePath;
    await f.rename('$path/$fileName.pdf');
  }

  static Future<File> getFileShort(String fileName) async {
    final path = await getFilePath;
    return File('$path/$fileName.pdf');
  }

  static Future<bool>  doesFileExist(String fileName) async {
    final path = await getFilePath;
    if (await File('$path/$fileName.pdf').exists()) {
      return true;
    } else {
      return false;
    }

  }

}