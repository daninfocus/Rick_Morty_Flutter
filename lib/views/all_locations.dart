import 'package:flutter/material.dart';
import 'package:rick_morty/src/models/all_locations.dart';

import '../globals.dart';

class LocationListView extends StatelessWidget {
  const LocationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder<AllLocations>(
        future: locationClass.getAllLocations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Image(image: AssetImage('assets/loading.gif'));
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Error Loading Data.'));
          } else {
            var locations = snapshot.data!.results;
            return ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(locations[index].name,
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Column(
                    children: [
                      Text(
                        locations[index].type,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        locations[index].dimension,
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                      // for (var item in episodes[index].characters)
                      //   Text(
                      //     item,
                      //     style: TextStyle(color: Colors.white),
                      //   )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
