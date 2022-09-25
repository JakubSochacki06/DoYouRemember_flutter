import 'package:flutter/material.dart';
import 'package:do_you_remember/widgets/image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:do_you_remember/providers/places.dart';
import 'package:do_you_remember/widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  String? addressFromDetails;
  double? latFromDetails;
  double? longFromDetails;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      //TODO: add error message
      return;
    }
    Provider.of<Places>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
      addressFromDetails!,
      latFromDetails!,
      longFromDetails!,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ImageInput(
                      onSelectImage: _selectImage,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    LocationInput(
                      locationDataCallback: (lat, long, address) {
                        latFromDetails = lat;
                        longFromDetails = long;
                        addressFromDetails = address;
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('Add place'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.secondary),
                elevation: MaterialStateProperty.all<double>(0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          ),
        ],
      ),
    );
  }
}
