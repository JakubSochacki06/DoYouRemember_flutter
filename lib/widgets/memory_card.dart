import 'dart:io';
import 'package:flutter/material.dart';

class MemoryCard extends StatelessWidget {
  MemoryCard(
      {required this.image,
      required this.title,
      required this.date,
      required this.onTap});
  final File? image;
  final Text? title;
  final String? date;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(1, 3), // changes position of shadow
          ),]
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: FileImage(image!),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
            title!,
            Text(date!),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
