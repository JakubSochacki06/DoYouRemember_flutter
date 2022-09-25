import 'package:flutter/material.dart';

class InsertDetailsPage extends StatelessWidget {
  static const routeName = '/insert-details';
  List<String> dataList = [];
  String? nameText;
  String? houseNumberText;
  String? postCodeText;
  String? stateText;
  String? streetText;
  String? cityText;
  String? countryText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //TODO: Add name parameter, so it can search via name
              Column(
                children: [
                  // Text('test')
                  Container(
                    width: 140,
                    height: 50,
                    child: TextField(
                      onChanged: (value){houseNumberText = value;},
                      textAlign: TextAlign.center,
                      decoration:
                      InputDecoration(hintText: 'House Number'),
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 50,
                    child: TextField(
                      onChanged: (value){postCodeText = value;},
                      textAlign: TextAlign.center,
                      decoration:
                      InputDecoration(hintText: 'Postcode'),
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 50,
                    child: TextField(
                      onChanged: (value){stateText = value;},
                      textAlign: TextAlign.center,
                      decoration:
                      InputDecoration(hintText: 'State'),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 140,
                    height: 50,
                    child: TextField(
                      onChanged: (value){streetText = value;},
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Street',
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 50,
                    child: TextField(
                      onChanged: (value){cityText = value;},
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(hintText: 'City'),
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 50,
                    child: TextField(
                      onChanged: (value){countryText = value;},
                      textAlign: TextAlign.center,
                      decoration:
                      InputDecoration(hintText: 'Country'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 275,
            child: TextField(
              onChanged: (value){nameText = value;},
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: 'Name'),
            ),
          ),
          TextButton(onPressed: (){
            dataList = [nameText!, houseNumberText!, postCodeText!, stateText!, streetText!, cityText!, countryText!];
            Navigator.pop(context, dataList);
            }, child: Text('Confirm'))
        ],
      ),
    );
  }
}
