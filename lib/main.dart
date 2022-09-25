import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:do_you_remember/providers/places.dart';
import 'package:do_you_remember/screens/places_list_screen.dart';
import 'package:do_you_remember/screens/add_place_screen.dart';
import 'package:flutter/services.dart';
import 'package:do_you_remember/screens/insert_details_page.dart';
import 'package:do_you_remember/screens/details_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
          InsertDetailsPage.routeName: (context) => InsertDetailsPage(),
        },
      ),
    );
  }
}

