import 'package:flutter/material.dart';
import 'package:do_you_remember/models/place.dart';
import 'dart:io';
import 'package:do_you_remember/helpers/db_helper.dart';
import 'dart:developer';

class Places extends ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return _items;
    // return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage, String address, double latitude, double longitude) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        title: pickedTitle,
        location: PlaceLocation(
          address: address,
          latitude: latitude,
          longitude: longitude,
        ));
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'address': newPlace.location.address,
        'latitude': newPlace.location.latitude,
        'longitude': newPlace.location.longitude,
      },
    );
  }

  void deleteMemory(int index) async{
    _items = _items..removeAt(index);
    notifyListeners();
  }

  Future<void> fetchAndSetPlaces() async{
    final datalist = await DBHelper.getData('user_places');
    _items = datalist.map((item) => Place(id: item['id'], title: item['title'], image: File(item['image']), location: PlaceLocation(address: item['address'], longitude:item['longitude'], latitude: item['latitude']) ),).toList();
    notifyListeners();
  }
}
