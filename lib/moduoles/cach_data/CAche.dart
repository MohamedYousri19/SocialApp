import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'dart:convert';

class ImageLoader extends StatefulWidget {
  @override
  _ImageLoaderState createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  File? imageFile;
  String apiUrl = 'https://newsapi.org/v2/everything?q=tesla&from=2024-04-26&sortBy=publishedAt&apiKey=d50f0e513f80449d979f9d24bcf9d084'; // رابط API للحصول على رابط الصورة

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = path.join(directory.path, 'downloaded_image.jpg');
    final file = File(filePath);

    if (await file.exists()) {
      setState(() {
        imageFile = file;
      });
      updateImage(file);
    } else {
      await downloadImage(file);
      setState(() {
        imageFile = file;
      });
    }
  }

  Future<void> downloadImage(File file) async {
    final imageUrl = await fetchImageUrl();
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      await file.writeAsBytes(response.bodyBytes);
    }
  }

  Future<void> updateImage(File file) async {
    final imageUrl = await fetchImageUrl();
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      await file.writeAsBytes(response.bodyBytes);
      setState(() {
        imageFile = file;
      });
    }
  }

  Future<String> fetchImageUrl() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['articles']['urlToImage'];
    } else {
      throw Exception('Failed to load image URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Loader'),
      ),
       body:Center(
        child: imageFile != null
            ? Image.file(imageFile!)
            : CircularProgressIndicator(),
      ),
    );
  }
}


