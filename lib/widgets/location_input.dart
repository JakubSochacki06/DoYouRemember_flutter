import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:do_you_remember/screens/insert_details_page.dart';

const kgeoapifyApiKey = 'a24413ce7dc04eecb9a0f316e505fa15';

class LocationInput extends StatefulWidget {
  LocationInput({required this.locationDataCallback});
  final locationDataCallback;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  List<String> nameDetails = [];
  String? confidence;
  bool confidenceVisible = false;

  Future<void> _getCurrentUserLocation() async {
    bool confidenceVisible = false;
    final locData = await Location().getLocation();
    setState(() {
      _previewImageUrl =
          'https://maps.geoapify.com/v1/staticmap?style=osm-carto&width=600&height=400&center=lonlat:${locData.longitude},${locData.latitude}&zoom=15&marker=lonlat:${locData.longitude},${locData.latitude};type:material;color:%23ff3421;icontype:awesome&apiKey=$kgeoapifyApiKey';
    });
    http.Response response = await http.get(
      Uri.parse('https://api.geoapify.com/v1/geocode/reverse?lat=${locData.latitude}&lon=${locData.longitude}&format=json&apiKey=$kgeoapifyApiKey')
    );
    if (response.statusCode == 200){
      String data = response.body;
      widget.locationDataCallback(locData.latitude, locData.longitude, '${jsonDecode(data)['results'][0]['street']} ${jsonDecode(data)['results'][0]['housenumber']}');
    }
  }

  Future<void> _getLocationWithDetails(List<String> data) async {
    http.Response response = await http.get(
      Uri.parse(
          'https://api.geoapify.com/v1/geocode/search?housenumber=${data[1]}&street=${data[4]}&postcode=${data[2]}&city=${data[5]}&state=${data[3]}&country=${data[6]}&format=json&apiKey=$kgeoapifyApiKey'),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      String lat = jsonDecode(data)['results'][0]['lat'].toString();
      String lon = jsonDecode(data)['results'][0]['lon'].toString();
      confidence =
          (jsonDecode(data)['results'][0]['rank']['confidence'] * 100).toString();
      confidenceVisible = true;
      setState(() {
        _previewImageUrl =
            'https://maps.geoapify.com/v1/staticmap?style=osm-carto&width=600&height=400&center=lonlat:$lon,$lat&zoom=15&marker=lonlat:$lon,$lat;type:material;color:%23ff3421;icontype:awesome&apiKey=$kgeoapifyApiKey';
      });
      widget.locationDataCallback(jsonDecode(data)['results'][0]['lat'], jsonDecode(data)['results'][0]['lon'], '${data[4]}${data[1]}');
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170.0,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey)),
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(height: 10.0,),
        Visibility(
          visible: confidenceVisible,
          child: Center(
            child: Text('Confidence : $confidence%'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text(
                'Current Location',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: _getCurrentUserLocation,
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              onPressed: () async {
                List<String> dataList = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return InsertDetailsPage();
                    },
                  ),
                );
                nameDetails = dataList;
                _getLocationWithDetails(nameDetails);
              },
              label: Text('Insert Details'),
            ),
          ],
        ),
      ],
    );
  }
}
