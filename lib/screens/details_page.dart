import 'package:flutter/material.dart';
import 'dart:io';

const kgeoapifyApiKey = 'a24413ce7dc04eecb9a0f316e505fa15';

class DetailsPage extends StatefulWidget {
  static const routeName = '/details-page';
  DetailsPage(
      {required this.lat,
      required this.long,
      required this.address,
      required this.image,
      required this.date,
      required this.title});
  final double lat;
  final double long;
  final String address;
  final File image;
  final String date;
  final String title;
  String? mapImageUrl;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Future<void> _getMapImage() async {
    setState(() {
      widget.mapImageUrl =
          'https://maps.geoapify.com/v1/staticmap?style=osm-carto&width=600&height=400&center=lonlat:${widget.long},${widget.lat}&zoom=15&marker=lonlat:${widget.long},${widget.lat};type:material;color:%23ff3421;icontype:awesome&apiKey=$kgeoapifyApiKey';
    });
  }

  @override
  Widget build(BuildContext context) {
    _getMapImage();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Do you remember?',
              style: TextStyle(
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            Text(widget.title,
                style: TextStyle(
                  fontSize: 35,
                ),
                textAlign: TextAlign.center),
            Text(widget.date,
                style: TextStyle(
                  fontSize: 35,
                ),
                textAlign: TextAlign.center),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(widget.image!), fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                height: 200,
                width: 200,
                child: Image.network(widget.mapImageUrl!)),
            Text(widget.address,
                style: TextStyle(
                  fontSize: 35,
                ),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
