import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        // while connection state in waiting we show loading indicator
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting 
        ? Center(
          child: CircularProgressIndicator(),
        ) 
        : Consumer<GreatPlaces>(
          child: Center(
            child: Text('Got no places yet!'),
          ),          // greatPlaces the object given by provider having GreatPlaces functions and data
          builder: (ctx, greatPlaces, child) => greatPlaces.items.length <= 0 
          ? child 
          : ListView.builder(
            itemCount: greatPlaces.items.length,
            itemBuilder: (ctx, index) => ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(greatPlaces.items[index].image), // seting the file image
              ),
              title: Text(greatPlaces.items[index].title),
              onTap: () {
                // Go to detail page
              },
            ),
          ),
        ),
      ),
    );
  }
}
