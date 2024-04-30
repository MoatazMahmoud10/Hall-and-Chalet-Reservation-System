import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  final String overview;
  final String details;
  final List image;

  const ItemDetails({super.key, required this.overview, required this.details, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
      Column(
        children: [
          Text(overview),
          Text(details),
        ],
      )
    );
  }
}