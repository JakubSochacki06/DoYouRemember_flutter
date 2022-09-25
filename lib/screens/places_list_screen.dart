import 'package:flutter/material.dart';
import 'package:do_you_remember/screens/add_place_screen.dart';
import 'package:provider/provider.dart';
import 'package:do_you_remember/providers/places.dart';
import 'package:do_you_remember/widgets/memory_card.dart';
import 'package:do_you_remember/screens/details_page.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7E7E7),
      appBar: AppBar(
        backgroundColor: Color(0xFFE7E7E7),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Text(
              'Your memories',
              style: TextStyle(
                color: Colors.black45
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            color: Colors.black45,
            onPressed: () {
              Navigator.pushNamed(context, AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator(),) : Consumer<Places>(
          builder: (context, Places, ch) => Places.items.length <= 0 ? ch! : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: Places.items.length,
            itemBuilder: (context, i) => MemoryCard(
              date: Places.items[i].id.substring(0,10),
              image: Places.items[i].image,
              title: Text(Places.items[i].title),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DetailsPage(lat: Places.items[i].location.latitude, long: Places.items[i].location.longitude, address: Places.items[i].location.address, date: Places.items[i].id.substring(0,10), image: Places.items[i].image, title: Places.items[i].title,);
                    },
                  ),
                );
                print(
                  '${Places.items[i].location.address} ${Places.items[i].location.longitude} ${Places.items[i].location.latitude} ${Places.items[i].id.substring(0,10)} ${Places.items[i].image} ${Places.items[i].title}'
                );
              },
            ),
          ),
          child: Center(
            child: Text('Got no places yet, start adding some!'),
          ),
        ),
      ),
    );
  }
}
