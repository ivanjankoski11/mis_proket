import 'package:flutter/material.dart';

class ImageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  @override
  final List<String> imageUrls = [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
    'https://example.com/image3.jpg',
    // Add more image URLs as needed
  ];

  Widget build(BuildContext context) {
    return Container(
      height: 100.0, // Adjust the height as needed
      child: Text("Heloo")
    );
  }
}
