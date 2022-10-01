import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:do_you_remember/providers/places.dart';

const kgeoapifyApiKey = 'a24413ce7dc04eecb9a0f316e505fa15';

class DetailsPage extends StatefulWidget {
  static const routeName = '/details-page';
  DetailsPage(
      {required this.lat,
      required this.long,
      required this.address,
      required this.image,
      required this.date,
      required this.title,
      required this.idFromList});
  final double lat;
  final double long;
  final String address;
  final File image;
  final String date;
  final String title;
  final int idFromList;
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
  Future<void> _deleteMemory()async{
    var decision = await Alert(
      context: context,
      type: AlertType.warning,
      title: "Are you sure?",
      desc: "Do you want to delete this memory?",
      buttons: [
        DialogButton(
          child: Text(
            "YES",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context, true),
          color: Colors.green.shade600,
        ),
        DialogButton(
          child: Text(
            "NO",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          color: Colors.red,
          onPressed: () => Navigator.pop(context, false),
        )
      ],
    ).show();
    if(decision!){
      Provider.of<Places>(context, listen: false).deleteMemory(widget.idFromList);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    _getMapImage();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(widget.image), fit: BoxFit.cover)),
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
            Text(widget.date.substring(0,10),
                style: TextStyle(
                  fontSize: 35,
                ),
                textAlign: TextAlign.center),
            ElevatedButton.icon(
              onPressed: _deleteMemory,
              icon: Icon(Icons.delete),
              label: Text('Delete place'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.secondary),
                  elevation: MaterialStateProperty.all<double>(0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            ),
          ],
        ),
      ),
    );
  }
}
